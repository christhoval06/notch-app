import 'package:flutter/material.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_mood_progress_service.dart';

final List<Challenge> seasonalMoodChallenges = [
  Challenge(
    id: 'mood_spectrum_3',
    title: 'Mood Spectrum',
    description: 'Registra 3 moods distintos en esta temporada.',
    icon: Icons.emoji_emotions_outlined,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.medium,
    progressCalculator: (encounters) =>
        ChallengeMoodProgressService.seasonalMoodDiversity(
          encounters,
          now: DateTime.now(),
        ).toDouble(),
  ),
  Challenge(
    id: 'high_spirits_3',
    title: 'High Spirits',
    description:
        'Registra 3 encuentros esta temporada con mood definido y calificacion de 8 o mas.',
    icon: Icons.local_fire_department_outlined,
    goal: 3,
    family: ChallengeFamily.seasonal,
    difficulty: ChallengeDifficulty.hard,
    progressCalculator: (encounters) =>
        ChallengeMoodProgressService.seasonalHighIntensityMoodCount(
          encounters,
          now: DateTime.now(),
          minimumRating: 8,
        ).toDouble(),
  ),
];
