#!/bin/bash

version=$(curl -fsSL "https://services.sonarr.tv/v1/download/master" | jq -r .version)
[[ -z ${version} ]] && exit
find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG SONARR_VERSION=.*$/ARG SONARR_VERSION=${version}/g" {} \;
sed -i "s/{TAG_VERSION=.*}$/{TAG_VERSION=${version}}/g" .drone.yml
echo "##[set-output name=version;]${version}"
