import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/monthly_progress_repository.dart';
import 'package:notch_app/data/repositories/global_progress_repository.dart';
import 'package:notch_app/data/repositories/watch_import_repository.dart';
import 'package:notch_app/features/watch_companion/services/watch_command.dart';
import 'package:notch_app/features/watch_companion/services/watch_import_service.dart';
import 'watch_test_storage.dart';

void main() {
  configureWatchTestStorage();
  final command = WatchCommand.fromMap({
    'schemaVersion': 1,
    'kind': 'entry',
    'generation': 'g',
    'id': 'ab6aaf9e-d56d-4ee7-a63c-0443e09c8793',
    'capturedAtMs': DateTime(2026, 11, 30).millisecondsSinceEpoch,
    'partnerLabel': 'Sample',
    'rating': 8,
    'orgasmCount': 1,
    'protected': true,
  });
  for (final stage in ['entry', 'month', 'global', 'receipt']) {
    test(
      'recovers after a process exit following $stage persistence',
      () async {
        await WatchImportRepository.put(command.id, {
          'fingerprint': jsonEncode(command.toMap()),
          'stage': 'received',
        });
        await EncounterRepository.put(
          Encounter(
            id: 'watch-${command.id}',
            date: command.capturedAt,
            partnerName: 'Sample',
            rating: 8,
            orgasmCount: 1,
            protected: true,
          ),
        );
        if (stage != 'entry') {
          await MonthlyProgressRepository.persistForMonth(
            MonthlyProgress(
              monthId: '2026-11',
              xp: 330,
              claimedChallengeRewardIds: ['centurion'],
            ),
          );
        }
        if (stage == 'global' || stage == 'receipt') {
          await GlobalProgressRepository.putAtZero(
            GlobalProgress(claimedHistoricalChallengeRewardIds: ['centurion']),
          );
        }
        if (stage == 'receipt') {
          await WatchImportRepository.put(command.id, {
            'fingerprint': jsonEncode(command.toMap()),
            'stage': 'completed',
            'receipt': {
              'schemaVersion': 1,
              'kind': 'receipt',
              'generation': 'g',
              'id': command.id,
              'status': 'accepted',
            },
          });
        }
        await Hive.close();
        await reopenWatchTestStorage();
        final importer = WatchImportService(
          generation: () => 'g',
          canImport: () => true,
          now: () => DateTime(2026, 12, 1),
        );
        expect((await importer.import(command))?.status, 'accepted');
        expect((await importer.import(command))?.status, 'accepted');
        expect(EncounterRepository.getAll(), hasLength(1));
        final season = MonthlyProgressRepository.getAll().single;
        expect(season.xp, stage == 'entry' ? 150 : 330);
        expect(
          season.claimedChallengeRewardIds.toSet().length,
          season.claimedChallengeRewardIds.length,
        );
        if (stage != 'entry') {
          expect(
            GlobalProgressRepository.firstOrNull()!
                .claimedHistoricalChallengeRewardIds,
            ['centurion'],
          );
        }
      },
    );
  }
}
