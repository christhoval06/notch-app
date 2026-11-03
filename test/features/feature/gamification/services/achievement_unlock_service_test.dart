import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_models.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_unlock_service.dart';

void main() {
  group('AchievementUnlockService', () {
    test('treats once achievements from global progress as unlocked', () {
      final unlocked = AchievementUnlockService.isUnlocked(
        achievement: Achievement(
          id: 'rookie',
          name: 'Rookie',
          description: 'First encounter',
          icon: '🌱',
          event: AchievementEvent.encounterSaved,
          type: AchievementType.once,
          condition: (_) => true,
        ),
        monthlyProgress: MonthlyProgress(monthId: '2026-06', xp: 0),
        globalProgress: GlobalProgress(unlockedOnceAchievements: ['rookie']),
      );

      expect(unlocked, isTrue);
    });

    test('treats seasonal achievements from month progress as unlocked', () {
      final unlocked = AchievementUnlockService.isUnlocked(
        achievement: Achievement(
          id: 'legend',
          name: 'Legend',
          description: 'Perfect score',
          icon: '🦄',
          event: AchievementEvent.encounterSaved,
          condition: (_) => true,
        ),
        monthlyProgress: MonthlyProgress(
          monthId: '2026-06',
          xp: 0,
          unlockedBadges: ['legend'],
        ),
        globalProgress: GlobalProgress(),
      );

      expect(unlocked, isTrue);
    });
  });
}
