import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/data/models/encounter.dart';

class AchievementRecalculationService {
  const AchievementRecalculationService._();

  static Map<String, dynamic> buildEncounterStepData({
    required List<Encounter> sortedEncounters,
    required int currentIndex,
  }) {
    final currentEncounter = sortedEncounters[currentIndex];
    final encountersUpToThisPoint = sortedEncounters.sublist(
      0,
      currentIndex + 1,
    );
    final monthlyUpToThisPoint = encountersUpToThisPoint
        .where(
          (encounter) =>
              encounter.date.year == currentEncounter.date.year &&
              encounter.date.month == currentEncounter.date.month,
        )
        .toList();

    return {
      'newEncounter': currentEncounter,
      'allEncounters': encountersUpToThisPoint,
      'monthlyEncounters': monthlyUpToThisPoint,
      'streaks': _calculateHistoricalStreaks(encountersUpToThisPoint),
      'monthlyXp': _calculateMonthlyXp(monthlyUpToThisPoint),
      'level': GamificationEngine.getCurrentLevel(
        _calculateMonthlyXp(monthlyUpToThisPoint),
      ),
    };
  }

  static Map<String, int> _calculateHistoricalStreaks(
    List<Encounter> encounters,
  ) {
    if (encounters.isEmpty) return {'current': 0, 'longest': 0};

    final uniqueDays =
        encounters
            .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
            .toSet()
            .toList()
          ..sort();

    var currentStreak = 1;
    var runningStreak = 1;
    var longestStreak = 1;

    for (var index = 1; index < uniqueDays.length; index++) {
      if (uniqueDays[index].difference(uniqueDays[index - 1]).inDays == 1) {
        runningStreak++;
      } else {
        longestStreak = runningStreak > longestStreak
            ? runningStreak
            : longestStreak;
        runningStreak = 1;
      }
    }

    currentStreak = runningStreak;
    longestStreak = runningStreak > longestStreak
        ? runningStreak
        : longestStreak;
    return {'current': currentStreak, 'longest': longestStreak};
  }

  static int _calculateMonthlyXp(List<Encounter> encounters) {
    return encounters.fold(0, (total, encounter) {
      var xp = 50 + (encounter.rating * 10);
      if (encounter.protected) xp += 20;
      return total + xp;
    });
  }
}
