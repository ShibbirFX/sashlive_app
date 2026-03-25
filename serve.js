const http = require('http');
const fs = require('fs');
const path = require('path');
const { createReadStream, statSync } = fs;

const PORT = 5000;
const WEB_DIR = path.join(__dirname, 'build', 'web');

const mimeTypes = {
  '.html': 'text/html',
  '.js': 'application/javascript',
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
  '.webmanifest': 'application/manifest+json',
};

const server = http.createServer((req, res) => {
  let urlPath = req.url.split('?')[0];
  if (urlPath === '/') urlPath = '/index.html';
  
  let filePath = path.join(WEB_DIR, urlPath);
  
  // Try the path, if doesn't exist serve index.html for SPA routing
  try {
    const stat = statSync(filePath);
    if (!stat.isFile()) throw new Error('not a file');
  } catch {
    filePath = path.join(WEB_DIR, 'index.html');
  }
  
  const ext = path.extname(filePath);
  const contentType = mimeTypes[ext] || 'application/octet-stream';
  
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Cache-Control', 'no-cache');
  
  try {
    const stat = statSync(filePath);
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
