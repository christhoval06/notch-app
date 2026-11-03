import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_event_progress_service.dart';

void main() {
  group('ChallengeEventProgressService', () {
    test('seasonal event tag count tracks unique event tags', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), tags: const ['tag_date']),
        _encounter(DateTime(2026, 6, 10), tags: const ['tag_travel']),
        _encounter(DateTime(2026, 6, 14), tags: const ['tag_celebration']),
        _encounter(DateTime(2026, 6, 18), tags: const ['tag_oral']),
      ];

      final result = ChallengeEventProgressService.seasonalEventTagCount(
        encounters,
        now: DateTime(2026, 6, 20),
      );

      expect(result, 3);
    });

    test('seasonal getaway encounter count filters to getaway tags', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), tags: const ['tag_travel']),
        _encounter(DateTime(2026, 6, 10), tags: const ['tag_hotel']),
        _encounter(DateTime(2026, 6, 14), tags: const ['tag_date']),
        _encounter(DateTime(2026, 5, 14), tags: const ['tag_car']),
      ];

      final result =
          ChallengeEventProgressService.seasonalGetawayEncounterCount(
            encounters,
            now: DateTime(2026, 6, 20),
          );

      expect(result, 2);
    });
  });
}

Encounter _encounter(DateTime date, {List<String> tags = const []}) {
  return Encounter(
    id: 'encounter-${date.toIso8601String()}-${tags.join(",")}',
    date: date,
    partnerName: 'Test',
    orgasmCount: 1,
    rating: 5,
    tags: tags,
  );
}
