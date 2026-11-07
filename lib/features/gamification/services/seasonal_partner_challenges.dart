import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/features/gamification/services/challenge_partner_progress_service.dart';

final List<Challenge> seasonalPartnerChallenges = [
  Challenge(
    id: 'single_partner_season',
    title: 'Solo una Pareja',
    description:
        'Registra 8 encuentros en la temporada actual con una sola pareja.',
    icon: Icons.favorite_border,
    goal: 8,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        ChallengePartnerProgressService.seasonalSinglePartnerProgress(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  Challenge(
    id: 'loyal_month',
    title: 'Mes Leal',
    description:
        'Registra 12 encuentros en la temporada actual con una sola pareja.',
    icon: Icons.favorite_outline,
    goal: 12,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        ChallengePartnerProgressService.seasonalSinglePartnerProgress(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
];
