import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/gamification/services/achievement_lifecycle_rule_service.dart';

void main() {
  group('AchievementLifecycleRuleService', () {
    test('delegates monk mode and abstinence milestones', () {
      final allEncounters = [_encounter('1', DateTime(2026, 5, 28))];

      expect(
        AchievementLifecycleRuleService.hasMonkMode(
          allEncounters: allEncounters,
          monthlyEncounters: const [],
          now: DateTime(2026, 6, 7),
        ),
        isTrue,
      );
      expect(
        AchievementLifecycleRuleService.hasHistoricalAbstinenceMilestone(
          allEncounters: allEncounters,
          now: DateTime(2026, 7, 20),
          milestoneDays: 45,
        ),
        isTrue,
      );
    });

    test('detects first health log and backup creation', () {
      expect(
        AchievementLifecycleRuleService.hasFirstHealthLog(
          [HealthLog(date: DateTime(2026, 6, 1), testType: 'Panel', result: 'Negative')],
        ),
        isTrue,
      );
      expect(AchievementLifecycleRuleService.hasCreatedBackup(), isTrue);
    });
  });
}

Encounter _encounter(String id, DateTime date) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    orgasmCount: 1,
    rating: 8,
    protected: true,
  );
}
