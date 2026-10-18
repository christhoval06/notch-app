import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/gamification/services/abstinence_service.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_unlock_service.dart';
import 'package:notch_app/features/feature/gamification/services/season_activity_metrics_service.dart';
import 'package:notch_app/core/utils/gamification_streak_service.dart';

class TrophyRoomViewModel {
  const TrophyRoomViewModel({
    required this.monthIds,
    required this.selectedMonthId,
    required this.progress,
    required this.globalProgress,
    required this.allEncounters,
    required this.isCurrentMonth,
    required this.currentStreak,
    required this.seasonBestStreak,
    required this.allTimeBestStreak,
    required this.seasonalAbstinenceRecord,
    required this.historicalAbstinenceRecord,
    required this.activityMetrics,
    required this.unlockedCount,
    required this.allCount,
  });

  final List<String> monthIds;
  final String selectedMonthId;
  final MonthlyProgress progress;
  final GlobalProgress globalProgress;
  final List<Encounter> allEncounters;
  final bool isCurrentMonth;
  final int currentStreak;
  final int seasonBestStreak;
  final int allTimeBestStreak;
  final int seasonalAbstinenceRecord;
  final int historicalAbstinenceRecord;
  final SeasonActivityMetrics activityMetrics;
  final int unlockedCount;
  final int allCount;
}

class TrophyRoomViewModelService {
  const TrophyRoomViewModelService._();

  static TrophyRoomViewModel build({
    required Iterable<MonthlyProgress> monthlyEntries,
    required List<Encounter> allEncounters,
    required GlobalProgress globalProgress,
    String? selectedMonthId,
  }) {
    final monthIds = monthlyEntries.map((entry) => entry.monthId).toList()
      ..sort((a, b) => b.compareTo(a));
    final activeMonthId = selectedMonthId ?? monthIds.first;
    final progress = monthlyEntries.firstWhere(
      (entry) => entry.monthId == activeMonthId,
    );
    final isCurrentMonth =
        activeMonthId == DateFormat('yyyy-MM').format(DateTime.now());
    final selectedMonthDate = DateFormat('yyyy-MM').parse(activeMonthId);
    final selectedMonthStart = DateTime(
      selectedMonthDate.year,
      selectedMonthDate.month,
    );
    final selectedMonthEnd = DateTime(
      selectedMonthDate.year,
      selectedMonthDate.month + 1,
    );
    final streaksOfSelectedMonth =
        GamificationStreakService.calculateStreaksFromEncounters(
          allEncounters.where((encounter) {
            return encounter.date.year == selectedMonthDate.year &&
                encounter.date.month == selectedMonthDate.month;
          }).toList(),
          now: DateTime.now(),
          includeCurrent: false,
        );
    final allTimeStreaks =
        GamificationStreakService.calculateStreaksFromEncounters(
          allEncounters,
          now: DateTime.now(),
        );

    return TrophyRoomViewModel(
      monthIds: monthIds,
      selectedMonthId: activeMonthId,
      progress: progress,
      globalProgress: globalProgress,
      allEncounters: allEncounters,
      isCurrentMonth: isCurrentMonth,
      currentStreak: allTimeStreaks['current']!,
      seasonBestStreak:
          progress.longestStreakOfMonth ?? streaksOfSelectedMonth['longest']!,
      allTimeBestStreak: allTimeStreaks['longest']!,
      seasonalAbstinenceRecord: AbstinenceService.longestAbstinenceDaysInRange(
        allEncounters,
        start: selectedMonthStart,
        end: selectedMonthEnd,
      ),
      historicalAbstinenceRecord: AbstinenceService.longestAbstinenceDays(
        allEncounters,
      ),
      activityMetrics: SeasonActivityMetricsService.build(
        allEncounters: allEncounters,
        monthId: activeMonthId,
      ),
      unlockedCount: AchievementUnlockService.unlockedCount(
        achievements: AchievementEngine.getAllAchievements(),
        monthlyProgress: progress,
        globalProgress: globalProgress,
      ),
      allCount: AchievementEngine.getAllAchievements().length,
    );
  }
}
