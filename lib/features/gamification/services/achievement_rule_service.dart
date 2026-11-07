import 'package:notch_app/data/models/encounter.dart';

class AchievementRuleService {
  const AchievementRuleService._();

  static bool hasRookieEncounter(List<Encounter> encounters) {
    return encounters.isNotEmpty;
  }

  static bool hasPerfectRating(Encounter encounter) {
    return encounter.rating == 10;
  }

  static bool hasMinimumOrgasmCount({
    required Encounter encounter,
    required int minCount,
  }) {
    return encounter.orgasmCount >= minCount;
  }

  static bool hasEncounterWindowWithinHours({
    required List<Encounter> encounters,
    required int windowSize,
    required int maxHours,
  }) {
    final sorted = List<Encounter>.from(encounters)
      ..sort((a, b) => a.date.compareTo(b.date));
    if (sorted.length < windowSize) return false;

    for (var index = 0; index <= sorted.length - windowSize; index++) {
      final start = sorted[index];
      final end = sorted[index + windowSize - 1];
      if (end.date.difference(start.date).inHours < maxHours) {
        return true;
      }
    }
    return false;
  }

  static bool hasConsecutiveMatches({
    required List<Encounter> encounters,
    required int minCount,
    required bool Function(Encounter encounter) predicate,
  }) {
    final sorted = List<Encounter>.from(encounters)
      ..sort((a, b) => a.date.compareTo(b.date));
    var streak = 0;

    for (final encounter in sorted) {
      if (predicate(encounter)) {
        streak++;
        if (streak >= minCount) return true;
      } else {
        streak = 0;
      }
    }
    return false;
  }

  static bool hasFireStreak(Map<String, int> streaks) {
    return (streaks['longest'] ?? 0) >= 7;
  }

  static bool hasFullWeekCoverage(List<Encounter> encounters) {
    return encounters.map((encounter) => encounter.date.weekday).toSet().length == 7;
  }

  static bool hasUniqueTagCount({
    required List<Encounter> encounters,
    required int minCount,
  }) {
    return encounters.expand((encounter) => encounter.tags).toSet().length >= minCount;
  }

  static bool hasEncounterTag({
    required Encounter encounter,
    required String tag,
  }) {
    return encounter.tags.contains(tag);
  }

  static bool hasMonkMode({
    required List<Encounter> allEncounters,
    required List<Encounter> monthlyEncounters,
    required DateTime now,
  }) {
    final hasPriorHistory = allEncounters.any(
      (encounter) =>
          encounter.date.year != now.year || encounter.date.month != now.month,
    );
    return hasPriorHistory && monthlyEncounters.isEmpty && now.day >= 7;
  }

  static bool hasWeekendMarathon(List<Encounter> encounters) {
    final sorted = List<Encounter>.from(encounters)
      ..sort((a, b) => a.date.compareTo(b.date));
    final countsByWeekend = <DateTime, int>{};

    for (final encounter in sorted) {
      if (encounter.date.weekday < DateTime.friday ||
          encounter.date.weekday > DateTime.sunday) {
        continue;
      }

      final friday = DateTime(
        encounter.date.year,
        encounter.date.month,
        encounter.date.day,
      ).subtract(Duration(days: encounter.date.weekday - DateTime.friday));
      countsByWeekend.update(friday, (value) => value + 1, ifAbsent: () => 1);
      if ((countsByWeekend[friday] ?? 0) >= 5) return true;
    }

    return false;
  }

  static bool hasGrandMasterLevel(Map<String, dynamic> level) {
    return level['name'] == 'Gran Maestro';
  }

  static bool hasLateNightCount({
    required List<Encounter> encounters,
    required int minCount,
  }) {
    return encounters
            .where((encounter) => encounter.date.hour >= 0 && encounter.date.hour < 6)
            .length >=
        minCount;
  }
}
