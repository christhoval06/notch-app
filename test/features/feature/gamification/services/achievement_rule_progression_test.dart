import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_rule_service.dart';

void main() {
  group('AchievementRuleService progression rules', () {
    test('monk mode unlocks after day seven with no encounters this month and prior history', () {
      expect(
        AchievementRuleService.hasMonkMode(
          allEncounters: [_encounter('1', DateTime(2026, 5, 28))],
          monthlyEncounters: const [],
          now: DateTime(2026, 6, 7),
        ),
        isTrue,
      );
    });

    test('monk mode stays locked on fresh install, before day seven, or with monthly encounters', () {
      expect(
        AchievementRuleService.hasMonkMode(
          allEncounters: const [],
          monthlyEncounters: const [],
          now: DateTime(2026, 6, 10),
        ),
        isFalse,
      );
      expect(
        AchievementRuleService.hasMonkMode(
          allEncounters: [_encounter('1', DateTime(2026, 5, 28))],
          monthlyEncounters: const [],
          now: DateTime(2026, 6, 6),
        ),
        isFalse,
      );
      expect(
        AchievementRuleService.hasMonkMode(
          allEncounters: [_encounter('1', DateTime(2026, 5, 28))],
          monthlyEncounters: [_encounter('1', DateTime(2026, 6, 1))],
          now: DateTime(2026, 6, 10),
        ),
        isFalse,
      );
    });

    test('marathoner requires five encounters in the same weekend', () {
      final encounters = [
        _encounter('1', DateTime(2026, 6, 5, 20)),
        _encounter('2', DateTime(2026, 6, 6, 9)),
        _encounter('3', DateTime(2026, 6, 6, 22)),
        _encounter('4', DateTime(2026, 6, 7, 11)),
        _encounter('5', DateTime(2026, 6, 7, 23)),
      ];
      expect(AchievementRuleService.hasWeekendMarathon(encounters), isTrue);
    });

    test('marathoner stays locked when five weekend encounters span different weekends', () {
      final encounters = [
        _encounter('1', DateTime(2026, 6, 5, 20)),
        _encounter('2', DateTime(2026, 6, 6, 9)),
        _encounter('3', DateTime(2026, 6, 12, 22)),
        _encounter('4', DateTime(2026, 6, 13, 11)),
        _encounter('5', DateTime(2026, 6, 14, 23)),
      ];
      expect(AchievementRuleService.hasWeekendMarathon(encounters), isFalse);
    });

    test('full week, unique tags, travel tag, and late-night thresholds are data-driven', () {
      final monthlyEncounters = [
        _encounter('1', DateTime(2026, 6, 1), tags: ['tag_date']),
        _encounter('2', DateTime(2026, 6, 2), tags: ['tag_travel']),
        _encounter('3', DateTime(2026, 6, 3), tags: ['tag_quickie']),
        _encounter('4', DateTime(2026, 6, 4), tags: ['tag_oral']),
        _encounter('5', DateTime(2026, 6, 5), tags: ['tag_roleplay']),
        _encounter('6', DateTime(2026, 6, 6), tags: ['tag_massage']),
        _encounter('7', DateTime(2026, 6, 7), tags: ['tag_travel']),
      ];
      final allEncounters = List.generate(
        10,
        (index) => _encounter('n$index', DateTime(2026, 6, index + 1, 2)),
      );

      expect(AchievementRuleService.hasFullWeekCoverage(monthlyEncounters), isTrue);
      expect(
        AchievementRuleService.hasUniqueTagCount(
          encounters: monthlyEncounters,
          minCount: 5,
        ),
        isTrue,
      );
      expect(
        AchievementRuleService.hasEncounterTag(
          encounter: monthlyEncounters[1],
          tag: 'tag_travel',
        ),
        isTrue,
      );
      expect(
        AchievementRuleService.hasLateNightCount(
          encounters: allEncounters,
          minCount: 10,
        ),
        isTrue,
      );
    });

    test('grand master unlocks only at gran maestro level', () {
      expect(AchievementRuleService.hasGrandMasterLevel({'name': 'Gran Maestro'}), isTrue);
      expect(AchievementRuleService.hasGrandMasterLevel({'name': 'Adepto III'}), isFalse);
    });
  });
}

Encounter _encounter(
  String id,
  DateTime date, {
  List<String> tags = const [],
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    orgasmCount: 1,
    rating: 8,
    protected: true,
    tags: tags,
  );
}
