#!/bin/bash

PUB_CACHE="$HOME/.pub-cache/hosted/pub.dev"

apply_patches() {
  echo "[patches] Applying Zego SDK patches..."

  # Patch 1: beCanceled -> beCancelled
  F="$PUB_CACHE/zego_uikit_signaling_plugin-2.8.8/lib/src/internal/zim_extension.dart"
  [ -f "$F" ] && sed -i 's/ZIMCallUserState\.beCanceled/ZIMCallUserState.beCancelled/g; s/ZegoSignalingPluginInvitationUserState\.beCanceled/ZegoSignalingPluginInvitationUserState.beCancelled/g' "$F"

  # Patch 2: remove await from ZIM.setAdvancedConfig
  F="$PUB_CACHE/zego_uikit_signaling_plugin-2.8.8/lib/zego_uikit_signaling_plugin.dart"
  [ -f "$F" ] && sed -i 's/    await ZIM\.setAdvancedConfig(key, value);/    ZIM.setAdvancedConfig(key, value);/' "$F"

  # Patch 3: add 2 extra int params to ZegoPublishStreamQuality in empty()
  F="$PUB_CACHE/zego_uikit-2.27.20/lib/src/services/defines/express_extension.dart"
  if [ -f "$F" ]; then
    node -e "
const fs = require('fs');
let c = fs.readFileSync('$F', 'utf8');
const o = \`      ZegoVideoCodecID.Default,
      0.0,
      0.0,
      0.0,
    );\`;
const n = \`      ZegoVideoCodecID.Default,
      0.0,
      0.0,
      0.0,
      0,
      0,
    );\`;
if (c.includes(o)) { fs.writeFileSync('$F', c.replace(o, n)); }
" 2>/dev/null || true
  fi

  # Patch 4: add default case to fromZegoScreenCaptureExceptionType switch
  F="$PUB_CACHE/zego_uikit-2.27.20/lib/src/services/defines/error.dart"
  if [ -f "$F" ] && ! grep -q "default: return -1;" "$F"; then
    node -e "
const fs = require('fs');
let c = fs.readFileSync('$F', 'utf8');
const o = \`      case ZegoScreenCaptureExceptionType.SystemError:
        return screenCaptureExceptionSystemError;
    }
  }\`;
const n = \`      case ZegoScreenCaptureExceptionType.SystemError:
        return screenCaptureExceptionSystemError;
      default:
        return -1;
    }
  }\`;
if (c.includes(o)) { fs.writeFileSync('$F', c.replace(o, n)); }
" 2>/dev/null || true
  fi

  echo "[patches] Done."
}

echo "=== SashLive Startup ==="

# Step 1: packages
echo "[1/3] Getting packages..."
flutter pub get --offline 2>/dev/null || flutter pub get
echo "[1/3] Packages ready."

# Step 2: apply patches
apply_patches

# Step 3: build web (skip if already built and sources unchanged)
if [ ! -f "build/web/index.html" ]; then
  echo "[2/3] Building Flutter web app (this may take several minutes)..."
  flutter build web --release
  echo "[2/3] Build complete."
else
  echo "[2/3] Web build already exists, skipping rebuild."
fi

# Step 4: serve
echo "[3/3] Starting web server on port 5000..."
node serve.js
