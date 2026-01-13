#!/bin/bash
set -exuo pipefail

response_json=$(curl -fsSL "https://services.sonarr.tv/v1/releases" | jq -e '.["v4-nightly"]')
version=$(jq -re .version <<< "${response_json}")
version_branch=$(jq -re .branch <<< "${response_json}")
version_amd64_url=$(jq -re '.linuxMusl.x64.archive.url' <<< "${response_json}")
version_arm64_url=$(jq -re .linuxMusl.arm64.archive.url <<< "${response_json}")
json=$(cat meta.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    --arg version_branch "${version_branch}" \
    --arg version_amd64_url "${version_amd64_url}" \
    --arg version_arm64_url "${version_arm64_url}" \
    '.version = $version | .version_branch = $version_branch | .version_amd64_url = $version_amd64_url | .version_arm64_url = $version_arm64_url' <<< "${json}" | tee meta.json
