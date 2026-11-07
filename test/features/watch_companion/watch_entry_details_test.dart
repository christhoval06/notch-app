import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/watch_import_repository.dart';
import 'package:notch_app/features/watch_companion/services/watch_command.dart';
import 'package:notch_app/features/watch_companion/services/watch_import_service.dart';
import 'watch_test_storage.dart';

void main() {
  configureWatchTestStorage();
  final now = DateTime(2026, 11, 7, 12);
  Map<String, Object?> payload() => {
    'schemaVersion': 1,
    'kind': 'entry',
    'generation': 'g',
    'id': 'ab6aaf9e-d56d-4ee7-a63c-0443e09c8793',
    'capturedAtMs': now.millisecondsSinceEpoch,
    'partnerLabel': 'Sample',
    'rating': 9,
    'orgasmCount': 1,
    'protected': true,
  };
  test('mood and tags survive command serialization', () {
    final map = payload()
      ..['moodEmoji'] = '🥰'
      ..['tags'] = ['tag_hotel', 'tag_date'];
    final result = WatchCommand.fromMap(map).toMap();
    expect(result['moodEmoji'], '🥰');
    expect(result['tags'], ['tag_date', 'tag_hotel']);
  });
  test('old pending commands retain their original fingerprint shape', () {
    expect(WatchCommand.fromMap(payload()).toMap(), payload());
  });
  test('rejects invalid moods and tag payloads', () {
    for (final value in [
      {'moodEmoji': 'unknown'},
      {'moodEmoji': 1},
      {'tags': 'tag_date'},
      {
        'tags': ['unknown'],
      },
      {
        'tags': ['tag_date', 'tag_date'],
      },
      {
        'tags': [1],
      },
    ]) {
      expect(
        () => WatchCommand.fromMap({...payload(), ...value}),
        throwsFormatException,
      );
    }
  });
  test(
    'import recovery preserves details and rejects changed UUID content',
    () async {
      final map = payload()
        ..['moodEmoji'] = '🥰'
        ..['tags'] = ['tag_date'];
      final service = WatchImportService(
        generation: () => 'g',
        canImport: () => true,
        now: () => now,
      );
      expect(
        (await service.import(WatchCommand.fromMap(map)))?.status,
        'accepted',
      );
      await WatchImportRepository.clear();
      expect(
        (await service.import(WatchCommand.fromMap(map)))?.status,
        'accepted',
      );
      final entry = EncounterRepository.getAll().single;
      expect(entry.moodEmoji, '🥰');
      expect(entry.tags, ['tag_date']);
      await WatchImportRepository.clear();
      final changed = WatchCommand.fromMap({...map, 'moodEmoji': '🔥'});
      expect((await service.import(changed))?.reason, 'conflicting_id');
      expect(EncounterRepository.getAll(), hasLength(1));
    },
  );
}
