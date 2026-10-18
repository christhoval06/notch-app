import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_abstinence_rules.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_rule_service.dart';

class AchievementLifecycleRuleService {
  const AchievementLifecycleRuleService._();

  static bool hasMonthlyAbstinenceMilestone({
    required List<Encounter> allEncounters,
    required List<Encounter> monthlyEncounters,
    required DateTime now,
    required int milestoneDays,
  }) {
    return AchievementAbstinenceRules.hasMonthlyMilestone(
      allEncounters: allEncounters,
      monthlyEncounters: monthlyEncounters,
      now: now,
      milestoneDays: milestoneDays,
    );
  }

  static bool hasHistoricalAbstinenceMilestone({
    required List<Encounter> allEncounters,
    required DateTime now,
    required int milestoneDays,
  }) {
    return AchievementAbstinenceRules.hasHistoricalMilestone(
      allEncounters: allEncounters,
      now: now,
      milestoneDays: milestoneDays,
    );
  }

  static bool hasMonkMode({
    required List<Encounter> allEncounters,
    required List<Encounter> monthlyEncounters,
    required DateTime now,
  }) {
    return AchievementRuleService.hasMonkMode(
      allEncounters: allEncounters,
      monthlyEncounters: monthlyEncounters,
      now: now,
    );
  }

  static bool hasFirstHealthLog(List<HealthLog> healthLogs) {
    return healthLogs.length == 1;
  }

  static bool hasCreatedBackup() {
    return true;
  }
}
