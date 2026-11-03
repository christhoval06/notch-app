import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_relationship_progress_service.dart';

void main() {
  group('ChallengeRelationshipProgressService', () {
    test('seasonal relationship tag count tracks unique relationship tags', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), tags: const ['tag_date']),
        _encounter(DateTime(2026, 6, 10), tags: const ['tag_fwb']),
        _encounter(DateTime(2026, 6, 14), tags: const ['tag_reconciliation']),
        _encounter(DateTime(2026, 6, 18), tags: const ['tag_travel']),
      ];

      final result =
          ChallengeRelationshipProgressService.seasonalRelationshipTagCount(
            encounters,
            now: DateTime(2026, 6, 20),
          );

      expect(result, 3);
    });

    test('seasonal romance encounter count filters to romantic tags', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), tags: const ['tag_date']),
        _encounter(DateTime(2026, 6, 10), tags: const ['tag_anniversary']),
        _encounter(DateTime(2026, 6, 14), tags: const ['tag_fwb']),
      ];

      final result =
          ChallengeRelationshipProgressService.seasonalRomanceEncounterCount(
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
