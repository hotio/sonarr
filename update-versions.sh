#!/bin/bash
json=$(curl -fsSL "https://services.sonarr.tv/v1/releases" | jq '.["v4-nightly"]')
version=$(jq -r .version <<< "${json}" | sed s/v//g)
[[ -z ${version} ]] && exit 0
sbranch=$(jq -r .branch <<< "${json}")
[[ -z ${sbranch} ]] && exit 0
amd64_url=$(jq -r '.linuxMusl.x64.archive.url' <<< "${json}")
[[ -z ${amd64_url} ]] && exit 0
arm64_url=$(jq -r .linuxMusl.arm64.archive.url <<< "${json}")
[[ -z ${arm64_url} ]] && exit 0
old_version=$(jq -r '.version' < VERSION.json)
changelog=$(jq -r '.changelog' < VERSION.json)
[[ "${old_version}" != "${version}" ]] && changelog="https://github.com/sonarr/sonarr/compare/v${old_version}...v${version}"
version_json=$(cat ./VERSION.json)
jq '.version = "'"${version}"'" | .sbranch = "'"${sbranch}"'" | .amd64_url = "'"${amd64_url}"'" | .arm64_url = "'"${arm64_url}"'" | .changelog = "'"${changelog}"'"' <<< "${version_json}" > VERSION.json
