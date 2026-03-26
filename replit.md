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

### Pub Cache Patches (must re-apply after `flutter pub get` wipes the cache)
These 4 files in `~/.pub-cache/hosted/pub.dev/` need patching:
1. `zego_uikit_signaling_plugin-2.8.8/lib/src/internal/zim_extension.dart` — `beCanceled` → `beCancelled`
2. `zego_uikit_signaling_plugin-2.8.8/lib/zego_uikit_signaling_plugin.dart` — remove `await` before `ZIM.setAdvancedConfig(key, value)`
3. `zego_uikit-2.27.20/lib/src/services/defines/express_extension.dart` — add `0, 0,` (2 extra zeros) to `ZegoPublishStreamQuality()` in `empty()` function
4. `zego_uikit-2.27.20/lib/src/services/defines/error.dart` — add `default: return -1;` in `fromZegoScreenCaptureExceptionType` switch

## Android Build Configuration

### Key Fixes Applied
- `android/build.gradle`: Moved `configurations.all {}` out of `repositories {}` block (was invalid Gradle DSL)
- `android/app/build.gradle`:
  - Moved `firebase-perf` plugin to top `plugins {}` block
  - Removed `subprojects {}` block incorrectly nested inside `android {}` block
  - Replaced old Support Library `com.android.support:multidex:1.0.3` with AndroidX `androidx.multidex:multidex:2.0.1`
  - Removed duplicate `apply plugin` lines at bottom (plugins already in top `plugins {}` block)
  - Added `minifyEnabled` / `shrinkResources` for release builds
- `android/app/src/main/AndroidManifest.xml`: Moved `android:allowBackup="false"` from `<activity>` to `<application>` (where it belongs)
- `android/app/proguard-rules.pro`: Added comprehensive keep/dontwarn rules for Flutter, Kotlin, Zego, Firebase, Google Ads, Facebook, Branch.io, Parse, WorkManager, uCrop
- `android/settings.gradle`: Updated google-services plugin to 4.4.2, crashlytics to 3.0.0
- `android/local.properties`: Fixed Windows-format `sdk.dir` path to Linux format

### Android Build Specs
- `compileSdk`: 36, `minSdkVersion`: 24, `targetSdkVersion`: 36
- Kotlin JVM target: 17, Java source/target compatibility: 17
- ABI filters: `armeabi-v7a`, `arm64-v8a`, `x86_64`
- Signing: release keystore via `android/key.properties`
- Firebase: google-services.json in `android/app/`

## Configuration
- Firebase config in `web/index.html`
- Parse Server config in `lib/app/config.dart`
- App constants in `lib/utils/utilsConstants.dart`
