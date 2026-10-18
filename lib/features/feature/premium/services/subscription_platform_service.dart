import 'dart:io';

class SubscriptionPlatformService {
  const SubscriptionPlatformService._();

  static const defaultIosApiKey = 'test_MhwLuKSQtKScPNnZEATCgAYpKOs';
  static const defaultAndroidApiKey = 'test_MhwLuKSQtKScPNnZEATCgAYpKOs';

  static bool get isStoreAvailable => Platform.isIOS || Platform.isAndroid;

  static String resolveApiKey() {
    return Platform.isIOS
        ? const String.fromEnvironment(
            'RC_IOS_API_KEY',
            defaultValue: defaultIosApiKey,
          )
        : const String.fromEnvironment(
            'RC_ANDROID_API_KEY',
            defaultValue: defaultAndroidApiKey,
          );
  }
}
