#!/bin/bash
response_json=$(curl -fsSL "https://services.sonarr.tv/v1/releases" | jq -e '.["v4-nightly"]') || exit 1
version=$(jq -re .version <<< "${response_json}")
sbranch=$(jq -re .branch <<< "${response_json}")
amd64_url=$(jq -re '.linuxMusl.x64.archive.url' <<< "${response_json}")
arm64_url=$(jq -re .linuxMusl.arm64.archive.url <<< "${response_json}")
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg sbranch "${sbranch}" \
    --arg amd64_url "${amd64_url}" \
    --arg arm64_url "${arm64_url}" \
    '.version = $version | .sbranch = $sbranch | .amd64_url = $amd64_url | .arm64_url = $arm64_url' <<< "${json}" | tee VERSION.json
