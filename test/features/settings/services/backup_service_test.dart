import 'dart:convert';
import 'dart:io';

import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/models/partner.dart';
import 'package:notch_app/features/settings/services/backup_service.dart';

import 'fake_backup_file_selector.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory folder;
  late FileSelectorPlatform previous;
  late FakeBackupFileSelector selector;

  setUpAll(() {
    Hive.registerAdapter(EncounterAdapter());
    Hive.registerAdapter(PartnerAdapter());
    Hive.registerAdapter(AvatarTypeAdapter());
    Hive.registerAdapter(HealthLogAdapter());
    Hive.registerAdapter(MonthlyProgressAdapter());
    Hive.registerAdapter(GlobalProgressAdapter());
  });

  setUp(() async {
    previous = FileSelectorPlatform.instance;
    selector = FakeBackupFileSelector();
    FileSelectorPlatform.instance = selector;
    folder = await Directory.systemTemp.createTemp('notch-backup-test-');
    Hive.init(folder.path);
    await Hive.openBox<Encounter>(HiveBoxes.encounters);
    await Hive.openBox<Partner>(HiveBoxes.partners);
    await Hive.openBox<HealthLog>(HiveBoxes.healthLogs);
    await Hive.openBox<MonthlyProgress>(HiveBoxes.monthlyProgress);
    await Hive.openBox<GlobalProgress>(HiveBoxes.globalProgress);
    await Hive.box<Partner>(
      HiveBoxes.partners,
    ).add(Partner(id: 'existing', name: 'Existing', avatarContent: ''));
  });

  tearDown(() async {
    FileSelectorPlatform.instance = previous;
    await Hive.close();
    await folder.delete(recursive: true);
  });

  test(
    'document picker restores the existing encrypted .notch format',
    () async {
      final payload = {
        'version': 1,
        'encounters': [
          {
            'id': 'restored-entry',
            'date': '2026-11-01T12:00:00.000',
            'partnerName': 'Sample',
            'orgasmCount': 1,
            'rating': 8,
            'tags': ['tag_date'],
            'protected': true,
            'moodEmoji': '🥰',
          },
        ],
        'partners': [
          {'id': 'restored-partner', 'name': 'Sample'},
        ],
        'health': [
          {'date': '2026-11-01', 'testType': 'Sample', 'result': 'Negative'},
        ],
      };
      final encrypted = BackupService.encrypter.encrypt(
        jsonEncode(payload),
        iv: BackupService.iv,
      );
      final file = File('${folder.path}/backup.notch');
      await file.writeAsString(
        '${BackupService.iv.base64}:${encrypted.base64}',
      );
      selector.selected = XFile(file.path);

      expect(await BackupService().restoreBackup(), isTrue);
      expect(selector.calls, 1);
      final entry = Hive.box<Encounter>(HiveBoxes.encounters).values.single;
      expect(entry.id, 'restored-entry');
      expect(entry.tags, ['tag_date']);
      expect(entry.moodEmoji, '🥰');
      expect(
        Hive.box<Partner>(HiveBoxes.partners).values.single.name,
        'Sample',
      );
      expect(
        Hive.box<HealthLog>(HiveBoxes.healthLogs).values.single.result,
        'Negative',
      );
    },
  );

  test('canceling the document picker preserves existing data', () async {
    expect(await BackupService().restoreBackup(), isFalse);
    expect(selector.calls, 1);
    expect(Hive.box<Partner>(HiveBoxes.partners).values.single.id, 'existing');
  });

  test('invalid selected backup preserves existing data', () async {
    final file = File('${folder.path}/invalid.notch');
    await file.writeAsString('invalid backup');
    selector.selected = XFile(file.path);

    expect(await BackupService().restoreBackup(), isFalse);
    expect(selector.calls, 1);
    expect(Hive.box<Partner>(HiveBoxes.partners).values.single.id, 'existing');
  });
}
