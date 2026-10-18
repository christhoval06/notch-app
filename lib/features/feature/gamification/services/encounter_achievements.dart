import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_models.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_rule_service.dart';

final List<Achievement> encounterAchievements = [
  Achievement(
    id: 'rookie',
    name: 'El Debut',
    description: 'Registra tu primer encuentro.',
    icon: '🌱',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasRookieEncounter(
      data['allEncounters'] as List<Encounter>,
    ),
    type: AchievementType.once,
  ),
  Achievement(
    id: 'legend',
    name: 'Legendario',
    description: 'Logra una calificación perfecta de 10/10.',
    icon: '🦄',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasPerfectRating(
      data['newEncounter'] as Encounter,
    ),
  ),
  Achievement(
    id: 'sprinter',
    name: 'Sprinter',
    description: '3 encuentros en menos de 24 horas.',
    icon: '⚡',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasEncounterWindowWithinHours(
      encounters: data['monthlyEncounters'] as List<Encounter>,
      windowSize: 3,
      maxHours: 24,
    ),
  ),
  Achievement(
    id: 'safe_player',
    name: 'Jugador Seguro',
    description: 'Racha de 10 encuentros protegidos.',
    icon: '🛡️',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasConsecutiveMatches(
      encounters: data['monthlyEncounters'] as List<Encounter>,
      minCount: 10,
      predicate: (encounter) => encounter.protected,
    ),
  ),
  Achievement(
    id: 'hat_trick',
    name: 'Hat-Trick',
    description: '3 orgasmos o más en un solo encuentro.',
    icon: '⚽',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasMinimumOrgasmCount(
      encounter: data['newEncounter'] as Encounter,
      minCount: 3,
    ),
  ),
  Achievement(
    id: 'marathoner',
    name: 'Maratonista',
    description: '5 encuentros en un fin de semana (Vie-Dom) en un mes.',
    icon: '🏃‍♂️',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasWeekendMarathon(
      data['monthlyEncounters'] as List<Encounter>,
    ),
  ),
  Achievement(
    id: 'renaissance_man',
    name: 'Hombre Renacentista',
    description: 'Actividad en cada día de la semana en un mes.',
    icon: '🎨',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasFullWeekCoverage(
      data['monthlyEncounters'] as List<Encounter>,
    ),
  ),
  Achievement(
    id: 'fire_streak',
    name: 'Racha de Fuego',
    description: 'Mantén una racha de 7 días seguidos.',
    icon: '🔥',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasFireStreak(
      data['streaks'] as Map<String, int>,
    ),
  ),
  Achievement(
    id: 'top_critic',
    name: 'Crítico Exigente',
    description: '5 encuentros seguidos con calificación de 9+.',
    icon: '🧐',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasConsecutiveMatches(
      encounters: data['monthlyEncounters'] as List<Encounter>,
      minCount: 5,
      predicate: (encounter) => encounter.rating >= 9,
    ),
  ),
  Achievement(
    id: 'grand_master',
    name: 'Gran Maestro',
    description: 'Alcanza el rango "Gran Maestro" en una temporada.',
    icon: '🏛️',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasGrandMasterLevel(
      data['level'] as Map<String, dynamic>,
    ),
  ),
  Achievement(
    id: 'explorer',
    name: 'Explorador',
    description: 'Usa 5 etiquetas diferentes en un mes.',
    icon: '🧭',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasUniqueTagCount(
      encounters: data['monthlyEncounters'] as List<Encounter>,
      minCount: 5,
    ),
  ),
  Achievement(
    id: 'globetrotter',
    name: 'Trotamundos',
    description: 'Registra un encuentro con la etiqueta "Viaje".',
    icon: '🌍',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasEncounterTag(
      encounter: data['newEncounter'] as Encounter,
      tag: 'tag_travel',
    ),
  ),
  Achievement(
    id: 'night_owl',
    name: 'Noctámbulo',
    description: '10 encuentros registrados después de la medianoche.',
    icon: '🦉',
    event: AchievementEvent.encounterSaved,
    condition: (data) => AchievementRuleService.hasLateNightCount(
      encounters: data['allEncounters'] as List<Encounter>,
      minCount: 10,
    ),
  ),
];
