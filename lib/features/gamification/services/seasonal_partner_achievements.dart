import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/gamification/services/achievement_models.dart';
import 'package:notch_app/features/gamification/services/achievement_partner_rule_service.dart';

final List<Achievement> seasonalPartnerAchievements = [
  Achievement(
    id: 'single_partner_badge',
    name: 'Solo para Ti',
    description: 'Registra 8 encuentros en la temporada con una sola pareja.',
    icon: '💞',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementPartnerRuleService.hasSeasonalSinglePartner(
      monthlyEncounters: data['monthlyEncounters'] as List<Encounter>,
      minimumEncounters: 8,
    ),
  ),
  Achievement(
    id: 'multiple_partners_badge',
    name: 'Circulo Abierto',
    description: 'Registra encuentros con 3 parejas distintas en la temporada.',
    icon: '🎭',
    event: AchievementEvent.encounterSaved,
    condition: (data) =>
        AchievementPartnerRuleService.hasSeasonalMultiplePartners(
          monthlyEncounters: data['monthlyEncounters'] as List<Encounter>,
          minimumPartners: 3,
        ),
  ),
];
