#!/bin/bash

json=$(curl -fsSL "https://services.sonarr.tv/v1/releases" | jq '.["v4-stable"]')
version=$(jq -r '.version' <<< "${json}")
[[ -z ${version} ]] && exit 0
sbranch=$(jq -r '.branch' <<< "${json}")
[[ -z ${sbranch} ]] && exit 0
version_json=$(cat ./VERSION.json)
jq '.version = "'"${version}"'" | .sbranch = "'"${sbranch}"'"' <<< "${version_json}" > VERSION.json
