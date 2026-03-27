const http = require('http');
const fs = require('fs');
const path = require('path');
const { createReadStream, statSync } = fs;

const PORT = 5000;
const WEB_DIR = path.join(__dirname, 'build', 'web');

const mimeTypes = {
  '.html': 'text/html',
  '.js': 'application/javascript',
  '.mjs': 'application/javascript',
  '.css': 'text/css',
  '.json': 'application/json',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.gif': 'image/gif',
  '.svg': 'image/svg+xml',
  '.ico': 'image/x-icon',
  '.woff': 'font/woff',
  '.woff2': 'font/woff2',
  '.ttf': 'font/ttf',
  '.otf': 'font/otf',
  '.wasm': 'application/wasm',
  '.webmanifest': 'application/manifest+json',
  '.map': 'application/json',
};

// Extensions that should NOT fall back to index.html (assets, scripts, etc.)
const noFallbackExtensions = new Set([
  '.js', '.mjs', '.css', '.wasm', '.png', '.jpg', '.jpeg', '.gif',
  '.svg', '.ico', '.woff', '.woff2', '.ttf', '.otf', '.json',
  '.webmanifest', '.map', '.txt', '.xml', '.webp', '.mp4', '.mp3',
  '.symbols', '.br', '.gz'
]);

const server = http.createServer((req, res) => {
  let urlPath = req.url.split('?')[0];
  if (urlPath === '/') urlPath = '/index.html';
  const startTime = Date.now();

  let filePath = path.join(WEB_DIR, urlPath);

  let fileExists = false;
  try {
    const stat = statSync(filePath);
    fileExists = stat.isFile();
  } catch {
    fileExists = false;
  }

  // If file doesn't exist, decide whether to fall back to index.html
  if (!fileExists) {
    const ext = path.extname(urlPath).toLowerCase();
    if (noFallbackExtensions.has(ext)) {
      // Return proper 404 for assets/scripts - do NOT serve index.html
      console.log(`404 ASSET: ${urlPath}`);
      res.writeHead(404, { 'Content-Type': 'text/plain' });
      res.end('Not found');
      return;
    }
    // For routes without extensions (SPA navigation), serve index.html
    filePath = path.join(WEB_DIR, 'index.html');
  }

  const ext = path.extname(filePath).toLowerCase();
  const contentType = mimeTypes[ext] || 'application/octet-stream';

  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Cache-Control', 'no-cache');

  // Service worker needs specific headers
  if (urlPath.includes('flutter_service_worker')) {
    res.setHeader('Service-Worker-Allowed', '/');
  }

  try {
    const stat = statSync(filePath);
    console.log(`200: ${urlPath}`);
    res.writeHead(200, { 'Content-Type': contentType, 'Content-Length': stat.size });
    createReadStream(filePath).pipe(res);
  } catch {
    res.writeHead(404, { 'Content-Type': 'text/plain' });
    res.end('Not found');
  }
});

server.listen(PORT, '0.0.0.0', () => {
  console.log(`SashLive web server running on http://0.0.0.0:${PORT}`);
});
