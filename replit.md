# SashLive - Flutter Live Streaming App

## Overview
SashLive is a comprehensive mobile and web application built for live-streaming, video reels, and social networking. It includes features such as real-time video/audio calls, PK battles (competitive streaming), a gift economy, user levels, and social feeds.

## Tech Stack
- **Framework**: Flutter (web build)
- **Language**: Dart
- **Backend**: Parse Server (via `parse_server_sdk_flutter`)
- **Live Streaming**: ZegoCloud (zego_uikit and prebuilt plugins)
- **Cloud Services**: Firebase (Core, Messaging, Analytics, Performance, Crashlytics, Auth)
- **State Management**: GetX
- **Push Notifications**: OneSignal + Firebase Messaging
- **Social Login**: Firebase Auth, Google Sign-In, Apple Sign-In
- **Payments**: RevenueCat (purchases_flutter)
- **Ads**: Google Mobile Ads

## Architecture
- `lib/main.dart` - App entry point
- `lib/home/` - Main features (live, reels, streaming, wallet, pk_battle, agency)
- `lib/models/` - Parse Server data models
- `lib/services/` - Push, call, and deep link services
- `lib/auth/` - Authentication screens
- `lib/utils/` - Constants, themes, colors, helpers
- `lib/widgets/` - Reusable UI components
- `assets/` - Images, translations, SVGs, lotties, videos, country flags

## Build System
- **Package manager**: pub (Flutter)
- **Build**: `flutter build web --release` (produces `build/web/`)
- **Web server**: Node.js (`serve.js`) serving the Flutter web build on port 5000

## Running the App

### Development
1. Build the Flutter web app: `flutter build web --release`
2. Start the web server: `node serve.js`

The app runs on port 5000.

## Dependency Notes
Several zego packages require pinned versions in `dependency_overrides` to maintain compatibility:
- `zego_uikit`: 2.27.20
- `zego_uikit_prebuilt_call`: 4.16.17
- `zego_uikit_signaling_plugin`: 2.8.8
- `zego_plugin_adapter`: 2.13.5
- `zego_uikit_prebuilt_live_streaming`: 3.13.8
- `zego_uikit_prebuilt_live_audio_room`: 3.15.5

Several pub cache files were patched to fix API compatibility issues:
- `zego_uikit_signaling_plugin-2.8.8/lib/src/internal/zim_extension.dart` - `beCanceled` → `beCancelled`
- `zego_uikit_signaling_plugin-2.8.8/lib/zego_uikit_signaling_plugin.dart` - removed invalid `await` on void return
- `zego_uikit-2.27.20/lib/src/services/defines/express_extension.dart` - added missing constructor args
- `zego_uikit-2.27.20/lib/src/services/defines/error.dart` - added default return in switch

## Configuration
- Firebase config in `web/index.html`
- Parse Server config in `lib/app/config.dart`
- App constants in `lib/utils/utilsConstants.dart`
