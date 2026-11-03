import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_abstinence_rules.dart';

void main() {
  group('AchievementAbstinenceRules', () {
    test('monthly milestones stay locked on fresh install', () {
      expect(
        AchievementAbstinenceRules.hasMonthlyMilestone(
          allEncounters: const [],
          monthlyEncounters: const [],
          now: DateTime(2026, 6, 27),
          milestoneDays: 7,
        ),
        isFalse,
      );
    });

    test('monthly milestones unlock from current month abstinence window', () {
      final allEncounters = [_encounter('prior', DateTime(2026, 5, 20))];

      expect(
        AchievementAbstinenceRules.hasMonthlyMilestone(
          allEncounters: allEncounters,
          monthlyEncounters: const [],
          now: DateTime(2026, 6, 15),
          milestoneDays: 14,
        ),
        isTrue,
      );
    });

    test('historical milestones use the best global abstinence record', () {
      final allEncounters = [
        _encounter('a', DateTime(2026, 1, 1)),
        _encounter('b', DateTime(2026, 2, 20)),
      ];

      expect(
        AchievementAbstinenceRules.hasHistoricalMilestone(
          allEncounters: allEncounters,
          now: DateTime(2026, 6, 27),
          milestoneDays: 45,
        ),
        isTrue,
      );
    });
  });
}

Encounter _encounter(String id, DateTime date) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Test',
    orgasmCount: 1,
    rating: 5,
  );
}
