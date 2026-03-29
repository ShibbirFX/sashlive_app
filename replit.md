# SashLive - Flutter Live Streaming App

## Overview
SashLive is a social networking and live-streaming mobile/web application built with Flutter. It supports live video/audio streaming, PK battles, video reels, social feeds, virtual gifting, user leveling, wallet system, and agency management.

## Tech Stack
- **Framework**: Flutter 3.32+ (web build served in Replit)
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
- `android/` - Android build configuration
- `ios/` - iOS build configuration
- `serve.js` - Node.js static file server for the web build
- `start.sh` - Startup script (builds if needed, then serves)

## Running the App (Web Preview)
The workflow runs `bash start.sh` which:
1. Builds the Flutter web app (`flutter build web --release`) if `build/web` doesn't exist
2. Serves the built files via Node.js on port 5000

## Building for Android/iOS
```bash
# Android APK (debug - no signing required)
flutter build apk --debug

# Android APK (release - requires android/key.properties)
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (requires macOS + Xcode)
flutter build ios --release
```

## Android Release Signing Setup
1. Copy `android/key.properties.template` to `android/key.properties`
2. Fill in your keystore details (storePassword, keyPassword, keyAlias, storeFile path)
3. The release build will use debug signing if key.properties is absent

## Key Configuration Files
- `pubspec.yaml` - Flutter dependencies
- `lib/app/config.dart` - API keys, server URLs, AdMob IDs
- `lib/app/setup.dart` - Feature flags, ZegoCloud credentials
- `web/index.html` - Firebase config, Google Sign-In client ID
- `android/app/google-services.json` - Firebase Android config
- `android/app/src/main/res/values/strings.xml` - Facebook SDK, AdMob App ID for Android
- `ios/Runner/Info.plist` - iOS-specific config (Facebook, AdMob, permissions)

## Android Config Notes
- **Facebook App ID**: `539301740976685` (in strings.xml and AndroidManifest)
- **AdMob App ID**: Replace with your real Android AdMob App ID from https://apps.admob.com
  - Current placeholder: `ca-app-pub-9318890613494690~9013965649` (matches iOS)
- **Signing**: Configure `android/key.properties` for release builds

## iOS Config Notes
- **Minimum deployment target**: iOS 14.0
- **Permissions**: Camera, Microphone, Photos, Location, Notifications (all enabled)
- **Facebook App ID**: `539301740976685`
- **AdMob App ID**: `ca-app-pub-9318890613494690~9013965649`

## Android Build Configuration
- **compileSdk**: 36
- **minSdkVersion**: 24
- **targetSdkVersion**: 36
- **Kotlin**: 2.1.0
- **AGP**: 8.6.1
- **Gradle**: 8.7

## Build Notes (Pub Cache Patches)
The app uses specific dependency overrides in `pubspec.yaml` for Zego packages due to cross-dependency constraints. Several pub cache files were patched to fix API incompatibilities between zego_uikit 2.27.20, zego_uikit_signaling_plugin 2.8.8, and zego_express_engine 3.23.0:

- `zego_uikit_signaling_plugin-2.8.8/lib/src/internal/zim_extension.dart`
  - Fixed enum value name: `ZIMCallUserState.beCanceled` → `beCancelled`
  - Suppressed deprecated `offline` enum warning
- `zego_uikit_signaling_plugin-2.8.8/lib/zego_uikit_signaling_plugin.dart`
  - Removed `await` from void-returning `ZIM.setAdvancedConfig()` call
- `zego_uikit-2.27.20/lib/src/services/defines/express_extension.dart`
  - Added 2 missing constructor args for `ZegoPublishStreamQuality(audioTrafficControlRate, videoTrafficControlRate)`
- `zego_uikit-2.27.20/lib/src/services/defines/error.dart`
  - Added `default` case to `ZegoScreenCaptureExceptionType` switch for new enum values

## Fixes Applied (Build-Ready Checklist)
- [x] Dart analysis: 0 issues (`flutter analyze` clean)
- [x] `android/build.gradle` - Migrated deprecated `buildDir` → `layout.buildDirectory` (Gradle 8.x API)
- [x] `android/app/build.gradle` - Debug signing config, graceful release signing fallback, `lint.abortOnError false`
- [x] `android/gradle.properties` - Added parallel builds, caching, incremental Kotlin compilation
- [x] `android/settings.gradle` - Updated AGP to 8.6.1, Firebase Crashlytics plugin to 3.0.3
- [x] `android/app/src/main/res/values/strings.xml` - Fixed Facebook App ID (was corrupted), client token, URL scheme; replaced test AdMob ID
- [x] `android/app/src/main/AndroidManifest.xml` - Added `maxSdkVersion` to deprecated storage permissions; removed deprecated SplashScreenDrawable meta-data
- [x] `ios/Podfile` - Consistent iOS 14.0 deployment target (was 14.0 platform but overridden to 12.1 per-pod)
- [x] `pubspec.yaml` - Removed discontinued `url_strategy` package
- [x] `analysis_options.yaml` - Excluded pub cache from analysis, added lint suppressions for third-party deprecations
