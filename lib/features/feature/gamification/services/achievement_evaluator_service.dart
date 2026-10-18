import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_models.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_unlock_service.dart';

class AchievementEvaluatorService {
  const AchievementEvaluatorService._();

  static List<Achievement> evaluate({
    required Iterable<Achievement> achievements,
    required MonthlyProgress monthlyProgress,
    required GlobalProgress globalProgress,
    required Map<String, dynamic> data,
  }) {
    final unlocked = <Achievement>[];

    for (final achievement in achievements) {
      final isAlreadyUnlocked = AchievementUnlockService.isUnlocked(
        achievement: achievement,
        monthlyProgress: monthlyProgress,
        globalProgress: globalProgress,
      );
      if (isAlreadyUnlocked || !achievement.condition(data)) continue;

      unlocked.add(achievement);
      if (achievement.type == AchievementType.once) {
        globalProgress.unlockedOnceAchievements = List<String>.from(
          globalProgress.unlockedOnceAchievements,
        )..add(achievement.id);
      } else {
        monthlyProgress.unlockedBadges = List<String>.from(
          monthlyProgress.unlockedBadges,
        )..add(achievement.id);
      }
    }

    return unlocked;
  }
}
