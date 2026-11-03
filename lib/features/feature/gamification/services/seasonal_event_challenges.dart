import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_event_progress_service.dart';

final List<Challenge> seasonalEventChallenges = [
  Challenge(
    id: 'event_mix_3',
    title: 'Event Mix',
    description: 'Usa 3 etiquetas de eventos distintas esta temporada.',
    icon: Icons.local_activity_outlined,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeEventProgressService.seasonalEventTagCount(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  Challenge(
    id: 'getaway_duo_2',
    title: 'Getaway Duo',
    description:
        'Registra 2 encuentros esta temporada con etiquetas de escapada.',
    icon: Icons.luggage_rounded,
    goal: 2,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeEventProgressService.seasonalGetawayEncounterCount(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
];
