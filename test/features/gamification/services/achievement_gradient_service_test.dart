import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/features/gamification/services/achievement_gradient_service.dart';

void main() {
  test(
    'returns specific gradients for known ids and fallback for unknown ids',
    () {
      final health = AchievementGradientService.gradientFor('health_champion');
      final singlePartner = AchievementGradientService.gradientFor(
        'single_partner_badge',
      );
      final unknown = AchievementGradientService.gradientFor('unknown');

      expect(health, isA<LinearGradient>());
      expect(
        (singlePartner as LinearGradient).colors.first,
        isNot(Colors.grey),
      );
      expect((unknown as LinearGradient).colors.first, Colors.grey);
    },
  );
}
