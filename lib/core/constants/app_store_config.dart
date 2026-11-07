abstract final class AppStoreConfig {
  static const url = String.fromEnvironment(
    'NOTCH_APP_STORE_URL',
    defaultValue: 'https://apps.apple.com/us/app/notch/id6759076734',
  );
}
