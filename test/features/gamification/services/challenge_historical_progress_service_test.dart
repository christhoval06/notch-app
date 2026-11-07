import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/gamification/services/challenge_historical_progress_service.dart';

void main() {
  group('ChallengeHistoricalProgressService', () {
    test('quality streak counts the best run across full history', () {
      final encounters = [
        _encounter(DateTime(2026, 5, 2), rating: 8),
        _encounter(DateTime(2026, 5, 3), rating: 9),
        _encounter(DateTime(2026, 5, 4), rating: 6),
        _encounter(DateTime(2026, 6, 2), rating: 8),
        _encounter(DateTime(2026, 6, 3), rating: 9),
        _encounter(DateTime(2026, 6, 4), rating: 8),
        _encounter(DateTime(2026, 6, 5), rating: 10),
        _encounter(DateTime(2026, 6, 6), rating: 9),
      ];

      final result = ChallengeHistoricalProgressService.qualityStreak(
        encounters,
        minimumRating: 8,
      );

      expect(result, 5);
    });
  });
}

Encounter _encounter(DateTime date, {required int rating}) {
  return Encounter(
    id: 'encounter-${date.toIso8601String()}-$rating',
    date: date,
    partnerName: 'Test',
    orgasmCount: 1,
    rating: rating,
  );
}
