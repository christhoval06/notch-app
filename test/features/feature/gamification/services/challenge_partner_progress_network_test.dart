import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_partner_progress_service.dart';

void main() {
  group('ChallengePartnerProgressService network filters', () {
    test('seasonal high rating partners counts unique partners with 8+', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), 'Ana', rating: 8),
        _encounter(DateTime(2026, 6, 10), 'ana', rating: 10),
        _encounter(DateTime(2026, 6, 14), 'Luis', rating: 9),
        _encounter(DateTime(2026, 6, 18), 'Mia', rating: 7),
      ];

      final result =
          ChallengePartnerProgressService.seasonalHighRatingPartnerCount(
            encounters,
            now: DateTime(2026, 6, 20),
            minimumRating: 8,
          );

      expect(result, 2);
    });

    test('seasonal protected partners counts unique protected partners', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 3), 'Ana', protected: true),
        _encounter(DateTime(2026, 6, 10), 'Luis', protected: true),
        _encounter(DateTime(2026, 6, 14), 'Luis', protected: false),
        _encounter(DateTime(2026, 6, 18), 'Mia', protected: true),
        _encounter(DateTime(2026, 5, 18), 'Zoe', protected: true),
      ];

      final result =
          ChallengePartnerProgressService.seasonalProtectedPartnerCount(
            encounters,
            now: DateTime(2026, 6, 20),
          );

      expect(result, 3);
    });

    test('seasonal weekend partners count unique partners on weekends', () {
      final encounters = [
        _encounter(DateTime(2026, 6, 6), 'Ana'),
        _encounter(DateTime(2026, 6, 7), ' ana '),
        _encounter(DateTime(2026, 6, 14), 'Luis'),
        _encounter(DateTime(2026, 6, 21), 'Mia'),
        _encounter(DateTime(2026, 6, 18), 'Zoe'),
      ];

      final result =
          ChallengePartnerProgressService.seasonalWeekendPartnerCount(
            encounters,
            now: DateTime(2026, 6, 25),
          );

      expect(result, 3);
    });
  });
}

Encounter _encounter(
  DateTime date,
  String partnerName, {
  int rating = 5,
  bool protected = true,
}) {
  return Encounter(
    id: 'encounter-${date.toIso8601String()}-$partnerName-$rating-$protected',
    date: date,
    partnerName: partnerName,
    orgasmCount: 1,
    rating: rating,
    protected: protected,
  );
}
