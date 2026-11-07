import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/gamification/services/challenge_mood_progress_service.dart';

void main() {
  group('ChallengeMoodProgressService', () {
    test('seasonal mood diversity counts distinct non-empty moods', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), moodEmoji: '🔥'),
        _encounter(DateTime(2026, 6, 10), moodEmoji: '😎'),
        _encounter(DateTime(2026, 6, 14), moodEmoji: '🔥'),
        _encounter(DateTime(2026, 6, 18), moodEmoji: '🤯'),
      ];

      final result = ChallengeMoodProgressService.seasonalMoodDiversity(
        encounters,
        now: DateTime(2026, 6, 20),
      );

      expect(result, 3);
    });

    test(
      'seasonal high intensity mood count requires mood and high rating',
      () {
        final encounters = [
          _encounter(DateTime(2026, 6, 3), rating: 8, moodEmoji: '🔥'),
          _encounter(DateTime(2026, 6, 10), rating: 9, moodEmoji: '😎'),
          _encounter(DateTime(2026, 6, 14), rating: 7, moodEmoji: '🤯'),
          _encounter(DateTime(2026, 6, 18), rating: 10, moodEmoji: null),
        ];

        final result =
            ChallengeMoodProgressService.seasonalHighIntensityMoodCount(
              encounters,
              now: DateTime(2026, 6, 20),
              minimumRating: 8,
            );

        expect(result, 2);
      },
    );
  });
}

Encounter _encounter(DateTime date, {int rating = 5, String? moodEmoji}) {
  return Encounter(
    id: 'encounter-${date.toIso8601String()}-$rating-${moodEmoji ?? "none"}',
    date: date,
    partnerName: 'Test',
    orgasmCount: 1,
    rating: rating,
    moodEmoji: moodEmoji,
  );
}
