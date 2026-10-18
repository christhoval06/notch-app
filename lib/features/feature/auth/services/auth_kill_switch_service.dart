import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/core/constants/app_secure_keys.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/models/partner.dart';

class AuthKillSwitchService {
  const AuthKillSwitchService._();

  static Future<void> execute(FlutterSecureStorage storage) async {
    try {
      await Hive.close();
      for (final boxName in [
        HiveBoxes.encounters,
        HiveBoxes.partners,
        HiveBoxes.monthlyProgress,
        HiveBoxes.healthLogs,
      ]) {
        try {
          await Hive.deleteBoxFromDisk(boxName);
        } catch (error) {
          debugPrint('AuthKillSwitchService failed to delete $boxName: $error');
        }
      }
      await Hive.openBox<Encounter>(HiveBoxes.encounters);
      await Hive.openBox<Partner>(HiveBoxes.partners);
      await Hive.openBox<MonthlyProgress>(HiveBoxes.monthlyProgress);
      await Hive.openBox<HealthLog>(HiveBoxes.healthLogs);
      await storage.delete(key: AppSecureKeys.realPin);
      await storage.delete(key: AppSecureKeys.fakePin);
      await storage.delete(key: AppSecureKeys.killPin);
    } catch (error) {
      debugPrint('AuthKillSwitchService.execute failed: $error');
    }
  }
}
