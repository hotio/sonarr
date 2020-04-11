#!/bin/bash

if [[ ${1} == "screenshot" ]]; then
    SERVICE_IP="http://$(ping -c1 -4 service | sed -nE 's/^PING[^(]+\(([^)]+)\).*/\1/p'):8989/system/status"
    NETWORK_IDLE="2"
    cd /usr/src/app && node <<EOF
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({
    bindAddress: "0.0.0.0",
    args: [
      "--no-sandbox",
      "--headless",
      "--disable-gpu",
      "--disable-dev-shm-usage",
      "--remote-debugging-port=9222",
      "--remote-debugging-address=0.0.0.0"
    ]
  });
  const page = await browser.newPage();
  await page.setViewport({ width: 1920, height: 1080 });
  try {
    await page.goto("${SERVICE_IP}", { waitUntil: "networkidle${NETWORK_IDLE}" });
  } catch (e) {
    console.log(e)
    process.exit(1)
  }
  await page.evaluate(() => {
    const div = document.createElement('div');
    div.innerHTML = 'Image: ${DRONE_REPO_OWNER}/${DRONE_REPO_NAME##docker-}:${DRONE_COMMIT_BRANCH}<br>App Version: ${VERSION_FIELD}<br>Commit: ${DRONE_COMMIT_SHA:0:7}<br>Build: #${DRONE_BUILD_NUMBER}<br>Timestamp: $(date -u --iso-8601=seconds)';
    div.style.cssText = "all: initial !important; border-radius: 4px !important; font-weight: normal !important; font-size: normal !important; font-family: monospace !important; padding: 10px !important; color: black !important; position: fixed !important; bottom: 10px !important; right: 10px !important; background-color: #e7f3fe !important; border-left: 6px solid #2196F3 !important; z-index: 10000 !important";
    document.body.appendChild(div);
  });
  await page.screenshot({ path: "/drone/src/screenshot.png", fullPage: true });
  await browser.close();
})();
EOF
elif [[ ${1} == "checkservice" ]]; then
    SERVICE="http://service:8989"
    currenttime=$(date +%s); maxtime=$((currenttime+60)); while (! curl -fsSL ${SERVICE} > /dev/null) && [[ "$currenttime" -lt "$maxtime" ]]; do sleep 1; currenttime=$(date +%s); done
    curl -fsSL ${SERVICE} > /dev/null
elif [[ ${1} == "checkdigests" ]]; then
    mkdir ~/.docker && echo '{"experimental": "enabled"}' > ~/.docker/config.json
    image="hotio/mono"
    tag="latest"
    manifest=$(docker manifest inspect ${image}:${tag})
    [[ -z ${manifest} ]] && exit 1
    digest=$(echo "${manifest}" | jq -r '.manifests[] | select (.platform.architecture == "amd64" and .platform.os == "linux").digest') && sed -i "s#FROM .*\$#FROM ${image}@${digest}#g" ./linux-amd64.Dockerfile && echo "${digest}"
    digest=$(echo "${manifest}" | jq -r '.manifests[] | select (.platform.architecture == "arm" and .platform.os == "linux").digest')   && sed -i "s#FROM .*\$#FROM ${image}@${digest}#g" ./linux-arm.Dockerfile   && echo "${digest}"
    digest=$(echo "${manifest}" | jq -r '.manifests[] | select (.platform.architecture == "arm64" and .platform.os == "linux").digest') && sed -i "s#FROM .*\$#FROM ${image}@${digest}#g" ./linux-arm64.Dockerfile && echo "${digest}"
else
    version=$(curl -fsSL "https://services.sonarr.tv/v1/download/master" | jq -r .version)
    [[ -z ${version} ]] && exit 1
    sed -i "s/{SONARR_VERSION=[^}]*}/{SONARR_VERSION=${version}}/g" .drone.yml
    echo "##[set-output name=version;]${version}"
fi
