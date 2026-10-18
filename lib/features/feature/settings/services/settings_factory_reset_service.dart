import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/models/partner.dart';

class SettingsFactoryResetService {
  const SettingsFactoryResetService._();

  static Future<void> run(FlutterSecureStorage storage) async {
    await Hive.close();
    const boxes = [
      HiveBoxes.encounters,
      HiveBoxes.partners,
      HiveBoxes.monthlyProgress,
      HiveBoxes.healthLogs,
    ];

    for (final boxName in boxes) {
      try {
        await Hive.deleteBoxFromDisk(boxName);
      } catch (_) {}
    }

    await Hive.openBox<Encounter>(HiveBoxes.encounters);
    await Hive.openBox<Partner>(HiveBoxes.partners);
    await Hive.openBox<MonthlyProgress>(HiveBoxes.monthlyProgress);
    await Hive.openBox<HealthLog>(HiveBoxes.healthLogs);
    await storage.deleteAll();
  }
}
