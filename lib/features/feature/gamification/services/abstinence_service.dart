import 'package:notch_app/data/models/encounter.dart';

class AbstinenceService {
  static int currentAbstinenceDays(
    List<Encounter> encounters, {
    DateTime? now,
  }) {
    if (encounters.isEmpty) return 0;
    final anchor = now ?? DateTime.now();
    final sorted = List<Encounter>.from(encounters)
      ..sort((a, b) => b.date.compareTo(a.date));
    return anchor.difference(sorted.first.date).inDays;
  }

  static int longestAbstinenceDays(
    List<Encounter> encounters, {
    DateTime? now,
  }) {
    if (encounters.length <= 1) {
      return currentAbstinenceDays(encounters, now: now);
    }

    final sorted = List<Encounter>.from(encounters)
      ..sort((a, b) => a.date.compareTo(b.date));

    var longest = 0;
    for (var i = 1; i < sorted.length; i++) {
      final gapDays = sorted[i].date.difference(sorted[i - 1].date).inDays;
      if (gapDays > longest) {
        longest = gapDays;
      }
    }

    final currentGap = currentAbstinenceDays(encounters, now: now);
    return currentGap > longest ? currentGap : longest;
  }

  static int longestAbstinenceDaysInRange(
    List<Encounter> encounters, {
    required DateTime start,
    required DateTime end,
    DateTime? now,
  }) {
    final rangeStart = _dateOnly(start);
    final rangeEnd = _dateOnly(end);
    final today = _dateOnly(now ?? DateTime.now());
    final effectiveEnd = today.isBefore(rangeEnd) ? today : rangeEnd;

    if (!effectiveEnd.isAfter(rangeStart)) return 0;

    final datesInRange =
        encounters
            .map((encounter) => _dateOnly(encounter.date))
            .where(
              (date) => !date.isBefore(rangeStart) && date.isBefore(rangeEnd),
            )
            .toSet()
            .toList()
          ..sort();

    if (datesInRange.isEmpty) return 0;

    var longest = 0;
    var previous = datesInRange.first;

    for (final date in datesInRange.skip(1)) {
      final gap = date.difference(previous).inDays;
      if (gap > longest) longest = gap;
      previous = date;
    }

    final trailingGap = effectiveEnd.difference(previous).inDays;
    return trailingGap > longest ? trailingGap : longest;
  }

  static int currentMonthAbstinenceDays({
    required List<Encounter> monthlyEncounters,
    required DateTime now,
  }) {
    if (monthlyEncounters.isNotEmpty) return 0;
    return now.day;
  }

  static DateTime _dateOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}
