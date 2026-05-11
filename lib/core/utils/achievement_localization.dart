import 'package:notch_app/l10n/app_localizations.dart';

String localizeAchievementName(
  AppLocalizations l10n,
  String id,
  String fallback,
) {
  switch (id) {
    case 'rookie':
      return l10n.achievementRookieName;
    case 'legend':
      return l10n.achievementLegendName;
    case 'sprinter':
      return l10n.achievementSprinterName;
    case 'safe_player':
      return l10n.achievementSafePlayerName;
    case 'hat_trick':
      return l10n.achievementHatTrickName;
    case 'marathoner':
      return l10n.achievementMarathonerName;
    case 'renaissance_man':
      return l10n.achievementRenaissanceName;
    case 'fire_streak':
      return l10n.achievementFireStreakName;
    case 'abstinence_bronze':
      return l10n.achievementAbstinenceBronzeName;
    case 'abstinence_silver':
      return l10n.achievementAbstinenceSilverName;
    case 'abstinence_gold':
      return l10n.achievementAbstinenceGoldName;
    case 'abstinence_diamond':
      return l10n.achievementAbstinenceDiamondName;
    case 'monk_mode':
      return l10n.achievementMonkModeName;
    case 'top_critic':
      return l10n.achievementTopCriticName;
    case 'grand_master':
      return l10n.achievementGrandMasterName;
    case 'explorer':
      return l10n.achievementExplorerName;
    case 'globetrotter':
      return l10n.achievementGlobetrotterName;
    case 'night_owl':
      return l10n.achievementNightOwlName;
    case 'health_champion':
      return l10n.achievementHealthChampionName;
    case 'archivist':
      return l10n.achievementArchivistName;
    default:
      return fallback;
  }
}

String localizeAchievementDescription(
  AppLocalizations l10n,
  String id,
  String fallback,
) {
  switch (id) {
    case 'rookie':
      return l10n.achievementRookieDesc;
    case 'legend':
      return l10n.achievementLegendDesc;
    case 'sprinter':
      return l10n.achievementSprinterDesc;
    case 'safe_player':
      return l10n.achievementSafePlayerDesc;
    case 'hat_trick':
      return l10n.achievementHatTrickDesc;
    case 'marathoner':
      return l10n.achievementMarathonerDesc;
    case 'renaissance_man':
      return l10n.achievementRenaissanceDesc;
    case 'fire_streak':
      return l10n.achievementFireStreakDesc;
    case 'abstinence_bronze':
      return l10n.achievementAbstinenceBronzeDesc;
    case 'abstinence_silver':
      return l10n.achievementAbstinenceSilverDesc;
    case 'abstinence_gold':
      return l10n.achievementAbstinenceGoldDesc;
    case 'abstinence_diamond':
      return l10n.achievementAbstinenceDiamondDesc;
    case 'monk_mode':
      return l10n.achievementMonkModeDesc;
    case 'top_critic':
      return l10n.achievementTopCriticDesc;
    case 'grand_master':
      return l10n.achievementGrandMasterDesc;
    case 'explorer':
      return l10n.achievementExplorerDesc;
    case 'globetrotter':
      return l10n.achievementGlobetrotterDesc;
    case 'night_owl':
      return l10n.achievementNightOwlDesc;
    case 'health_champion':
      return l10n.achievementHealthChampionDesc;
    case 'archivist':
      return l10n.achievementArchivistDesc;
    default:
      return fallback;
  }
}
