import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/core/utils/gamification_level_service.dart';
import 'package:notch_app/core/utils/gamification_streak_service.dart';

class GamificationProgressService {
  const GamificationProgressService._();

  static Future<MonthlyProgress> getCurrentMonthlyProgress() async {
    final box = Hive.box<MonthlyProgress>('monthly_progress');
    final currentMonthId = DateFormat('yyyy-MM').format(DateTime.now());
    try {
      return box.values.firstWhere((p) => p.monthId == currentMonthId);
    } catch (_) {
      await archiveLastMonthRank();
      final newProgress = MonthlyProgress(
        monthId: currentMonthId,
        xp: 0,
        unlockedBadges: [],
      );
      await box.add(newProgress);
      return newProgress;
    }
  }

  static Future<void> archiveLastMonthRank() async {
    final box = Hive.box<MonthlyProgress>('monthly_progress');
    final encounterBox = Hive.box<Encounter>('encounters');
    final lastMonthId = DateFormat(
      'yyyy-MM',
    ).format(DateTime.now().subtract(const Duration(days: 15)));
    try {
      final lastProgress = box.values.firstWhere(
        (p) => p.monthId == lastMonthId,
      );
      lastProgress.finalRank ??=
          GamificationLevelService.getCurrentLevel(lastProgress.xp)['name']
              as String?;
      lastProgress.longestStreakOfMonth ??= calculateStreaks(
        encounterBox,
        monthId: lastMonthId,
      )['longest'];
      await lastProgress.save();
    } catch (_) {}
  }

  static Map<String, int> calculateStreaks(
    Box<Encounter> encounterBox, {
    String? monthId,
  }) {
    final encounters = monthId == null
        ? encounterBox.values.toList()
        : encounterBox.values.where((e) {
            final monthDate = DateFormat('yyyy-MM').parse(monthId);
            return e.date.year == monthDate.year &&
                e.date.month == monthDate.month;
          }).toList();
    return GamificationStreakService.calculateStreaksFromEncounters(
      encounters,
      now: DateTime.now(),
      includeCurrent: monthId == null,
    );
  }
}
