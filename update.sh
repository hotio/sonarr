#!/bin/bash

###################
version=$(curl -fsSL "https://services.sonarr.tv/v1/download/phantom-develop?version=3" | jq -r .version)
app=SONARR
###################

location=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${location}" || exit 1

find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG ${app}_VERSION=.*$/ARG ${app}_VERSION=${version}/g" {} \;
sed -i "s/{TAG_VERSION=.*}$/{TAG_VERSION=${version}}/g" .drone.yml

if [[ -n "$(git status --untracked-files=no --porcelain)" ]]; then
    git add ./*.Dockerfile
    git add ./.drone.yml
    git commit -m "Updated version to: ${version}"
    echo "Updated version to: ${version}"
else
    echo "Version is still: ${version}"
fi
