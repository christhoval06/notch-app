import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/core/utils/gamification_level_service.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/monthly_progress_repository.dart';
import 'package:notch_app/features/encounters/services/encounter_save_service.dart';
import 'watch_test_storage.dart';

void main() {
  configureWatchTestStorage();
  Encounter entry(String id, {int rating = 8, bool protected = true}) =>
      Encounter(
        id: id,
        date: DateTime(2026, 11, 4),
        partnerName: 'Sample',
        rating: rating,
        orgasmCount: 1,
        protected: protected,
      );
  test('saving an entry removes the affected season monk badge', () async {
    await MonthlyProgressRepository.put(
      MonthlyProgress(monthId: '2026-11', unlockedBadges: ['monk_mode']),
    );
    await EncounterSaveService.save(entry('new'));
    expect(
      MonthlyProgressRepository.getAll().single.unlockedBadges,
      isNot(contains('monk_mode')),
    );
  });
  test(
    'level achievements use base XP plus claimed challenge rewards',
    () async {
      for (var i = 0; i < 199; i++) {
        await EncounterRepository.put(entry('$i'));
      }
      await MonthlyProgressRepository.put(
        MonthlyProgress(
          monthId: '2026-11',
          xp: 29850,
          claimedChallengeRewardIds: ['centurion'],
        ),
      );
      await EncounterSaveService.save(
        entry('new', rating: 5, protected: false),
      );
      final season = MonthlyProgressRepository.getAll().single;
      expect(
        GamificationLevelService.getCurrentLevel(season.xp)['name'],
        'Gran Maestro',
      );
      expect(season.unlockedBadges, contains('grand_master'));
    },
  );
}
