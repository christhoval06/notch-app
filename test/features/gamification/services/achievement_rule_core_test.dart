import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/gamification/services/achievement_rule_service.dart';

void main() {
  group('AchievementRuleService core rules', () {
    test('rookie unlocks when at least one encounter exists', () {
      final encounters = [_encounter('1', DateTime(2026, 6, 1, 10))];
      expect(AchievementRuleService.hasRookieEncounter(encounters), isTrue);
    });

    test('legend and hat-trick evaluate current encounter fields', () {
      expect(AchievementRuleService.hasPerfectRating(_encounter('1', DateTime(2026, 6, 1), rating: 10)), isTrue);
      expect(
        AchievementRuleService.hasMinimumOrgasmCount(
          encounter: _encounter('2', DateTime(2026, 6, 1), orgasmCount: 3),
          minCount: 3,
        ),
        isTrue,
      );
    });

    test('sprinter detects any 3 encounters within 24 hours', () {
      final encounters = [
        _encounter('1', DateTime(2026, 6, 1, 8)),
        _encounter('2', DateTime(2026, 6, 10, 8)),
        _encounter('3', DateTime(2026, 6, 10, 18)),
        _encounter('4', DateTime(2026, 6, 11, 7)),
      ];
      expect(
        AchievementRuleService.hasEncounterWindowWithinHours(
          encounters: encounters,
          windowSize: 3,
          maxHours: 24,
        ),
        isTrue,
      );
    });

    test('safe player requires 10 protected encounters in a row', () {
      final encounters = [
        _encounter('1', DateTime(2026, 6, 1), protected: true),
        _encounter('2', DateTime(2026, 6, 2), protected: true),
        _encounter('3', DateTime(2026, 6, 3), protected: true),
        _encounter('4', DateTime(2026, 6, 4), protected: true),
        _encounter('5', DateTime(2026, 6, 5), protected: false),
        _encounter('6', DateTime(2026, 6, 6), protected: true),
        _encounter('7', DateTime(2026, 6, 7), protected: true),
        _encounter('8', DateTime(2026, 6, 8), protected: true),
        _encounter('9', DateTime(2026, 6, 9), protected: true),
        _encounter('10', DateTime(2026, 6, 10), protected: true),
        _encounter('11', DateTime(2026, 6, 11), protected: true),
        _encounter('12', DateTime(2026, 6, 12), protected: true),
        _encounter('13', DateTime(2026, 6, 13), protected: true),
        _encounter('14', DateTime(2026, 6, 14), protected: true),
        _encounter('15', DateTime(2026, 6, 15), protected: true),
      ];
      expect(
        AchievementRuleService.hasConsecutiveMatches(
          encounters: encounters,
          minCount: 10,
          predicate: (encounter) => encounter.protected,
        ),
        isTrue,
      );
    });

    test('top critic requires 5 ratings of 9 or more in a row', () {
      final encounters = [
        _encounter('1', DateTime(2026, 6, 1), rating: 9),
        _encounter('2', DateTime(2026, 6, 2), rating: 10),
        _encounter('3', DateTime(2026, 6, 3), rating: 7),
        _encounter('4', DateTime(2026, 6, 4), rating: 9),
        _encounter('5', DateTime(2026, 6, 5), rating: 9),
        _encounter('6', DateTime(2026, 6, 6), rating: 10),
        _encounter('7', DateTime(2026, 6, 7), rating: 9),
        _encounter('8', DateTime(2026, 6, 8), rating: 9),
      ];
      expect(
        AchievementRuleService.hasConsecutiveMatches(
          encounters: encounters,
          minCount: 5,
          predicate: (encounter) => encounter.rating >= 9,
        ),
        isTrue,
      );
    });

    test('fire streak unlocks when longest streak reaches seven days', () {
      expect(AchievementRuleService.hasFireStreak({'current': 2, 'longest': 7}), isTrue);
    });
  });
}

Encounter _encounter(
  String id,
  DateTime date, {
  bool protected = true,
  int rating = 8,
  int orgasmCount = 1,
  List<String> tags = const [],
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    orgasmCount: orgasmCount,
    rating: rating,
    protected: protected,
    tags: tags,
  );
}
