import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_historical_progress_service.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_partner_progress_service.dart';

final List<Challenge> historicalExpansionChallenges = [
  Challenge(
    id: 'quality_streak_5',
    title: 'Calidad Imparable',
    description: 'Logra 5 encuentros seguidos con calificación de 8 o más.',
    icon: Icons.local_fire_department,
    goal: 5,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.historical,
    progressCalculator: (encounters) =>
        ChallengeHistoricalProgressService.qualityStreak(
          encounters,
          minimumRating: 8,
        ).toDouble(),
  ),
  Challenge(
    id: 'steady_bond_50',
    title: 'Lazo Seguro',
    description: 'Acumula 50 encuentros protegidos con una sola pareja.',
    icon: Icons.verified_user,
    goal: 50,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.legendaryHistorical,
    progressCalculator: (encounters) =>
        ChallengePartnerProgressService.historicalProtectedPartnerProgress(
          encounters,
        ).toDouble(),
  ),
  Challenge(
    id: 'constellation_10',
    title: 'Constelacion',
    description:
        'Registra encuentros con 10 parejas distintas en tu historial.',
    icon: Icons.hub_rounded,
    goal: 10,
    family: ChallengeFamily.historical,
    difficulty: ChallengeDifficulty.historical,
    progressCalculator: (encounters) =>
        ChallengePartnerProgressService.historicalDistinctPartnerCount(
          encounters,
        ).toDouble(),
  ),
];
