import 'package:notch_app/l10n/app_localizations.dart';

typedef AchievementCopyBuilder = String Function(AppLocalizations l10n);

class AchievementCopyService {
  const AchievementCopyService._();

  static final Map<String, AchievementCopyBuilder> _names = {
    'rookie': (l10n) => l10n.achievementRookieName,
    'legend': (l10n) => l10n.achievementLegendName,
    'sprinter': (l10n) => l10n.achievementSprinterName,
    'safe_player': (l10n) => l10n.achievementSafePlayerName,
    'hat_trick': (l10n) => l10n.achievementHatTrickName,
    'marathoner': (l10n) => l10n.achievementMarathonerName,
    'renaissance_man': (l10n) => l10n.achievementRenaissanceName,
    'fire_streak': (l10n) => l10n.achievementFireStreakName,
    'abstinence_bronze': (l10n) => l10n.achievementAbstinenceBronzeName,
    'abstinence_silver': (l10n) => l10n.achievementAbstinenceSilverName,
    'abstinence_gold': (l10n) => l10n.achievementAbstinenceGoldName,
    'abstinence_master_45': (l10n) => l10n.achievementAbstinenceMaster45Name,
    'abstinence_diamond': (l10n) => l10n.achievementAbstinenceDiamondName,
    'abstinence_master_90': (l10n) => l10n.achievementAbstinenceMaster90Name,
    'abstinence_master_120': (l10n) => l10n.achievementAbstinenceMaster120Name,
    'monk_mode': (l10n) => l10n.achievementMonkModeName,
    'top_critic': (l10n) => l10n.achievementTopCriticName,
    'grand_master': (l10n) => l10n.achievementGrandMasterName,
    'explorer': (l10n) => l10n.achievementExplorerName,
    'globetrotter': (l10n) => l10n.achievementGlobetrotterName,
    'night_owl': (l10n) => l10n.achievementNightOwlName,
    'health_champion': (l10n) => l10n.achievementHealthChampionName,
    'archivist': (l10n) => l10n.achievementArchivistName,
  };

  static final Map<String, AchievementCopyBuilder> _descriptions = {
    'rookie': (l10n) => l10n.achievementRookieDesc,
    'legend': (l10n) => l10n.achievementLegendDesc,
    'sprinter': (l10n) => l10n.achievementSprinterDesc,
    'safe_player': (l10n) => l10n.achievementSafePlayerDesc,
    'hat_trick': (l10n) => l10n.achievementHatTrickDesc,
    'marathoner': (l10n) => l10n.achievementMarathonerDesc,
    'renaissance_man': (l10n) => l10n.achievementRenaissanceDesc,
    'fire_streak': (l10n) => l10n.achievementFireStreakDesc,
    'abstinence_bronze': (l10n) => l10n.achievementAbstinenceBronzeDesc,
    'abstinence_silver': (l10n) => l10n.achievementAbstinenceSilverDesc,
    'abstinence_gold': (l10n) => l10n.achievementAbstinenceGoldDesc,
    'abstinence_master_45': (l10n) => l10n.achievementAbstinenceMaster45Desc,
    'abstinence_diamond': (l10n) => l10n.achievementAbstinenceDiamondDesc,
    'abstinence_master_90': (l10n) => l10n.achievementAbstinenceMaster90Desc,
    'abstinence_master_120': (l10n) => l10n.achievementAbstinenceMaster120Desc,
    'monk_mode': (l10n) => l10n.achievementMonkModeDesc,
    'top_critic': (l10n) => l10n.achievementTopCriticDesc,
    'grand_master': (l10n) => l10n.achievementGrandMasterDesc,
    'explorer': (l10n) => l10n.achievementExplorerDesc,
    'globetrotter': (l10n) => l10n.achievementGlobetrotterDesc,
    'night_owl': (l10n) => l10n.achievementNightOwlDesc,
    'health_champion': (l10n) => l10n.achievementHealthChampionDesc,
    'archivist': (l10n) => l10n.achievementArchivistDesc,
  };

  static String localizeName(AppLocalizations l10n, String id, String fallback) {
    return _names[id]?.call(l10n) ?? fallback;
  }

  static String localizeDescription(
    AppLocalizations l10n,
    String id,
    String fallback,
  ) {
    return _descriptions[id]?.call(l10n) ?? fallback;
  }
}
