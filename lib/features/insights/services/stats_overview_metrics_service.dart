import 'package:intl/intl.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/repositories/monthly_progress_repository.dart';
import 'package:notch_app/features/insights/services/stats_models.dart';

class StatsOverviewMetricsService {
  const StatsOverviewMetricsService._();

  static StatsRankData highestRank() {
    final progress = MonthlyProgressRepository.getAll();
    final highestXp = progress.fold<int>(
      0,
      (maxXp, item) => item.xp > maxXp ? item.xp : maxXp,
    );
    final level = GamificationEngine.getCurrentLevel(highestXp);
    return StatsRankData(
      rawLevelName: level['name'] as String,
      totalXp: level['current_total_xp'] as int? ?? highestXp,
    );
  }

  static List<StatsHeroMetric> heroMetrics(
    List<Encounter> current,
    List<Encounter> previous,
    double avgRating,
  ) {
    final previousOrgasms = previous.fold(
      0,
      (sum, item) => sum + item.orgasmCount,
    );
    final previousAvg = previous.isEmpty
        ? 0.0
        : previous.fold(0, (sum, item) => sum + item.rating) / previous.length;
    return [
      _hero('encounters', current.length, previous.length),
      _hero('rating', avgRating, previousAvg),
      _hero(
        'orgasms',
        current.fold(0, (sum, item) => sum + item.orgasmCount),
        previousOrgasms,
      ),
    ];
  }

  static StatsComparisonState summaryState(int current, int previous) {
    if (previous == 0) return StatsComparisonState.baseline;
    if (current > previous) return StatsComparisonState.up;
    if (current < previous) return StatsComparisonState.down;
    return StatsComparisonState.stable;
  }

  static List<StatsMonthlyDatum> monthlyData(
    List<Encounter> encounters,
    DateTime now,
  ) {
    return List.generate(6, (index) {
      final month = DateTime(now.year, now.month - (5 - index), 1);
      final count = encounters
          .where(
            (item) =>
                item.date.year == month.year && item.date.month == month.month,
          )
          .length;
      return StatsMonthlyDatum(
        label: DateFormat('MMM').format(month),
        value: count,
      );
    });
  }

  static StatsHeroMetric _hero(String id, num current, num previous) {
    final delta = current - previous;
    return StatsHeroMetric(
      id: id,
      currentValue: current,
      previousValue: previous,
      deltaLabel: delta == 0
          ? '0'
          : '${delta > 0 ? '+' : ''}${id == 'rating' ? (delta as double).toStringAsFixed(2) : delta}',
      trend: delta == 0
          ? StatsTrend.neutral
          : delta > 0
          ? StatsTrend.up
          : StatsTrend.down,
    );
  }
}
