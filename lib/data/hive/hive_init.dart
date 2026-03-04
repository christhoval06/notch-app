import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/fake_task.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/models/partner.dart';

class HiveInit {
  const HiveInit._();

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(GlobalProgressAdapter());
    Hive.registerAdapter(EncounterAdapter());
    Hive.registerAdapter(PartnerAdapter());
    Hive.registerAdapter(AvatarTypeAdapter());
    Hive.registerAdapter(MonthlyProgressAdapter());
    Hive.registerAdapter(HealthLogAdapter());
    Hive.registerAdapter(FakeTaskAdapter());

    await Hive.openBox<Encounter>(HiveBoxes.encounters);
    await Hive.openBox<Partner>(HiveBoxes.partners);
    await Hive.openBox<MonthlyProgress>(HiveBoxes.monthlyProgress);
    await Hive.openBox<HealthLog>(HiveBoxes.healthLogs);
    await Hive.openBox<FakeTask>(HiveBoxes.fakeTasks);
    await Hive.openBox<GlobalProgress>(HiveBoxes.globalProgress);
  }
}
