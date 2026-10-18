class FeatureNames {
  FeatureNames._();

  static const premiumByDefault = 'premium_by_default';
  static const showPremiumSettingsItem = 'show_premium_settings_item';
  static const initializeMonetization = 'initialize_monetization';
  static const liteMode = 'lite_mode';
}

class FeatureFlags {
  FeatureFlags._();

  static const bool revenueCatEnabled = false;
  static const bool liteModeEnabled = false;
  static const int liteMonthlyEncounterLimit = 5;

  static bool isEnabled(String featureName) {
    switch (featureName) {
      case FeatureNames.premiumByDefault:
        return forcePremiumByDefault;
      case FeatureNames.showPremiumSettingsItem:
        return showPremiumSettingsItem;
      case FeatureNames.initializeMonetization:
        return enableMonetizationInitialization;
      case FeatureNames.liteMode:
        return liteModeEnabled;
      default:
        return false;
    }
  }

  static bool get forcePremiumByDefault => true;
  static bool get showPremiumSettingsItem => false;
  static bool get enableMonetizationInitialization => revenueCatEnabled;
}
