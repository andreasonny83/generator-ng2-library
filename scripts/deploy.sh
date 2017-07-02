# Copyright (c) 2017 AndreaSonny <andreasonny83@gmail.com> (https://github.com/andreasonny83)
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

#!/bin/bash

# The script should immediately exit if any command in the script fails.
set -e

# Go to the project root directory
cd $(dirname ${0})/..

# VERSION_TYPE="${1:-patch}"

# Commit a new tag
# npm version ${VERSION_TYPE}
# git push origin master --tags

# Command line arguments.
COMMAND_ARGS=${*}

PACKAGE_VERSION=$(cat ./package.json \
  | grep version \
  | head -1 \
  | awk -F: '{ print $2 }' \
  | sed 's/[",]//g' \
  | tr -d '[[:space:]]')

echo "Deploying version: $PACKAGE_VERSION"

# Update the package.json version
sed -i "" "s/0.0.0-PLACEHOLDER/${PACKAGE_VERSION}/g" ./dist/package.json

# //registry.npmjs.org/:_authToken=d4c2d445-70cd-44ea-b9bf-f6404fbac6d8
NPM_TOKEN="d4c2d445-70cd-44ea-b9bf-f6404fbac6d8"
# //registry.npmjs.org/:_authToken=${NPM_TOKEN}

# Publish to NPM
cd ./dist
npm publish
