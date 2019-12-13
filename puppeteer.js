const puppeteer = require("puppeteer");

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
  await page.goto("http://service:8989/system/status", { waitUntil: "networkidle2" });
  await page.evaluate(() => {
    const div = document.createElement('div');
    div.innerHTML = 'WATERMARK';
    div.style.cssText = "padding: 5px; color: white; position: fixed; bottom: 10px; right: 10px; background: green; z-index: 10000";
    document.body.appendChild(div);
  });
  await page.screenshot({ path: "/tmp/screenshot.png", fullPage: true });
  await browser.close();
})();
