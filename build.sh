#!/bin/bash

if [[ -z ${1} ]]; then
    echo "Usage: ./build.sh amd64"
    echo "       ./build.sh arm64"
    exit 1
fi

while IFS= read -r line; do
  opts+=(--build-arg "$line")
done <<< "$(jq -r 'to_entries[] | [(.key | ascii_upcase),.value] | join("=")' < meta.json)"

image=$(basename "$(git rev-parse --show-toplevel)")

docker build --platform "linux/${1}" -f "./linux-${1}.Dockerfile" -t "${image}-${1}" "${opts[@]}" .
