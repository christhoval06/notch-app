abstract final class LandingConfig {
  static const brand = 'NOTCH';
  static const icon = 'assets/icon.png';
  static const screenshotAspectRatio = 1206 / 2622;
  static const appStoreUrl = String.fromEnvironment(
    'NOTCH_APP_STORE_URL',
    defaultValue: 'https://apps.apple.com/us/app/notch/id6759076734',
  );
  static const supportUrl = 'mailto:support@notchapp.com';
  static const homeScreen = 'assets/screens/s5.png';
  static const loggerScreen = 'assets/screens/s6.png';
  static const loggerDetailsScreen = 'assets/screens/s7.png';
  static const bookScreen = 'assets/screens/s8.png';
  static const trophyScreen = 'assets/screens/s9.png';
  static const badgeScreen = 'assets/screens/s11.png';
  static const insightScreen = 'assets/screens/s13.png';
  static const heatmapScreen = 'assets/screens/s14.png';
  static const protectionScreen = 'assets/screens/s16.png';
}
