import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/abstinence_service.dart';

void main() {
  group('AbstinenceService.longestAbstinenceDaysInRange', () {
    test('returns the longest abstinence streak within a selected month', () {
      final encounters = [
        _encounter('before', DateTime(2026, 5, 28)),
        _encounter('first', DateTime(2026, 6, 10)),
        _encounter('second', DateTime(2026, 6, 20)),
        _encounter('after', DateTime(2026, 7, 5)),
      ];

      final result = AbstinenceService.longestAbstinenceDaysInRange(
        encounters,
        start: DateTime(2026, 6, 1),
        end: DateTime(2026, 7, 1),
        now: DateTime(2026, 7, 10),
      );

      expect(result, 11);
    });

    test('returns zero when there are no encounters in the selected month', () {
      final result = AbstinenceService.longestAbstinenceDaysInRange(
        const [],
        start: DateTime(2026, 6, 1),
        end: DateTime(2026, 7, 1),
        now: DateTime(2026, 6, 12),
      );

      expect(result, 0);
    });

    test('does not count days before the first encounter in the month', () {
      final encounters = [_encounter('first', DateTime(2026, 6, 27, 13))];

      final result = AbstinenceService.longestAbstinenceDaysInRange(
        encounters,
        start: DateTime(2026, 6, 1),
        end: DateTime(2026, 7, 1),
        now: DateTime(2026, 6, 27, 22),
      );

      expect(result, 0);
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
