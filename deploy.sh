#!/bin/bash
set -e

echo "Building site..."
forester build

# echo "Deploying to deploy branch..."
# git checkout deploy
# git rm -rf .
# git checkout master -- .
# cp -r output/* .
# rm -rf output/ build/ assets/ deploy.sh flake.nix forest.toml theme/ trees/

git add .
git commit -m "Deploy: $(date) ($(git rev-parse --short main))"
# git push origin deploy
git push origin master

# git checkout master
echo "Deployed successfully!"
