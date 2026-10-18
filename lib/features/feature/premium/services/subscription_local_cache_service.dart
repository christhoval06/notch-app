import 'package:notch_app/core/constants/app_prefs.dart';
import 'package:notch_app/core/constants/feature_flags.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionLocalCacheService {
  const SubscriptionLocalCacheService._();

  static Future<bool> loadPremium() async {
    if (FeatureFlags.forcePremiumByDefault) return true;
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppPrefs.premiumUnlocked) ?? false;
  }

  static Future<void> savePremium(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
      AppPrefs.premiumUnlocked,
      FeatureFlags.forcePremiumByDefault ? true : value,
    );
  }
}
