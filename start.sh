#!/bin/bash
# Start the web server immediately so the port opens (keeps the workflow alive)
# Then build Flutter in the background if needed

echo "Starting SashLive server..."

# Start the node server in background first so port 5000 opens immediately
node serve.js &
NODE_PID=$!

echo "Web server started (PID: $NODE_PID). Running Flutter web build in background..."

# Build Flutter web app (always rebuild to pick up code changes)
flutter build web --release > /tmp/flutter_build.log 2>&1
BUILD_EXIT=$?

if [ $BUILD_EXIT -eq 0 ]; then
    echo "Flutter web build completed successfully! Refresh your browser to see the latest changes."
else
    echo "Flutter web build failed with exit code $BUILD_EXIT. Check /tmp/flutter_build.log for details."
    cat /tmp/flutter_build.log | tail -20
fi

# Keep the node server running
wait $NODE_PID
