import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/core/utils/gamification_level_service.dart';
import 'package:notch_app/core/utils/gamification_progress_service.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/gamification/services/achievement_engine.dart';
import 'package:notch_app/features/gamification/services/challenge_reward_service.dart';

class GamificationXpService {
  const GamificationXpService._();

  static void _log(String message) =>
      debugPrint('[GamificationXpService] $message');

  static int xpForEncounter(Encounter encounter) {
    var xp = 50 + (encounter.rating * 10);
    if (encounter.protected) xp += 20;
    return xp;
  }

  static Future<void> recalculateAllXp() async {
    _log('Starting XP recalculation');
    final encounterBox = Hive.box<Encounter>('encounters');
    final monthlyProgressBox = Hive.box<MonthlyProgress>('monthly_progress');
    final encountersByMonth = <String, List<Encounter>>{};
    for (final encounter in encounterBox.values) {
      final monthId = DateFormat('yyyy-MM').format(encounter.date);
      encountersByMonth.putIfAbsent(monthId, () => []).add(encounter);
    }
    for (final entry in encountersByMonth.entries) {
      final totalXp = entry.value.fold<int>(
        0,
        (sum, encounter) => sum + xpForEncounter(encounter),
      );
      final challengeRewardXp = _challengeRewardXpForMonth(
        entry.key,
        monthlyProgressBox,
      );
      try {
        final progress = monthlyProgressBox.values.firstWhere(
          (p) => p.monthId == entry.key,
        );
        progress.xp = totalXp + challengeRewardXp;
        await progress.save();
      } catch (_) {
        await monthlyProgressBox.add(
          MonthlyProgress(monthId: entry.key, xp: totalXp + challengeRewardXp),
        );
      }
    }
    final monthsWithEncounters = encounterBox.values
        .map((e) => DateFormat('yyyy-MM').format(e.date))
        .toSet();
    for (final progress in monthlyProgressBox.values.toList()) {
      if (!monthsWithEncounters.contains(progress.monthId) &&
          progress.claimedChallengeRewardIds.isEmpty) {
        await progress.delete();
      }
    }
    _log('XP recalculation completed');
  }

  static int _challengeRewardXpForMonth(
    String monthId,
    Box<MonthlyProgress> monthlyProgressBox,
  ) {
    try {
      final progress = monthlyProgressBox.values.firstWhere(
        (entry) => entry.monthId == monthId,
      );
      return ChallengeRewardService.rewardXpForIds(
        progress.claimedChallengeRewardIds,
      );
    } catch (_) {
      return 0;
    }
  }

  static Future<void> deleteEncounter(Encounter encounterToDelete) async {
    final monthlyProgressBox = Hive.box<MonthlyProgress>('monthly_progress');
    final monthId = DateFormat('yyyy-MM').format(encounterToDelete.date);
    try {
      final progress = monthlyProgressBox.values.firstWhere(
        (p) => p.monthId == monthId,
      );
      progress.xp = (progress.xp - xpForEncounter(encounterToDelete))
          .clamp(0, double.infinity)
          .toInt();
      await progress.save();
    } catch (_) {}
    await encounterToDelete.delete();
    await _recalculateAchievementsForMonth(monthId);
  }

  static Future<void> _recalculateAchievementsForMonth(String monthId) async {
    final monthlyProgressBox = Hive.box<MonthlyProgress>('monthly_progress');
    final encounterBox = Hive.box<Encounter>('encounters');
    final globalProgressBox = Hive.box<GlobalProgress>('global_progress');
    try {
      final progress = monthlyProgressBox.values.firstWhere(
        (p) => p.monthId == monthId,
      );
      final globalProgress = globalProgressBox.isNotEmpty
          ? globalProgressBox.getAt(0)!
          : GlobalProgress();
      final allEncounters = encounterBox.values.toList();
      final encountersOfMonth = allEncounters
          .where((e) => DateFormat('yyyy-MM').format(e.date) == monthId)
          .toList();
      progress.unlockedBadges.clear();
      for (final achievement in AchievementEngine.getAllAchievements()) {
        if (achievement.type == AchievementType.once &&
            globalProgress.unlockedOnceAchievements.contains(achievement.id)) {
          continue;
        }
        var unlockedThisMonth = false;
        if (achievement.event == AchievementEvent.encounterSaved) {
          for (final currentEncounter in encountersOfMonth) {
            final data = {
              'newEncounter': currentEncounter,
              'allEncounters': allEncounters
                  .where((e) => !e.date.isAfter(currentEncounter.date))
                  .toList(),
              'monthlyEncounters': encountersOfMonth
                  .where((e) => !e.date.isAfter(currentEncounter.date))
                  .toList(),
              'streaks': GamificationProgressService.calculateStreaks(
                encounterBox,
              ),
              'level': GamificationLevelService.getCurrentLevel(progress.xp),
            };
            if (achievement.condition(data)) {
              unlockedThisMonth = true;
              break;
            }
          }
        }
        if (unlockedThisMonth &&
            !progress.unlockedBadges.contains(achievement.id)) {
          progress.unlockedBadges.add(achievement.id);
        }
      }
      await progress.save();
    } catch (_) {}
  }
}
