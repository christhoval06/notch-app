import 'package:notch_app/l10n/app_localizations.dart';

enum PremiumFeature {
  insights,
  dataBackup,
  healthPassport,
  blackBook,
  trophyRoom,
  stats,
}

extension PremiumFeatureCopy on PremiumFeature {
  bool get requiresPremium => true;

  String title(AppLocalizations l10n) {
    switch (this) {
      case PremiumFeature.insights:
        return l10n.insightsTitle;
      case PremiumFeature.dataBackup:
        return l10n.settingsDataBackup;
      case PremiumFeature.healthPassport:
        return l10n.homeHealthPassportTitle;
      case PremiumFeature.blackBook:
        return l10n.homeBlackBookTitle;
      case PremiumFeature.trophyRoom:
        return l10n.homeTrophyRoomTitle;
      case PremiumFeature.stats:
        return l10n.homeStatsTitle;
    }
  }

  String description(AppLocalizations l10n) {
    switch (this) {
      case PremiumFeature.insights:
        return l10n.premiumFeatureInsightsDescription;
      case PremiumFeature.dataBackup:
        return l10n.premiumFeatureDataBackupDescription;
      case PremiumFeature.healthPassport:
        return l10n.premiumFeatureHealthPassportDescription;
      case PremiumFeature.blackBook:
        return l10n.premiumFeatureBlackBookDescription;
      case PremiumFeature.trophyRoom:
        return l10n.monetizationFallbackDescription;
      case PremiumFeature.stats:
        return l10n.monetizationFallbackDescription;
    }
  }
}
