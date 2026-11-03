import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/data/models/encounter.dart';

class ChallengeProgressService {
  const ChallengeProgressService._();

  static int distinctTagsInLastDays(List<Encounter> encounters, int days) {
    final threshold = DateTime.now().subtract(Duration(days: days));
    return encounters
        .where((entry) => entry.date.isAfter(threshold))
        .expand((entry) => entry.tags)
        .toSet()
        .length;
  }

  static double averageRatingInLastDays(List<Encounter> encounters, int days) {
    final threshold = DateTime.now().subtract(Duration(days: days));
    final recent = encounters
        .where((entry) => entry.date.isAfter(threshold))
        .toList();
    if (recent.isEmpty) return 0;
    final total = recent.map((entry) => entry.rating).reduce((a, b) => a + b);
    return total / recent.length;
  }

  static int qualityWeekProgress(
    List<Encounter> encounters, {
    required int days,
    required int minimumRating,
    required int goalCount,
  }) {
    final threshold = DateTime.now().subtract(Duration(days: days));
    final recent = encounters
        .where((entry) => entry.date.isAfter(threshold))
        .toList();
    if (recent.isEmpty) return 0;
    final average =
        recent.map((entry) => entry.rating).reduce((a, b) => a + b) /
        recent.length;
    if (average < minimumRating) return 0;
    return recent.length.clamp(0, goalCount);
  }

  static int protectedCountInLastEncounters(
    List<Encounter> encounters,
    int count,
  ) {
    if (encounters.length < count) return 0;
    final sorted = List<Encounter>.from(encounters)
      ..sort((a, b) => b.date.compareTo(a.date));
    return sorted.take(count).where((entry) => entry.protected).length;
  }

  static int longestProtectedStreak(List<Encounter> encounters) {
    final sorted = List<Encounter>.from(encounters)
      ..sort((a, b) => a.date.compareTo(b.date));
    var current = 0;
    var best = 0;
    for (final entry in sorted) {
      if (entry.protected) {
        current++;
        if (current > best) best = current;
      } else {
        current = 0;
      }
    }
    return best;
  }

  static int perfectWeekendProgress(List<Encounter> encounters) {
    final weekends = <DateTime, Set<int>>{};
    for (final entry in encounters) {
      if (entry.rating < 8 || entry.date.weekday < DateTime.friday) continue;
      final friday = _fridayAnchor(entry.date);
      weekends.putIfAbsent(friday, () => <int>{}).add(entry.date.weekday);
    }
    return weekends.values.fold<int>(
      0,
      (best, days) => days.length > best ? days.length : best,
    );
  }

  static int currentMonthEncounterCount(List<Encounter> encounters) {
    final now = DateTime.now();
    return encounters
        .where(
          (entry) =>
              entry.date.year == now.year && entry.date.month == now.month,
        )
        .length;
  }

  static int currentMonthHighRatingCount(
    List<Encounter> encounters,
    int minimumRating,
  ) {
    final now = DateTime.now();
    return encounters.where((entry) {
      return entry.date.year == now.year &&
          entry.date.month == now.month &&
          entry.rating >= minimumRating;
    }).length;
  }

  static double protectionRatePercent(
    List<Encounter> encounters, {
    required int minimumEncounters,
  }) {
    if (encounters.length < minimumEncounters) return 0;
    final protectedCount = encounters.where((entry) => entry.protected).length;
    return (protectedCount / encounters.length) * 100;
  }

  static Challenge? pickFeaturedChallenge(
    List<Challenge> challenges,
    List<Encounter> encounters,
  ) {
    Challenge? best;
    var bestPercent = -1.0;
    for (final challenge in challenges) {
      final percent = challenge.getProgressPercent(encounters);
      if (percent >= 1) continue;
      if (percent > bestPercent) {
        best = challenge;
        bestPercent = percent;
      }
    }
    return best ?? (challenges.isEmpty ? null : challenges.first);
  }

  static DateTime _fridayAnchor(DateTime value) {
    return DateTime(
      value.year,
      value.month,
      value.day,
    ).subtract(Duration(days: value.weekday - DateTime.friday));
  }
}
