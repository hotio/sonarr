#!/bin/bash

if [[ ${1} == "screenshot" ]]; then
    SERVICE_IP="http://$(dig +short service):8989/system/status"
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
  await page.goto("${SERVICE_IP}", { waitUntil: "networkidle${NETWORK_IDLE}" });
  await page.evaluate(() => {
    const div = document.createElement('div');
    div.innerHTML = 'Image: ${DRONE_REPO_OWNER}/${DRONE_REPO_NAME##docker-}:${DRONE_COMMIT_BRANCH}<br>Commit: ${DRONE_COMMIT_SHA:0:7}<br>Build: #${DRONE_BUILD_NUMBER}<br>Timestamp: $(date -u --iso-8601=seconds)';
    div.style.cssText = "all: initial; font-weight: normal; font-size: normal; font-family: monospace; padding: 5px; color: white; position: fixed; bottom: 10px; right: 10px; background: DODGERBLUE; z-index: 10000";
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
else
    version=$(curl -fsSL "https://services.sonarr.tv/v1/download/master" | jq -r .version)
    [[ -z ${version} ]] && exit
    find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG SONARR_VERSION=.*$/ARG SONARR_VERSION=${version}/g" {} \;
    sed -i "s/{TAG_VERSION=.*}$/{TAG_VERSION=${version}}/g" .drone.yml
    echo "##[set-output name=version;]${version}"
fi
