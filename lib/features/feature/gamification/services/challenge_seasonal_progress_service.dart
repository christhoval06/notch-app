import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';

class ChallengeSeasonalProgressService {
  const ChallengeSeasonalProgressService._();

  static int seasonalQualityStreak(
    List<Encounter> encounters, {
    required DateTime now,
    required int minimumRating,
  }) {
    final seasonal = _currentSeasonEncounters(encounters, now);
    if (seasonal.isEmpty) return 0;
    var streak = 0;
    var best = 0;
    for (final entry in seasonal) {
      if (entry.rating >= minimumRating) {
        streak++;
        if (streak > best) best = streak;
      } else {
        streak = 0;
      }
    }
    return best;
  }

  static int balancedWeekProgress(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    final threshold = now.subtract(const Duration(days: 7));
    return encounters
        .where((entry) => entry.date.isAfter(threshold))
        .map(
          (entry) =>
              DateTime(entry.date.year, entry.date.month, entry.date.day),
        )
        .toSet()
        .length;
  }

  static int seasonalDistinctTagCount(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    return _currentSeasonEncounters(
      encounters,
      now,
    ).expand((entry) => entry.tags).toSet().length;
  }

  static int consecutiveWeekendRun(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    final weekends =
        _currentSeasonEncounters(encounters, now)
            .where((entry) => entry.date.weekday >= DateTime.friday)
            .map((entry) => _fridayAnchor(entry.date))
            .toSet()
            .toList()
          ..sort();
    if (weekends.isEmpty) return 0;
    var streak = 1;
    var best = 1;
    for (var index = 1; index < weekends.length; index++) {
      final gap = weekends[index].difference(weekends[index - 1]).inDays;
      streak = gap == 7 ? streak + 1 : 1;
      if (streak > best) best = streak;
    }
    return best;
  }

  static List<Encounter> _currentSeasonEncounters(
    List<Encounter> encounters,
    DateTime now,
  ) {
    final monthId = DateFormat('yyyy-MM').format(now);
    final seasonal =
        encounters
            .where(
              (entry) => DateFormat('yyyy-MM').format(entry.date) == monthId,
            )
            .toList()
          ..sort((a, b) => a.date.compareTo(b.date));
    return seasonal;
  }

  static DateTime _fridayAnchor(DateTime value) {
    return DateTime(
      value.year,
      value.month,
      value.day,
    ).subtract(Duration(days: value.weekday - DateTime.friday));
  }
}
