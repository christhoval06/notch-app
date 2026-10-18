import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_seasonal_progress_service.dart';

void main() {
  group('ChallengeSeasonalProgressService', () {
    test(
      'seasonal quality streak counts consecutive high ratings in season',
      () {
        final encounters = [
          _encounter(DateTime(2026, 6, 2), rating: 8),
          _encounter(DateTime(2026, 6, 3), rating: 9),
          _encounter(DateTime(2026, 6, 4), rating: 8),
          _encounter(DateTime(2026, 6, 5), rating: 6),
        ];

        final result = ChallengeSeasonalProgressService.seasonalQualityStreak(
          encounters,
          now: DateTime(2026, 6, 20),
          minimumRating: 8,
        );

        expect(result, 3);
      },
    );

    test('balanced week counts distinct days in the last 7 days', () {
      final now = DateTime(2026, 6, 20, 12);
      final encounters = [
        _encounter(DateTime(2026, 6, 19, 8)),
        _encounter(DateTime(2026, 6, 19, 22)),
        _encounter(DateTime(2026, 6, 17, 9)),
        _encounter(DateTime(2026, 6, 15, 10)),
      ];

      final result = ChallengeSeasonalProgressService.balancedWeekProgress(
        encounters,
        now: now,
      );

      expect(result, 3);
    });

    test(
      'seasonal distinct tags counts unique tags across multiple partners',
      () {
        final encounters = [
          _encounter(DateTime(2026, 6, 2), tags: const ['tag_morning']),
          _encounter(
            DateTime(2026, 6, 3),
            tags: const ['tag_travel', 'tag_oral'],
          ),
          _encounter(
            DateTime(2026, 6, 4),
            tags: const ['tag_night', 'tag_pool'],
          ),
        ];

        final result =
            ChallengeSeasonalProgressService.seasonalDistinctTagCount(
              encounters,
              now: DateTime(2026, 6, 20),
            );

        expect(result, 5);
      },
    );

    test('seasonal quality streak can support a goal of five', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 2), rating: 8),
        _encounter(DateTime(2026, 6, 3), rating: 9),
        _encounter(DateTime(2026, 6, 4), rating: 8),
        _encounter(DateTime(2026, 6, 5), rating: 10),
        _encounter(DateTime(2026, 6, 6), rating: 9),
      ];

      final result = ChallengeSeasonalProgressService.seasonalQualityStreak(
        encounters,
        now: DateTime(2026, 6, 20),
        minimumRating: 8,
      );

      expect(result, 5);
    });

    test('consecutive weekend run counts back to back weekend activity', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 6), rating: 8),
        _encounter(DateTime(2026, 6, 14), rating: 7),
        _encounter(DateTime(2026, 6, 21), rating: 9),
      ];

      final result = ChallengeSeasonalProgressService.consecutiveWeekendRun(
        encounters,
        now: DateTime(2026, 6, 25),
      );

      expect(result, 3);
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
