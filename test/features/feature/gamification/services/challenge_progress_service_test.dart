import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_progress_service.dart';

void main() {
  group('ChallengeProgressService', () {
    test('does not merge weekends across different months', () {
      final encounters = [
        _encounter(DateTime(2026, 5, 29), rating: 9),
        _encounter(DateTime(2026, 6, 6), rating: 9),
        _encounter(DateTime(2026, 6, 7), rating: 9),
      ];

      final result = ChallengeProgressService.perfectWeekendProgress(
        encounters,
      );

      expect(result, 2);
    });

    test('uses the best protection streak in full history', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 20), protected: false),
        _encounter(DateTime(2026, 6, 19), protected: false),
        _encounter(DateTime(2026, 6, 18), protected: true),
        _encounter(DateTime(2026, 6, 17), protected: true),
        _encounter(DateTime(2026, 6, 16), protected: true),
        _encounter(DateTime(2026, 6, 15), protected: true),
      ];

      final result = ChallengeProgressService.longestProtectedStreak(
        encounters,
      );

      expect(result, 4);
    });

    test('requires at least 50 encounters for legendary guardian', () {
      final encounters = List.generate(
        49,
        (index) => _encounter(
          DateTime(2026, 6, 1).add(Duration(days: index)),
          protected: true,
        ),
      );

      final result = ChallengeProgressService.protectionRatePercent(
        encounters,
        minimumEncounters: 50,
      );

      expect(result, 0);
    });

    test(
      'quality week does not complete with a single high rating encounter',
      () {
        final encounters = [
          _encounter(
            DateTime.now().subtract(const Duration(hours: 2)),
            rating: 9,
          ),
        ];

        final result = ChallengeProgressService.qualityWeekProgress(
          encounters,
          days: 7,
          minimumRating: 8,
          goalCount: 8,
        );

        expect(result, 1);
      },
    );

    test('quality week resets when weekly average falls below target', () {
      final encounters = [
        _encounter(DateTime.now().subtract(const Duration(days: 1)), rating: 9),
        _encounter(DateTime.now().subtract(const Duration(days: 2)), rating: 8),
        _encounter(DateTime.now().subtract(const Duration(days: 3)), rating: 6),
      ];

      final result = ChallengeProgressService.qualityWeekProgress(
        encounters,
        days: 7,
        minimumRating: 8,
        goalCount: 8,
      );

      expect(result, 0);
    });

    test('picks the most advanced incomplete featured challenge', () {
      final encounters = [_encounter(DateTime(2026, 6, 1))];
      final challenges = [
        Challenge(
          id: 'first',
          title: 'First',
          description: 'First',
          icon: Icons.looks_one,
          goal: 10,
          family: ChallengeFamily.seasonal,
          difficulty: ChallengeDifficulty.medium,
          progressCalculator: (_) => 2,
        ),
        Challenge(
          id: 'second',
          title: 'Second',
          description: 'Second',
          icon: Icons.looks_two,
          goal: 10,
          family: ChallengeFamily.seasonal,
          difficulty: ChallengeDifficulty.medium,
          progressCalculator: (_) => 8,
        ),
      ];

      final result = ChallengeProgressService.pickFeaturedChallenge(
        challenges,
        encounters,
      );

      expect(result?.id, 'second');
    });
  });
}

Encounter _encounter(DateTime date, {int rating = 5, bool protected = true}) {
  return Encounter(
    id: 'encounter-${date.toIso8601String()}-$rating-$protected',
    date: date,
    partnerName: 'Test',
    orgasmCount: 1,
    rating: rating,
    protected: protected,
  );
}
