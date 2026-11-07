import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/gamification/services/abstinence_service.dart';

class AchievementAbstinenceRules {
  const AchievementAbstinenceRules._();

  static bool hasMonthlyMilestone({
    required List<Encounter> allEncounters,
    required List<Encounter> monthlyEncounters,
    required DateTime now,
    required int milestoneDays,
  }) {
    final hasPriorHistory = allEncounters.any(
      (encounter) =>
          encounter.date.year != now.year || encounter.date.month != now.month,
    );
    if (!hasPriorHistory) return false;

    final days = AbstinenceService.currentMonthAbstinenceDays(
      monthlyEncounters: monthlyEncounters,
      now: now,
    );
    return days >= milestoneDays;
  }

  static bool hasHistoricalMilestone({
    required List<Encounter> allEncounters,
    required DateTime now,
    required int milestoneDays,
  }) {
    return AbstinenceService.longestAbstinenceDays(allEncounters, now: now) >=
        milestoneDays;
  }
}
