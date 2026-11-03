class FeatureNames {
  FeatureNames._();

  static const liteMode = 'lite_mode';
}

class FeatureFlags {
  FeatureFlags._();

  static const bool liteModeEnabled = false;
  static const int liteMonthlyEncounterLimit = 5;

  static bool isEnabled(String featureName) {
    switch (featureName) {
      case FeatureNames.liteMode:
        return liteModeEnabled;
      default:
        return false;
    }
  }
}
