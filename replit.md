# SashLive - Flutter Live Streaming App

## Overview
SashLive is a social networking and live-streaming mobile/web application built with Flutter. It supports live video/audio streaming, PK battles, video reels, social feeds, virtual gifting, user leveling, wallet system, and agency management.

## Tech Stack
- **Framework**: Flutter 3.32+ (web build)
- **Language**: Dart
- **Backend**: Parse Server via Back4App
- **Live Streaming**: ZegoCloud (zego_uikit packages)
- **Firebase**: Analytics, Messaging, Crashlytics, Performance, Auth
- **State Management**: GetX
- **Payments**: RevenueCat
- **Ads**: Google Mobile Ads (AdMob)
- **Push Notifications**: OneSignal

## Project Structure
- `lib/` - Main Dart/Flutter source code
  - `main.dart` - Entry point (Firebase, Parse, ZegoCloud init)
  - `app/` - Config, routes, navigation services
  - `auth/` - Authentication screens
  - `home/` - Feature modules (live, streaming, reels, coins, wallet, etc.)
  - `models/` - Parse Server data models
  - `services/` - Infrastructure services
  - `utils/` - Constants, themes, colors, helpers
  - `widgets/` - Reusable UI components
- `assets/` - Images, SVGs, Lottie animations, translations, icons
- `web/` - Web entry point and Firebase config
- `build/web/` - Compiled Flutter web output (not in git)
- `serve.js` - Node.js static file server for the web build
- `start.sh` - Startup script (builds if needed, then serves)

## Running the App
The workflow runs `bash start.sh` which:
1. Builds the Flutter web app (`flutter build web --release`) if `build/web` doesn't exist
2. Serves the built files via Node.js on port 5000

## Key Configuration Files
- `pubspec.yaml` - Flutter dependencies
- `lib/app/config.dart` - API keys, server URLs, AdMob IDs
- `lib/app/setup.dart` - Feature flags, ZegoCloud credentials
- `web/index.html` - Firebase config, Google Sign-In client ID
- `android/app/google-services.json` - Firebase Android config

## Build Notes
The app uses specific dependency overrides in `pubspec.yaml` for Zego packages due to cross-dependency constraints. Several pub cache files were patched to fix API incompatibilities:
- `zego_uikit_signaling_plugin-2.8.8/lib/src/internal/zim_extension.dart` - Fixed enum value name (`beCanceled` → `beCancelled`) and added default case
- `zego_uikit_signaling_plugin-2.8.8/lib/zego_uikit_signaling_plugin.dart` - Removed `await` from void `ZIM.setAdvancedConfig` call
- `zego_uikit-2.27.20/lib/src/services/defines/express_extension.dart` - Added 2 missing constructor args for `ZegoPublishStreamQuality`
- `zego_uikit-2.27.20/lib/src/services/defines/error.dart` - Added default case to screen capture exception switch
