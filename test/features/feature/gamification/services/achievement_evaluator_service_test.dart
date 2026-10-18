import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_evaluator_service.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_models.dart';

void main() {
  group('AchievementEvaluatorService', () {
    test('unlocks once and seasonal achievements into the right progress buckets', () {
      final globalProgress = GlobalProgress();
      final monthlyProgress = MonthlyProgress(monthId: '2026-06', xp: 0);
      final unlocked = AchievementEvaluatorService.evaluate(
        achievements: [
          _achievement(id: 'rookie', type: AchievementType.once),
          _achievement(id: 'legend'),
        ],
        monthlyProgress: monthlyProgress,
        globalProgress: globalProgress,
        data: const {'ok': true},
      );

      expect(unlocked.map((item) => item.id).toList(), ['rookie', 'legend']);
      expect(globalProgress.unlockedOnceAchievements, ['rookie']);
      expect(monthlyProgress.unlockedBadges, ['legend']);
    });

    test('skips already unlocked or failing achievements', () {
      final globalProgress = GlobalProgress(unlockedOnceAchievements: ['rookie']);
      final monthlyProgress = MonthlyProgress(
        monthId: '2026-06',
        xp: 0,
        unlockedBadges: ['legend'],
      );
      final unlocked = AchievementEvaluatorService.evaluate(
        achievements: [
          _achievement(id: 'rookie', type: AchievementType.once),
          _achievement(id: 'legend'),
          _achievement(id: 'hat_trick', condition: (_) => false),
        ],
        monthlyProgress: monthlyProgress,
        globalProgress: globalProgress,
        data: const {'ok': true},
      );

      expect(unlocked, isEmpty);
      expect(globalProgress.unlockedOnceAchievements, ['rookie']);
      expect(monthlyProgress.unlockedBadges, ['legend']);
    });
  });
}

Achievement _achievement({
  required String id,
  AchievementType type = AchievementType.seasonal,
  bool Function(Map<String, dynamic> data)? condition,
}) {
  return Achievement(
    id: id,
    name: id,
    description: id,
    icon: 'x',
    event: AchievementEvent.encounterSaved,
    type: type,
    condition: condition ?? (_) => true,
  );
}
