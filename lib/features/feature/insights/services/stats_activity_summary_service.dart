import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';

class StatsActivitySummaryService {
  const StatsActivitySummaryService._();

  static StatsActivitySummary build(
    List<Encounter> encounters, {
    DateTime? now,
  }) {
    final normalizedDays = encounters
        .map((item) => DateTime(item.date.year, item.date.month, item.date.day))
        .toSet()
        .toList()
      ..sort();
    final anchor = DateTime(
      (now ?? DateTime.now()).year,
      (now ?? DateTime.now()).month,
      (now ?? DateTime.now()).day,
    );
    final currentWeekStart = anchor.subtract(const Duration(days: 6));
    final previousWeekStart = currentWeekStart.subtract(const Duration(days: 7));
    final previousWeekEnd = currentWeekStart.subtract(const Duration(days: 1));
    return StatsActivitySummary(
      activeDays: normalizedDays.length,
      busiestStreak: _streak(normalizedDays),
      currentWeekCount: normalizedDays
          .where((day) => !day.isBefore(currentWeekStart) && !day.isAfter(anchor))
          .length,
      previousWeekCount: normalizedDays
          .where((day) => !day.isBefore(previousWeekStart) && !day.isAfter(previousWeekEnd))
          .length,
    );
  }

  static int _streak(List<DateTime> days) {
    if (days.isEmpty) return 0;
    var best = 1;
    var current = 1;
    for (var index = 1; index < days.length; index++) {
      final diff = days[index].difference(days[index - 1]).inDays;
      current = diff == 1 ? current + 1 : 1;
      if (current > best) best = current;
    }
    return best;
  }
}
