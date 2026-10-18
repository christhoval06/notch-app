import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_partner_rule_service.dart';

void main() {
  group('AchievementPartnerRuleService', () {
    test(
      'seasonal single partner unlocks with enough encounters and one partner',
      () {
        final monthlyEncounters = List.generate(
          8,
          (index) => _encounter('e$index', DateTime(2026, 6, index + 1), 'Ana'),
        );

        final result = AchievementPartnerRuleService.hasSeasonalSinglePartner(
          monthlyEncounters: monthlyEncounters,
          minimumEncounters: 8,
        );

        expect(result, isTrue);
      },
    );

    test('seasonal single partner stays locked if another partner appears', () {
      final monthlyEncounters = [
        ...List.generate(
          7,
          (index) => _encounter('e$index', DateTime(2026, 6, index + 1), 'Ana'),
        ),
        _encounter('e8', DateTime(2026, 6, 8), 'Luis'),
      ];

      final result = AchievementPartnerRuleService.hasSeasonalSinglePartner(
        monthlyEncounters: monthlyEncounters,
        minimumEncounters: 8,
      );

      expect(result, isFalse);
    });

    test('seasonal multiple partners unlocks with three distinct partners', () {
      final monthlyEncounters = [
        _encounter('e1', DateTime(2026, 6, 1), 'Ana'),
        _encounter('e2', DateTime(2026, 6, 2), 'Luis'),
        _encounter('e3', DateTime(2026, 6, 3), 'Mia'),
      ];

      final result = AchievementPartnerRuleService.hasSeasonalMultiplePartners(
        monthlyEncounters: monthlyEncounters,
        minimumPartners: 3,
      );

      expect(result, isTrue);
    });
  });
}

Encounter _encounter(String id, DateTime date, String partnerName) {
  return Encounter(
    id: id,
    date: date,
    partnerName: partnerName,
    orgasmCount: 1,
    rating: 8,
    protected: true,
  );
}
