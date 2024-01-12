#!/bin/bash
json=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/sonarr/sonarr/releases")
version=$(jq -r .[0].tag_name <<< "${json}" | sed s/v//g)
[[ -z ${version} ]] && exit 0
version_json=$(cat ./VERSION.json)
jq '.version = "'"${version}"'"' <<< "${version_json}" > VERSION.json
