import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/gamification/services/challenge_skill_progress_service.dart';

void main() {
  group('ChallengeSkillProgressService', () {
    test('seasonal skill tag count tracks unique practice tags', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), tags: const ['tag_oral']),
        _encounter(DateTime(2026, 6, 10), tags: const ['tag_toys']),
        _encounter(DateTime(2026, 6, 14), tags: const ['tag_kinky']),
        _encounter(DateTime(2026, 6, 18), tags: const ['tag_date']),
      ];

      final result = ChallengeSkillProgressService.seasonalSkillTagCount(
        encounters,
        now: DateTime(2026, 6, 20),
      );

      expect(result, 3);
    });

    test('seasonal high rating skill count needs practice tag and 8+', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), rating: 8, tags: const ['tag_oral']),
        _encounter(DateTime(2026, 6, 10), rating: 9, tags: const ['tag_toys']),
        _encounter(DateTime(2026, 6, 14), rating: 7, tags: const ['tag_kinky']),
        _encounter(DateTime(2026, 6, 18), rating: 10, tags: const ['tag_date']),
      ];

      final result = ChallengeSkillProgressService.seasonalHighRatingSkillCount(
        encounters,
        now: DateTime(2026, 6, 20),
        minimumRating: 8,
      );

      expect(result, 2);
    });
  });
}

Encounter _encounter(
  DateTime date, {
  int rating = 5,
  List<String> tags = const [],
}) {
  return Encounter(
    id: 'encounter-${date.toIso8601String()}-$rating-${tags.join(",")}',
    date: date,
    partnerName: 'Test',
    orgasmCount: 1,
    rating: rating,
    tags: tags,
  );
}
