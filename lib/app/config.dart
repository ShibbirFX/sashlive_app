import 'dart:ui';


class Config {

  static const String packageNameAndroid = "com.sashtech.sashlive";
  static const String packageNameiOS = "com.sashtech.sashlive";
  static const String iosAppStoreId = "1048";
  static final String appName = "SashLive";
  static final String appVersion = "1.0.0";
  static final String companyName = "SashTech, inc";
  static final String appOrCompanyUrl = "https://sashlive.online";
  static final String initialCountry = 'US'; // United States

  static final String serverUrl = "https://parseapi.back4app.com/";
  static final String liveQueryUrl = "wss://0yP06N2BLguKaxs9qQwmsQqoktSCrjU8YoG3cWyy.b4a.io";
  static final String appId = "0yP06N2BLguKaxs9qQwmsQqoktSCrjU8YoG3cWyy";
  static final String clientKey = "mgWTCujsg5xqYJpXRhLFUcIm6yptcuWbduez2ygw";

  //OneSignal
  static final String oneSignalAppId = "4952eccb-8438-4a89-af59-fa07be75a09f";

  // Firebase Cloud Messaging
  static final String pushGcm = "434676400601";
  static final String webPushCertificate = "BJSAJQvJpstwKq_KFT76yx59WiHC6kvQjQW7dPoSmIjIn8RcI_X4JTsaM5A03_Oo5nIw_xet6NcD-EBXx5HjBuo";

  // User support objectId
  static final String supportId = "";

  // Play Store and App Store public keys
  static final String publicGoogleSdkKey = "";
  static final String publicIosSdkKey = "";

  // Languages
  static String defaultLanguage = "en"; // English is default language.
  static List<Locale> languages = [
    Locale(defaultLanguage),
    //Locale('pt'),
    //Locale('fr')
  ];

  // Android Admob ad
  static const String admobAndroidOpenAppAd = "ca-app-pub-1265393019216726/3437025279";
  static const String admobAndroidHomeBannerAd = "ca-app-pub-1265393019216726/4510075007";
  static const String admobAndroidFeedNativeAd = "ca-app-pub-1265393019216726/6344737137";
  static const String admobAndroidChatListBannerAd = "ca-app-pub-1265393019216726/3718573796";
  static const String admobAndroidLiveBannerAd = "ca-app-pub-1265393019216726/4318503317";
  static const String admobAndroidFeedBannerAd = "ca-app-pub-1265393019216726/4352998615";

  // iOS Admob ad
  static const String admobIOSOpenAppAd = "ca-app-pub-1265393019216726/3437025279";
  static const String admobIOSHomeBannerAd = "ca-app-pub-1265393019216726/4510075007";
  static const String admobIOSFeedNativeAd = "ca-app-pub-1265393019216726/6344737137";
  static const String admobIOSChatListBannerAd = "ca-app-pub-1265393019216726/3718573796";
  static const String admobIOSLiveBannerAd = "ca-app-pub-1265393019216726/4318503317";
  static const String admobIOSFeedBannerAd = "ca-app-pub-1265393019216726/4352998615";

  // Web links for help, privacy policy and terms of use.
  static final String helpCenterUrl = "https://sashlive-34749.web.app/terms/";
  static final String privacyPolicyUrl = "https://sashlive-34749.web.app/pivacy/";
  static final String termsOfUseUrl = "https://sashlive-34749.web.app/terms/";
  static final String termsOfUseInAppUrl = "https://sashlive-34749.web.app/terms/";
  static final String dataSafetyUrl = "https://ladylivea.net/help.html";
  static final String openSourceUrl = "https://www.ladylivea.net/third-party-license.html";
  static final String instructionsUrl = "https://ladylivea.net/instructions.html";
  static final String cashOutUrl = "https://ladylivea.net/cashout.html";
  static final String supportUrl = "https://www.ladylivea.net/support";
  static final String liveAgreementUrl = "https://sashlive-34749.web.app/live/";
  static final String userAgreementUrl = "https://sashlive-34749.web.app/user/";

  // Google Play and Apple Pay In-app Purchases IDs
  static final String credit100 = "sash.100.credits";
  static final String credit200 = "sash.200.credits";
  static final String credit500 = "sash.500.credits";
  static final String credit1000 = "sash.1000.credits";
  static final String credit2100 = "sash.2100.credits";
  static final String credit5250 = "sash.5250.credits";
  static final String credit10500 = "sash.10500.credits";
}