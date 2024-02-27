{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    wrangler-nixpkgs.url = "github:NixOS/nixpkgs/8dfad603247387df1df4826b8bea58efc5d012d8";
    systems.url = "github:nix-systems/default";
    forester.url = "sourcehut:~jonsterling/ocaml-forester";
    forest-server.url = "github:kentookura/forest-server";
  };
  outputs =
    { self
    , flake-utils
    , nixpkgs
    , wrangler-nixpkgs
    , systems
    , forester
    , forest-server
    }:
    flake-utils.lib.eachSystem (import systems)
    (system: let
      pkgs = import nixpkgs { inherit system; };
      wrangler-pkgs = import wrangler-nixpkgs { inherit system; };
      forester-pkg = forester.packages.${system}.default;
      default-tree = "bhf";
      tlDist = pkgs.texliveFull;
    in {
      packages = flake-utils.lib.flattenTree rec {
        new = pkgs.writeScriptBin "new"
        ''
          ${forester-pkg}/bin/forester new --dirs=trees --dest=trees --prefix=$1
        '';
        build = pkgs.writeScriptBin "build"
        ''
          ${forester-pkg}/bin/forester build --dev --root ${default-tree}-0001 trees/
        '';
        serve = pkgs.writeScriptBin "serve"
        ''
          ${pkgs.python3}/bin/python3 -m http.server -d output 8080
        '';
        forester-dev = pkgs.writeScriptBin "forester-dev"
        ''
          ${forest-server.packages.${system}.default}/bin/forest watch $@ -- "build --dev --root ${default-tree}-0001 trees/"
        '';

        default = pkgs.stdenv.mkDerivation {
          name = "localcharts-forest";
          src = ./.;
          buildInputs = [tlDist];
          buildPhase = ''
            ${forester-pkg}/bin/forester build --root ${default-tree}-0001 trees/
            mv output/ $out/
            mv _redirects $out
          '';
        };
      };

      devShells.shell-minimal = pkgs.mkShell {
        buildInputs = with pkgs; with self.packages.${system}; [
          forester-pkg new build serve
        ];
      };

      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; with self.packages.${system}; [
          forester-pkg new build serve
          forester-dev
          forest-server.packages.${system}.default
          tlDist
          fswatch
        ];
      };
    });
}
