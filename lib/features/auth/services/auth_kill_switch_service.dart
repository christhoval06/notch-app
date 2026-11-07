import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notch_app/core/constants/app_secure_keys.dart';
import 'package:notch_app/core/services/encounter_write_coordinator.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/partner_repository.dart';
import 'package:notch_app/data/repositories/monthly_progress_repository.dart';
import 'package:notch_app/data/repositories/health_log_repository.dart';
import 'package:notch_app/data/repositories/global_progress_repository.dart';
import 'package:notch_app/data/repositories/watch_import_repository.dart';
import 'package:notch_app/features/watch_companion/state/watch_companion_controller.dart';

abstract final class AuthKillSwitchService {
  static Future<void> execute(FlutterSecureStorage storage) async {
    await WatchCompanionController.instance.reset();
    await EncounterWriteCoordinator.run(() async {
      await WatchImportRepository.clear();
      await EncounterRepository.clear();
      await PartnerRepository.clear();
      await MonthlyProgressRepository.clear();
      await HealthLogRepository.clear();
      await GlobalProgressRepository.clear();
      await storage.delete(key: AppSecureKeys.realPin);
      await storage.delete(key: AppSecureKeys.fakePin);
      await storage.delete(key: AppSecureKeys.killPin);
    });
  }
}
