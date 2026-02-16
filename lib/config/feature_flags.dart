import 'package:notch_app/config/feature_item.dart';

class FeatureNames {
  FeatureNames._();

  static const premiumByDefault = 'premium_by_default';
  static const showPremiumSettingsItem = 'show_premium_settings_item';
  static const initializeMonetization = 'initialize_monetization';
}

class FeatureFlags {
  FeatureFlags._();

  static const List<FeatureItem> items = [
    // Temporary monetization fallback while IAP is being fixed.
    FeatureItem(name: FeatureNames.premiumByDefault, enabled: true),
    FeatureItem(name: FeatureNames.showPremiumSettingsItem, enabled: false),
    FeatureItem(name: FeatureNames.initializeMonetization, enabled: false),
  ];

  static bool isEnabled(String featureName) {
    for (final item in items) {
      if (item.name == featureName) return item.enabled;
    }
    return false;
  }

  static bool get forcePremiumByDefault =>
      isEnabled(FeatureNames.premiumByDefault);
  static bool get showPremiumSettingsItem =>
      isEnabled(FeatureNames.showPremiumSettingsItem);
  static bool get enableMonetizationInitialization =>
      isEnabled(FeatureNames.initializeMonetization);
}
