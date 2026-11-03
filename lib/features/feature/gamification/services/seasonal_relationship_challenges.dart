import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_relationship_progress_service.dart';

final List<Challenge> seasonalRelationshipChallenges = [
  Challenge(
    id: 'connection_arc_3',
    title: 'Connection Arc',
    description: 'Usa 3 etiquetas de dinamicas relacionales esta temporada.',
    icon: Icons.favorite_outline,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeRelationshipProgressService.seasonalRelationshipTagCount(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  Challenge(
    id: 'date_night_2',
    title: 'Date Night',
    description:
        'Registra 2 encuentros esta temporada con etiquetas romanticas.',
    icon: Icons.favorite_border,
    goal: 2,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeRelationshipProgressService.seasonalRomanceEncounterCount(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
];
