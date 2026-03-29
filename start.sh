#!/bin/bash
set -e

if [ ! -d "build/web" ]; then
  echo "Building Flutter web app..."
  flutter build web --release
fi

echo "Starting web server on port 5000..."
node serve.js
