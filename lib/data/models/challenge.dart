import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';

enum ChallengeFamily { seasonal, historical }

enum ChallengeDifficulty { easy, medium, hard, historical, legendaryHistorical }

extension ChallengeDifficultyXp on ChallengeDifficulty {
  int get xpReward {
    switch (this) {
      case ChallengeDifficulty.easy:
        return 40;
      case ChallengeDifficulty.medium:
        return 75;
      case ChallengeDifficulty.hard:
        return 120;
      case ChallengeDifficulty.historical:
        return 180;
      case ChallengeDifficulty.legendaryHistorical:
        return 250;
    }
  }
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final int goal;
  final ChallengeFamily family;
  final ChallengeDifficulty difficulty;
  final double Function(List<Encounter> allEncounters) progressCalculator;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.goal,
    required this.family,
    required this.difficulty,
    required this.progressCalculator,
  });

  int get xpReward => difficulty.xpReward;

  double getProgress(List<Encounter> allEncounters) {
    return progressCalculator(allEncounters).clamp(0, goal.toDouble());
  }

  double getProgressPercent(List<Encounter> allEncounters) {
    if (goal == 0) return 1.0;
    return (getProgress(allEncounters) / goal).clamp(0.0, 1.0);
  }
}
