import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_recalculation_service.dart';
import 'package:notch_app/data/models/encounter.dart';

void main() {
  group('AchievementRecalculationService.buildEncounterStepData', () {
    test(
      'builds historical monthly xp and level up to the current encounter',
      () {
        final encounters = [
          _encounter('1', DateTime(2026, 6, 1), rating: 8, protected: true),
          _encounter('2', DateTime(2026, 6, 3), rating: 10, protected: true),
          _encounter('3', DateTime(2026, 7, 1), rating: 7, protected: false),
        ];

        final data = AchievementRecalculationService.buildEncounterStepData(
          sortedEncounters: encounters,
          currentIndex: 1,
        );

        final level = data['level'] as Map<String, dynamic>;
        final monthlyXp = data['monthlyXp'] as int;
        final monthly = data['monthlyEncounters'] as List<Encounter>;

        expect(monthly.length, 2);
        expect(monthlyXp, 320);
        expect(level['name'], 'Iniciado III');
      },
    );

    test(
      'calculates streaks from historical subset instead of full present data',
      () {
        final encounters = [
          _encounter('1', DateTime(2026, 6, 1)),
          _encounter('2', DateTime(2026, 6, 2)),
          _encounter('3', DateTime(2026, 6, 3)),
          _encounter('4', DateTime(2026, 6, 20)),
        ];

        final data = AchievementRecalculationService.buildEncounterStepData(
          sortedEncounters: encounters,
          currentIndex: 2,
        );

        final streaks = data['streaks'] as Map<String, int>;

        expect(streaks['current'], 3);
        expect(streaks['longest'], 3);
      },
    );
  });
}

Encounter _encounter(
  String id,
  DateTime date, {
  bool protected = true,
  int rating = 8,
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    orgasmCount: 1,
    rating: rating,
    protected: protected,
  );
}
