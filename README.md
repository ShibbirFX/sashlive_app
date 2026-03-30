# SashLive - Flutter Live Streaming App

## Overview
SashLive is a social networking and live-streaming mobile/web application built with Flutter. It supports live video/audio streaming, PK battles, video reels, social feeds, virtual gifting, user leveling, wallet system, and agency management.

## Tech Stack
- **Framework**: Flutter 3.32+
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
- **Facebook App ID**: `1960422418013644`
- **AdMob App ID**: `ca-app-pub-1265393019216726~4290760764`

## Android Build Configuration
- **compileSdk**: 36
- **minSdkVersion**: 24
- **targetSdkVersion**: 36
- **Kotlin**: 2.1.0
- **AGP**: 8.6.1
- **Gradle**: 8.7
