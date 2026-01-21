import 'package:flutter/material.dart';
import '../models/encounter.dart';

class Challenge {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final int goal;
  final double Function(List<Encounter> allEncounters) progressCalculator;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.goal,
    required this.progressCalculator,
  });

  double getProgress(List<Encounter> allEncounters) {
    return progressCalculator(allEncounters).clamp(0, goal.toDouble());
  }

  double getProgressPercent(List<Encounter> allEncounters) {
    if (goal == 0) return 1.0;
    return (getProgress(allEncounters) / goal).clamp(0.0, 1.0);
  }
}
