import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/encounters/services/lite_mode_service.dart';

void main() {
  group('LiteModeService.canAddEncounter', () {
    test('allows saving when current month has fewer than five records', () {
      final encounters = [
        _encounter('1', DateTime(2026, 6, 1)),
        _encounter('2', DateTime(2026, 6, 5)),
        _encounter('3', DateTime(2026, 6, 12)),
        _encounter('4', DateTime(2026, 6, 19)),
      ];

      final canAdd = LiteModeService.canAddEncounter(
        encounters: encounters,
        date: DateTime(2026, 6, 20),
      );

      expect(canAdd, isTrue);
    });

    test('blocks saving when current month already has five records', () {
      final encounters = [
        _encounter('1', DateTime(2026, 6, 1)),
        _encounter('2', DateTime(2026, 6, 5)),
        _encounter('3', DateTime(2026, 6, 12)),
        _encounter('4', DateTime(2026, 6, 19)),
        _encounter('5', DateTime(2026, 6, 20)),
      ];

      final canAdd = LiteModeService.canAddEncounter(
        encounters: encounters,
        date: DateTime(2026, 6, 21),
      );

      expect(canAdd, isFalse);
    });

    test('ignores records from other months', () {
      final encounters = [
        _encounter('1', DateTime(2026, 5, 30)),
        _encounter('2', DateTime(2026, 6, 5)),
        _encounter('3', DateTime(2026, 6, 12)),
        _encounter('4', DateTime(2026, 7, 1)),
      ];

      final canAdd = LiteModeService.canAddEncounter(
        encounters: encounters,
        date: DateTime(2026, 6, 21),
      );

      expect(canAdd, isTrue);
    });
  });
}

Encounter _encounter(String id, DateTime date) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    rating: 8,
    orgasmCount: 1,
  );
}
