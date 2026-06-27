import 'package:notch_app/core/configs/feature_item.dart';

class FeatureNames {
  FeatureNames._();

  static const premiumByDefault = 'premium_by_default';
  static const showPremiumSettingsItem = 'show_premium_settings_item';
  static const initializeMonetization = 'initialize_monetization';
}

class FeatureFlags {
  FeatureFlags._();

  static const List<FeatureItem> items = [
    FeatureItem(name: FeatureNames.premiumByDefault, enabled: false),
    FeatureItem(name: FeatureNames.showPremiumSettingsItem, enabled: true),
    FeatureItem(name: FeatureNames.initializeMonetization, enabled: true),
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
