import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/gamification/services/achievement_models.dart';

class AchievementUnlockService {
  const AchievementUnlockService._();

  static bool isUnlocked({
    required Achievement achievement,
    required MonthlyProgress monthlyProgress,
    required GlobalProgress globalProgress,
  }) {
    if (achievement.type == AchievementType.once) {
      return globalProgress.unlockedOnceAchievements.contains(achievement.id);
    }
    return monthlyProgress.unlockedBadges.contains(achievement.id);
  }

  static int unlockedCount({
    required List<Achievement> achievements,
    required MonthlyProgress monthlyProgress,
    required GlobalProgress globalProgress,
  }) {
    return achievements
        .where(
          (achievement) => isUnlocked(
            achievement: achievement,
            monthlyProgress: monthlyProgress,
            globalProgress: globalProgress,
          ),
        )
        .length;
  }
}
