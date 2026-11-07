import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/features/gamification/services/abstinence_service.dart';
import 'package:notch_app/features/gamification/services/challenge_progress_service.dart';
import 'package:notch_app/features/gamification/services/seasonal_expansion_challenges.dart';
import 'package:notch_app/features/gamification/services/seasonal_partner_challenges.dart';

final List<Challenge> seasonalChallenges = [
  Challenge(
    id: 'morning_master',
    title: 'Maestro Mañanero',
    description: 'Registra 5 encuentros con la etiqueta "Mañanero".',
    icon: Icons.wb_sunny,
    goal: 5,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.easy,
    progressCalculator: (encounters) => encounters
        .where((e) => e.tags.contains('tag_morning'))
        .length
        .toDouble(),
  ),
  Challenge(
    id: 'abstinence_21',
    title: 'Reto 21 de Abstinencia',
    description: 'Mantén 21 días seguidos sin registrar encuentros.',
    icon: Icons.self_improvement,
    goal: 21,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        AbstinenceService.currentAbstinenceDays(encounters).toDouble(),
  ),
  Challenge(
    id: 'abstinence_30',
    title: 'Reto 30 de Abstinencia',
    description: 'Mantén 30 días seguidos sin registrar encuentros.',
    icon: Icons.workspace_premium,
    goal: 30,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        AbstinenceService.currentAbstinenceDays(encounters).toDouble(),
  ),
  Challenge(
    id: 'weekly_explorer',
    title: 'Explorador Semanal',
    description: 'Usa 3 etiquetas diferentes en los últimos 7 días.',
    icon: Icons.explore,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeProgressService.distinctTagsInLastDays(
          encounters,
          7,
        ).toDouble(),
  ),
  Challenge(
    id: 'quality_week',
    title: 'Semana de Calidad',
    description:
        'Registra 8 encuentros en los últimos 7 días con promedio de 8.0+.',
    icon: Icons.star_border,
    goal: 8,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        ChallengeProgressService.qualityWeekProgress(
          encounters,
          days: 7,
          minimumRating: 8,
          goalCount: 8,
        ).toDouble(),
  ),
  Challenge(
    id: 'safety_champion',
    title: 'Campeón de la Seguridad',
    description: 'Logra 100% de protección en tus últimos 5 encuentros.',
    icon: Icons.security,
    goal: 5,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeProgressService.protectedCountInLastEncounters(
          encounters,
          5,
        ).toDouble(),
  ),
  Challenge(
    id: 'prelude_master',
    title: 'Maestro del Preludio',
    description:
        'Promedio de 9.0+ en 5 encuentros seguidos con la etiqueta "Oral".',
    icon: Icons.mic,
    goal: 5,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) {
      final oral = encounters.where((e) => e.tags.contains('tag_oral')).toList()
        ..sort((a, b) => b.date.compareTo(a.date));
      if (oral.length < 5) return 0;
      final avg = oral.take(5).map((e) => e.rating).reduce((a, b) => a + b) / 5;
      return avg >= 9 ? 5 : 0;
    },
  ),
  Challenge(
    id: 'steel_consistency',
    title: 'Constancia de Acero',
    description: 'Registra al menos 8 encuentros en la temporada actual.',
    icon: Icons.event_repeat,
    goal: 8,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeProgressService.currentMonthEncounterCount(
          encounters,
        ).toDouble(),
  ),
  Challenge(
    id: 'quality_club',
    title: 'El Club del 9+',
    description: 'Logra 5 encuentros este mes con calificación de 9 o 10.',
    icon: Icons.military_tech,
    goal: 5,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        ChallengeProgressService.currentMonthHighRatingCount(
          encounters,
          9,
        ).toDouble(),
  ),
  Challenge(
    id: 'perfect_weekend',
    title: 'Fin de Semana Perfecto',
    description:
        'Registra encuentros el Viernes, Sábado y Domingo en un finde, todos con calificación 8+.',
    icon: Icons.celebration,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeProgressService.perfectWeekendProgress(encounters).toDouble(),
  ),
  ...seasonalExpansionChallenges,
  ...seasonalPartnerChallenges,
];
