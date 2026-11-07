import 'package:flutter/material.dart';
import 'package:notch_app/features/gamification/services/achievement_gradient_service.dart';

enum AchievementCategory { health, activity, exploration, tier }

extension AchievementUI on String {
  Gradient get achievementGradient {
    return AchievementGradientService.gradientFor(this);
  }

  String get achievementSvgPath {
    return 'assets/badges/$this.svg';
  }
}
