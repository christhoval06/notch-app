import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/watch_import_repository.dart';
import 'package:notch_app/features/watch_companion/services/watch_command.dart';
import 'package:notch_app/features/watch_companion/services/watch_import_service.dart';

void main() {
  late Directory directory;
  final now = DateTime(2026, 12, 1);
  WatchCommand command({int rating = 8}) => WatchCommand.fromMap({
    'schemaVersion': 1,
    'kind': 'entry',
    'generation': 'g',
    'id': 'ab6aaf9e-d56d-4ee7-a63c-0443e09c8793',
    'capturedAtMs': DateTime(2026, 11, 30, 23).millisecondsSinceEpoch,
    'partnerLabel': 'Sample',
    'rating': rating,
    'orgasmCount': 1,
    'protected': true,
  });
  setUp(() async {
    directory = await Directory.systemTemp.createTemp('watch-import-');
    Hive.init(directory.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(EncounterAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(MonthlyProgressAdapter());
    }
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(GlobalProgressAdapter());
    }
    await Hive.openBox<Encounter>(HiveBoxes.encounters);
    await Hive.openBox<MonthlyProgress>(HiveBoxes.monthlyProgress);
    await Hive.openBox<GlobalProgress>(HiveBoxes.globalProgress);
    await Hive.openBox(HiveBoxes.watchImports);
  });
  tearDown(() async {
    await Hive.close();
    await directory.delete(recursive: true);
  });
  test(
    'duplicate and interrupted imports have one entry and one XP result',
    () async {
      final service = WatchImportService(
        generation: () => 'g',
        canImport: () => true,
        now: () => now,
      );
      final first = await service.import(command());
      expect(first?.status, 'accepted');
      final second = await service.import(command());
      expect(second?.status, 'accepted');
      expect(EncounterRepository.getAll(), hasLength(1));
      final month = Hive.box<MonthlyProgress>(
        HiveBoxes.monthlyProgress,
      ).values.single;
      expect(month.monthId, '2026-11');
      expect(month.xp, 150);
      final conflict = await service.import(command(rating: 9));
      expect(conflict?.reason, 'conflicting_id');
      await WatchImportRepository.clear();
      await service.import(command());
      expect(
        Hive.box<MonthlyProgress>(HiveBoxes.monthlyProgress).values.single.xp,
        150,
      );
      expect(EncounterRepository.getAll(), hasLength(1));
    },
  );
  test(
    'locked sessions wait and old generations cannot restore data',
    () async {
      final locked = WatchImportService(
        generation: () => 'g',
        canImport: () => false,
        now: () => now,
      );
      expect(await locked.import(command()), isNull);
      final reset = WatchImportService(
        generation: () => 'new',
        canImport: () => true,
        now: () => now,
      );
      expect((await reset.import(command()))?.reason, 'reset');
      expect(EncounterRepository.getAll(), isEmpty);
    },
  );
}
