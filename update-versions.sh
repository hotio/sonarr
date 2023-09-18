#!/bin/bash

json=$(curl -fsSL "https://services.sonarr.tv/v1/releases" | jq '.["v4-preview"]')
version=$(jq -r '.version' <<< "${json}")
[[ -z ${version} ]] && exit 0
sbranch=$(jq -r '.branch' <<< "${json}")
[[ -z ${sbranch} ]] && exit 0
version_arr_discord_notifier=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/hotio/arr-discord-notifier/tags" | jq -r .[0].name)
[[ -z ${version_arr_discord_notifier} ]] && exit 0
version_json=$(cat ./VERSION.json)
jq '.version = "'"${version}"'" | .sbranch = "'"${sbranch}"'" | .arr_discord_notifier_version = "'"${version_arr_discord_notifier}"'"' <<< "${version_json}" > VERSION.json
