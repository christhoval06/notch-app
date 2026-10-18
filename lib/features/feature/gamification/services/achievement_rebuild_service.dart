import 'package:intl/intl.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_catalog.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine_data_service.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_models.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_recalculation_service.dart';

class AchievementRebuildService {
  const AchievementRebuildService._();

  static Future<void> rebuild(AchievementRebuildData data) async {
    data.globalProgress.unlockedOnceAchievements.clear();
    for (final progress in data.monthlyProgressBox.values) {
      progress.unlockedBadges.clear();
    }

    for (var index = 0; index < data.allEncounters.length; index++) {
      final stepData = AchievementRecalculationService.buildEncounterStepData(
        sortedEncounters: data.allEncounters,
        currentIndex: index,
      );
      final monthProgress = await _resolveMonthProgress(
        data: data,
        monthId: DateFormat('yyyy-MM').format(
          data.allEncounters[index].date,
        ),
      );
      monthProgress.xp = stepData['monthlyXp'] as int;
      _unlockEncounterAchievements(
        stepData: stepData,
        monthProgress: monthProgress,
        data: data,
      );
    }

    _unlockHealthAchievements(data);
    await _persist(data);
  }

  static Future<MonthlyProgress> _resolveMonthProgress({
    required AchievementRebuildData data,
    required String monthId,
  }) async {
    try {
      return data.monthlyProgressBox.values.firstWhere(
        (progress) => progress.monthId == monthId,
      );
    } catch (_) {
      final progress = MonthlyProgress(monthId: monthId, xp: 0, unlockedBadges: []);
      await data.monthlyProgressBox.add(progress);
      return progress;
    }
  }

  static void _unlockEncounterAchievements({
    required Map<String, dynamic> stepData,
    required MonthlyProgress monthProgress,
    required AchievementRebuildData data,
  }) {
    final achievements = AchievementCatalog.all.where(
      (achievement) => achievement.event == AchievementEvent.encounterSaved,
    );
    for (final achievement in achievements) {
      final alreadyUnlocked = achievement.type == AchievementType.once
          ? data.globalProgress.unlockedOnceAchievements.contains(achievement.id)
          : monthProgress.unlockedBadges.contains(achievement.id);
      if (alreadyUnlocked || !achievement.condition(stepData)) continue;
      if (achievement.type == AchievementType.once) {
        data.globalProgress.unlockedOnceAchievements.add(achievement.id);
      } else {
        monthProgress.unlockedBadges.add(achievement.id);
      }
    }
  }

  static void _unlockHealthAchievements(AchievementRebuildData data) {
    final achievements = AchievementCatalog.all.where(
      (achievement) => achievement.event == AchievementEvent.healthLogSaved,
    );
    for (final achievement in achievements) {
      final unlocked = data.globalProgress.unlockedOnceAchievements.contains(
        achievement.id,
      );
      if (unlocked) continue;
      if (achievement.condition({'allHealthLogs': data.allHealthLogs})) {
        data.globalProgress.unlockedOnceAchievements.add(achievement.id);
      }
    }
  }

  static Future<void> _persist(AchievementRebuildData data) async {
    if (data.globalProgressBox.isNotEmpty) {
      await data.globalProgress.save();
    } else {
      await data.globalProgressBox.add(data.globalProgress);
    }
    for (final progress in data.monthlyProgressBox.values) {
      await progress.save();
    }
  }
}
