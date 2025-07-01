#!/bin/bash
set -e

echo "Building site..."
forester build

echo "Deploying to deploy branch..."
git checkout deploy
git rm -rf .
git checkout main -- output/
cp -r output/* .
rm -rf output/

git add .
git commit -m "Deploy: $(date) ($(git rev-parse --short main))"
git push origin deploy

git checkout main
echo "Deployed successfully!"
