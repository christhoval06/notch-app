import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_partner_progress_service.dart';

void main() {
  group('ChallengePartnerProgressService', () {
    test('seasonal single partner counts progress for one partner only', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), 'Ana'),
        _encounter(DateTime(2026, 6, 10), 'ana'),
        _encounter(DateTime(2026, 6, 14), ' Ana '),
      ];

      final result =
          ChallengePartnerProgressService.seasonalSinglePartnerProgress(
            encounters,
            now: DateTime(2026, 6, 20),
          );

      expect(result, 3);
    });

    test('seasonal single partner resets when a second partner appears', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), 'Ana'),
        _encounter(DateTime(2026, 6, 10), 'Luis'),
      ];

      final result =
          ChallengePartnerProgressService.seasonalSinglePartnerProgress(
            encounters,
            now: DateTime(2026, 6, 20),
          );

      expect(result, 0);
    });

    test('historical single partner uses the top partner count', () {
      final encounters = [
        _encounter(DateTime(2026, 5, 3), 'Ana'),
        _encounter(DateTime(2026, 5, 10), 'Ana'),
        _encounter(DateTime(2026, 6, 10), 'Luis'),
      ];

      final result =
          ChallengePartnerProgressService.historicalSinglePartnerProgress(
            encounters,
          );

      expect(result, 2);
    });

    test('historical protected partner ignores unprotected entries', () {
      final encounters = [
        _encounter(DateTime(2026, 5, 3), 'Ana', protected: true),
        _encounter(DateTime(2026, 5, 10), 'Ana', protected: true),
        _encounter(DateTime(2026, 6, 10), 'Ana', protected: false),
        _encounter(DateTime(2026, 6, 12), 'Luis', protected: true),
      ];

      final result =
          ChallengePartnerProgressService.historicalProtectedPartnerProgress(
            encounters,
          );

      expect(result, 2);
    });

    test(
      'seasonal distinct partners counts unique names in current season',
      () {
        final encounters = [
          _encounter(DateTime(2026, 6, 3), 'Ana'),
          _encounter(DateTime(2026, 6, 10), ' ana '),
          _encounter(DateTime(2026, 6, 14), 'Luis'),
          _encounter(DateTime(2026, 5, 14), 'Mia'),
        ];

        final result =
            ChallengePartnerProgressService.seasonalDistinctPartnerCount(
              encounters,
              now: DateTime(2026, 6, 20),
            );

        expect(result, 2);
      },
    );

    test('historical distinct partners counts unique names across history', () {
      final encounters = [
        _encounter(DateTime(2026, 5, 3), 'Ana'),
        _encounter(DateTime(2026, 5, 10), ' ana '),
        _encounter(DateTime(2026, 6, 10), 'Luis'),
        _encounter(DateTime(2026, 6, 12), 'Mia'),
      ];

      final result =
          ChallengePartnerProgressService.historicalDistinctPartnerCount(
            encounters,
          );

      expect(result, 3);
    });
  });
}

Encounter _encounter(
  DateTime date,
  String partnerName, {
  bool protected = true,
}) {
  return Encounter(
    id: 'encounter-${date.toIso8601String()}-$partnerName',
    date: date,
    partnerName: partnerName,
    orgasmCount: 1,
    rating: 5,
    protected: protected,
  );
}
