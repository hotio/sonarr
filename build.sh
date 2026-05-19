#!/bin/bash

if [[ -z ${1} ]]; then
    echo "Usage: ./build.sh update"
    echo "       ./build.sh amd64"
    echo "       ./build.sh arm64"
    exit 1
fi

set -euo pipefail

if [[ ${1} == "update" ]]; then
    rm -f cache-page*.json
    while read -r line; do
        key="${line%%=*}"
        key="${key%__command}"
        command="${line#*=}"
        value=$(eval "${command}")
        json=$(cat meta.json)
        jq --sort-keys --arg key "$key" --arg value "$value" '.[$key] = $value' <<< "${json}" > meta.json
        echo "Result: [${key}] [${value}]"
    done < <(jq -r 'to_entries[] | [(.key),.value] | join("=")' < meta.json | grep '__command')
    rm -f cache-page*.json
fi

if [[ ${1} == "amd64" || ${1} == "arm64" ]]; then
    while IFS= read -r line; do
        opts+=(--build-arg "$line")
    done <<< "$(jq -r 'to_entries[] | [(.key | ascii_upcase),.value] | join("=")' < meta.json | grep -v '__command')"
    image=$(basename "$(git rev-parse --show-toplevel)")
    docker build --secret id=GIT_AUTH_TOKEN,env=TOKEN --platform "linux/${1}" -f "./linux-${1}.Dockerfile" -t "${image}-${1}" "${opts[@]}" .
fi
