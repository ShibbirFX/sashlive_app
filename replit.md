# SashLive - Live Streaming App

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

## APK Release Build Requirements
To build a release APK, you need:
1. A signing keystore file and `android/key.properties` with:
   ```
   keyAlias=<your-key-alias>
   keyPassword=<your-key-password>
   storeFile=<path-to-keystore.jks>
   storePassword=<your-store-password>
   ```
2. Android SDK installed and `android/local.properties` updated with correct `sdk.dir` path.
3. Run: `flutter build apk --release` or `flutter build appbundle --release`

For a **debug APK** (no signing needed): `flutter build apk --debug`
