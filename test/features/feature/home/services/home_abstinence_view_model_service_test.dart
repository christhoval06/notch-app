import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/home/services/home_abstinence_view_model_service.dart';

void main() {
  group('HomeAbstinenceViewModelService.build', () {
    test(
      'shows zero days when there is no season data and no prior history',
      () {
        final result = HomeAbstinenceViewModelService.build(
          encounters: [_encounter(DateTime(2026, 5, 1))],
          monthlyEntries: const [],
          now: DateTime(2026, 6, 27, 10, 30),
        );

        expect(result.days, 0);
        expect(result.hours, 0);
        expect(result.minutes, 0);
        expect(result.showZeroState, isTrue);
      },
    );

    test('shows elapsed time when historical progress exists', () {
      final result = HomeAbstinenceViewModelService.build(
        encounters: [_encounter(DateTime(2026, 6, 1, 8))],
        monthlyEntries: [MonthlyProgress(monthId: '2026-05', xp: 10)],
        now: DateTime(2026, 6, 27, 10, 30),
      );

      expect(result.days, 26);
      expect(result.hours, 2);
      expect(result.minutes, 30);
      expect(result.showZeroState, isFalse);
    });
  });
}

Encounter _encounter(DateTime date) {
  return Encounter(
    id: 'encounter-${date.toIso8601String()}',
    date: date,
    partnerName: 'Test',
    orgasmCount: 1,
    rating: 5,
  );
}
