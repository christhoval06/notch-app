import 'package:notch_app/l10n/app_localizations.dart';

class ChallengeTitleService {
  const ChallengeTitleService._();

  static String localize(AppLocalizations l10n, String id) {
    switch (id) {
      case 'morning_master':
        return l10n.challengeMorningMasterTitle;
      case 'weekly_explorer':
        return l10n.challengeWeeklyExplorerTitle;
      case 'abstinence_21':
        return l10n.challengeAbstinence21Title;
      case 'abstinence_30':
        return l10n.challengeAbstinence30Title;
      case 'quality_week':
        return l10n.challengeQualityWeekTitle;
      case 'safety_champion':
        return l10n.challengeSafetyChampionTitle;
      case 'prelude_master':
        return l10n.challengePreludeMasterTitle;
      case 'steel_consistency':
        return l10n.challengeSteelConsistencyTitle;
      case 'quality_club':
        return l10n.challengeQualityClubTitle;
      case 'quality_streak_3':
        return l10n.challengeQualityStreak3Title;
      case 'quality_streak_5':
        return l10n.challengeQualityStreak5Title;
      case 'balanced_week':
        return l10n.challengeBalancedWeekTitle;
      case 'tag_combo_5':
        return l10n.challengeTagCombo5Title;
      case 'social_circle_3':
        return l10n.challengeSocialCircle3Title;
      case 'quality_network_3':
        return l10n.challengeQualityNetwork3Title;
      case 'safe_network_3':
        return l10n.challengeSafeNetwork3Title;
      case 'weekend_run_2':
        return l10n.challengeWeekendRun2Title;
      case 'social_weekend_3':
        return l10n.challengeSocialWeekend3Title;
      case 'event_mix_3':
        return l10n.challengeEventMix3Title;
      case 'getaway_duo_2':
        return l10n.challengeGetawayDuo2Title;
      case 'mood_spectrum_3':
        return l10n.challengeMoodSpectrum3Title;
      case 'high_spirits_3':
        return l10n.challengeHighSpirits3Title;
      case 'skill_mix_3':
        return l10n.challengeSkillMix3Title;
      case 'pleasure_crafter_3':
        return l10n.challengePleasureCrafter3Title;
      case 'connection_arc_3':
        return l10n.challengeConnectionArc3Title;
      case 'date_night_2':
        return l10n.challengeDateNight2Title;
      case 'single_partner_season':
        return l10n.challengeSinglePartnerSeasonTitle;
      case 'loyal_month':
        return l10n.challengeLoyalMonthTitle;
      case 'guardian_of_safety':
        return l10n.challengeGuardianOfSafetyTitle;
      case 'perfect_weekend':
        return l10n.challengePerfectWeekendTitle;
      case 'epic_morning':
        return l10n.challengeEpicMorningTitle;
      case 'frequent_flyer':
        return l10n.challengeFrequentFlyerTitle;
      case 'star_collector':
        return l10n.challengeStarCollectorTitle;
      case 'centurion':
        return l10n.challengeCenturionTitle;
      case 'legendary_guardian':
        return l10n.challengeLegendaryGuardianTitle;
      case 'single_partner_100':
        return l10n.challengeSinglePartner100Title;
      case 'single_partner_500':
        return l10n.challengeSinglePartner500Title;
      case 'steady_bond_50':
        return l10n.challengeSteadyBond50Title;
      case 'constellation_10':
        return l10n.challengeConstellation10Title;
      case 'polymath':
        return l10n.challengePolymathTitle;
      default:
        return id;
    }
  }
}
