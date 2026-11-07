import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/features/gamification/services/challenge_partner_progress_service.dart';
import 'package:notch_app/features/gamification/services/challenge_seasonal_progress_service.dart';
import 'package:notch_app/features/gamification/services/seasonal_event_challenges.dart';
import 'package:notch_app/features/gamification/services/seasonal_skill_challenges.dart';
import 'package:notch_app/features/gamification/services/seasonal_mood_challenges.dart';
import 'package:notch_app/features/gamification/services/seasonal_relationship_challenges.dart';

final List<Challenge> seasonalExpansionChallenges = [
  Challenge(
    id: 'quality_streak_3',
    title: 'Racha de Calidad',
    description:
        'Logra 3 encuentros seguidos con calificación de 8 o más en la temporada actual.',
    icon: Icons.auto_awesome,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeSeasonalProgressService.seasonalQualityStreak(
          encounters,
          now: DateTime.now(),
          minimumRating: 8,
        ).toDouble(),
  ),
  Challenge(
    id: 'balanced_week',
    title: 'Semana Balanceada',
    description:
        'Registra encuentros en 3 días distintos dentro de los últimos 7 días.',
    icon: Icons.view_week_rounded,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeSeasonalProgressService.balancedWeekProgress(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  Challenge(
    id: 'tag_combo_5',
    title: 'Combo de Etiquetas',
    description: 'Usa 5 etiquetas distintas durante la temporada actual.',
    icon: Icons.sell_rounded,
    goal: 5,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        ChallengeSeasonalProgressService.seasonalDistinctTagCount(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  Challenge(
    id: 'social_circle_3',
    title: 'Circulo Social',
    description: 'Registra encuentros con 3 parejas distintas esta temporada.',
    icon: Icons.groups_rounded,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengePartnerProgressService.seasonalDistinctPartnerCount(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  Challenge(
    id: 'quality_network_3',
    title: 'Red de Calidad',
    description:
        'Registra encuentros con 3 parejas distintas esta temporada, cada una con calificacion de 8 o mas.',
    icon: Icons.emoji_events_outlined,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        ChallengePartnerProgressService.seasonalHighRatingPartnerCount(
          encounters,
          now: DateTime.now(),
          minimumRating: 8,
        ).toDouble(),
  ),
  Challenge(
    id: 'safe_network_3',
    title: 'Red Segura',
    description:
        'Registra encuentros protegidos con 3 parejas distintas esta temporada.',
    icon: Icons.shield_outlined,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        ChallengePartnerProgressService.seasonalProtectedPartnerCount(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  Challenge(
    id: 'weekend_run_2',
    title: 'Racha de Weekend',
    description:
        'Registra encuentros en 2 fines de semana consecutivos durante esta temporada.',
    icon: Icons.event_available,
    goal: 2,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeSeasonalProgressService.consecutiveWeekendRun(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  Challenge(
    id: 'social_weekend_3',
    title: 'Weekend Social',
    description:
        'Registra encuentros de fin de semana con 3 parejas distintas esta temporada.',
    icon: Icons.nightlife_rounded,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        ChallengePartnerProgressService.seasonalWeekendPartnerCount(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  ...seasonalEventChallenges,
  ...seasonalSkillChallenges,
  ...seasonalMoodChallenges,
  ...seasonalRelationshipChallenges,
];
