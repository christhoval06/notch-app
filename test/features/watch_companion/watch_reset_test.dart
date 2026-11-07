import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/core/constants/app_secure_keys.dart';
import 'package:notch_app/core/session/app_access_session.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/partner.dart';
import 'package:notch_app/features/auth/services/auth_kill_switch_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'kill switch clears import history and leaves repository listenables open',
    () async {
      final folder = await Directory.systemTemp.createTemp('watch-reset-');
      Hive.init(folder.path);
      Hive.registerAdapter(EncounterAdapter());
      Hive.registerAdapter(MonthlyProgressAdapter());
      Hive.registerAdapter(GlobalProgressAdapter());
      Hive.registerAdapter(HealthLogAdapter());
      Hive.registerAdapter(AvatarTypeAdapter());
      Hive.registerAdapter(PartnerAdapter());
      await Hive.openBox<Encounter>(HiveBoxes.encounters);
      await Hive.openBox<MonthlyProgress>(HiveBoxes.monthlyProgress);
      await Hive.openBox<GlobalProgress>(HiveBoxes.globalProgress);
      await Hive.openBox<HealthLog>(HiveBoxes.healthLogs);
      await Hive.openBox<Partner>(HiveBoxes.partners);
      await Hive.openBox(HiveBoxes.watchImports);
      await Hive.box(
        HiveBoxes.watchImports,
      ).put('entry', {'stage': 'completed'});
      await Hive.box<Encounter>(HiveBoxes.encounters).put(
        '1',
        Encounter(
          id: '1',
          date: DateTime.now(),
          partnerName: 'Sample',
          rating: 8,
          orgasmCount: 1,
        ),
      );
      FlutterSecureStorage.setMockInitialValues({
        AppSecureKeys.realPin: '1234',
      });
      AppAccessSession.instance.unlockReal();
      await AuthKillSwitchService.execute(const FlutterSecureStorage());
      expect(Hive.box<Encounter>(HiveBoxes.encounters).isEmpty, isTrue);
      expect(Hive.box(HiveBoxes.watchImports).isEmpty, isTrue);
      expect(Hive.box<GlobalProgress>(HiveBoxes.globalProgress).isOpen, isTrue);
      expect(AppAccessSession.instance.canImport, isFalse);
      expect(
        await const FlutterSecureStorage().read(key: AppSecureKeys.realPin),
        isNull,
      );
      await Hive.close();
      await folder.delete(recursive: true);
    },
  );
}
