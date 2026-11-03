import 'package:hive/hive.dart';
import 'package:notch_app/core/utils/gamification_level_service.dart';
import 'package:notch_app/core/utils/gamification_progress_service.dart';
import 'package:notch_app/core/utils/gamification_xp_service.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/repositories/global_progress_repository.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_reward_service.dart';

class GamificationEngine {
  static const levels = GamificationLevelService.levels;
  static const streakMilestones = GamificationLevelService.streakMilestones;

  static Map<String, int> getNextStreakMilestone(int currentStreak) {
    return GamificationLevelService.getNextStreakMilestone(currentStreak);
  }

  static Future<MonthlyProgress> getCurrentMonthlyProgress() {
    return GamificationProgressService.getCurrentMonthlyProgress();
  }

  static Future<List<Achievement>> processEncounter(
    Encounter newEncounter,
  ) async {
    final progress = await getCurrentMonthlyProgress();
    final encounterBox = Hive.box<Encounter>('encounters');
    progress.xp += GamificationXpService.xpForEncounter(newEncounter);
    await progress.save();

    final allEncounters = encounterBox.values.toList();
    final currentMonth = newEncounter.date;
    final monthlyEncounters = allEncounters
        .where(
          (e) =>
              e.date.year == currentMonth.year &&
              e.date.month == currentMonth.month,
        )
        .toList();

    if (monthlyEncounters.isNotEmpty &&
        progress.unlockedBadges.contains('monk_mode')) {
      progress.unlockedBadges = List<String>.from(progress.unlockedBadges)
        ..remove('monk_mode');
      await progress.save();
    }

    final globalProgress = await GlobalProgressRepository.getOrCreate();
    await ChallengeRewardService.syncRewards(
      allEncounters: allEncounters,
      monthlyProgress: progress,
      globalProgress: globalProgress,
    );

    return AchievementEngine.processEvent(
      event: AchievementEvent.encounterSaved,
      data: {
        'newEncounter': newEncounter,
        'allEncounters': allEncounters,
        'monthlyEncounters': monthlyEncounters,
        'streaks': calculateStreaks(encounterBox),
        'level': getCurrentLevel(progress.xp),
      },
    );
  }

  static Map<String, dynamic> getCurrentLevel(int xp) {
    return GamificationLevelService.getCurrentLevel(xp);
  }

  static Map<String, int> calculateStreaks(
    Box<Encounter> encounterBox, {
    String? monthId,
  }) {
    return GamificationProgressService.calculateStreaks(
      encounterBox,
      monthId: monthId,
    );
  }

  static Future<void> recalculateAllXp() {
    return GamificationXpService.recalculateAllXp();
  }

  static Future<void> deleteEncounter(Encounter encounterToDelete) {
    return GamificationXpService.deleteEncounter(encounterToDelete);
  }
}
