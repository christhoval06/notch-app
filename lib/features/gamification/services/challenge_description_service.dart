import 'package:notch_app/l10n/app_localizations.dart';

class ChallengeDescriptionService {
  const ChallengeDescriptionService._();

  static String localize(AppLocalizations l10n, String id) {
    switch (id) {
      case 'morning_master':
        return l10n.challengeMorningMasterDesc;
      case 'weekly_explorer':
        return l10n.challengeWeeklyExplorerDesc;
      case 'abstinence_21':
        return l10n.challengeAbstinence21Desc;
      case 'abstinence_30':
        return l10n.challengeAbstinence30Desc;
      case 'quality_week':
        return l10n.challengeQualityWeekDesc;
      case 'safety_champion':
        return l10n.challengeSafetyChampionDesc;
      case 'prelude_master':
        return l10n.challengePreludeMasterDesc;
      case 'steel_consistency':
        return l10n.challengeSteelConsistencyDesc;
      case 'quality_club':
        return l10n.challengeQualityClubDesc;
      case 'quality_streak_3':
        return l10n.challengeQualityStreak3Desc;
      case 'quality_streak_5':
        return l10n.challengeQualityStreak5Desc;
      case 'balanced_week':
        return l10n.challengeBalancedWeekDesc;
      case 'tag_combo_5':
        return l10n.challengeTagCombo5Desc;
      case 'social_circle_3':
        return l10n.challengeSocialCircle3Desc;
      case 'quality_network_3':
        return l10n.challengeQualityNetwork3Desc;
      case 'safe_network_3':
        return l10n.challengeSafeNetwork3Desc;
      case 'weekend_run_2':
        return l10n.challengeWeekendRun2Desc;
      case 'social_weekend_3':
        return l10n.challengeSocialWeekend3Desc;
      case 'event_mix_3':
        return l10n.challengeEventMix3Desc;
      case 'getaway_duo_2':
        return l10n.challengeGetawayDuo2Desc;
      case 'mood_spectrum_3':
        return l10n.challengeMoodSpectrum3Desc;
      case 'high_spirits_3':
        return l10n.challengeHighSpirits3Desc;
      case 'skill_mix_3':
        return l10n.challengeSkillMix3Desc;
      case 'pleasure_crafter_3':
        return l10n.challengePleasureCrafter3Desc;
      case 'connection_arc_3':
        return l10n.challengeConnectionArc3Desc;
      case 'date_night_2':
        return l10n.challengeDateNight2Desc;
      case 'single_partner_season':
        return l10n.challengeSinglePartnerSeasonDesc;
      case 'loyal_month':
        return l10n.challengeLoyalMonthDesc;
      case 'guardian_of_safety':
        return l10n.challengeGuardianOfSafetyDesc;
      case 'perfect_weekend':
        return l10n.challengePerfectWeekendDesc;
      case 'epic_morning':
        return l10n.challengeEpicMorningDesc;
      case 'frequent_flyer':
        return l10n.challengeFrequentFlyerDesc;
      case 'star_collector':
        return l10n.challengeStarCollectorDesc;
      case 'centurion':
        return l10n.challengeCenturionDesc;
      case 'legendary_guardian':
        return l10n.challengeLegendaryGuardianDesc;
      case 'single_partner_100':
        return l10n.challengeSinglePartner100Desc;
      case 'single_partner_500':
        return l10n.challengeSinglePartner500Desc;
      case 'steady_bond_50':
        return l10n.challengeSteadyBond50Desc;
      case 'constellation_10':
        return l10n.challengeConstellation10Desc;
      case 'polymath':
        return l10n.challengePolymathDesc;
      default:
        return id;
    }
  }
}
