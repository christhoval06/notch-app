import 'package:notch_app/data/models/encounter.dart';

class GamificationStreakService {
  const GamificationStreakService._();

  static Map<String, int> calculateStreaksFromEncounters(
    List<Encounter> encounters, {
    required DateTime now,
    bool includeCurrent = true,
  }) {
    if (encounters.isEmpty) return {'current': 0, 'longest': 0};

    final uniqueDays =
        encounters
            .map((e) => DateTime(e.date.year, e.date.month, e.date.day))
            .toSet()
            .toList()
          ..sort();
    if (uniqueDays.isEmpty) return {'current': 0, 'longest': 0};

    var currentStreak = 1;
    var longestStreak = 1;
    for (int i = 1; i < uniqueDays.length; i++) {
      if (uniqueDays[i].difference(uniqueDays[i - 1]).inDays == 1) {
        currentStreak++;
      } else {
        if (currentStreak > longestStreak) longestStreak = currentStreak;
        currentStreak = 1;
      }
    }
    if (currentStreak > longestStreak) longestStreak = currentStreak;

    if (!includeCurrent) return {'current': 0, 'longest': longestStreak};

    final today = DateTime(now.year, now.month, now.day);
    if (today.difference(uniqueDays.last).inDays > 1) currentStreak = 0;
    return {'current': currentStreak, 'longest': longestStreak};
  }
}
