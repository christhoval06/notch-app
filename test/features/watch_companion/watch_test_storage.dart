import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/models/global_progress.dart';

void configureWatchTestStorage() {
  late Directory folder;
  setUp(() async {
    folder = await Directory.systemTemp.createTemp('watch-progress-');
    Hive.init(folder.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(EncounterAdapter());
    }
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(MonthlyProgressAdapter());
    }
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(GlobalProgressAdapter());
    }
    await reopenWatchTestStorage();
  });
  tearDown(() async {
    await Hive.close();
    await folder.delete(recursive: true);
  });
}

Future<void> reopenWatchTestStorage() async {
  await Hive.openBox<Encounter>(HiveBoxes.encounters);
  await Hive.openBox<MonthlyProgress>(HiveBoxes.monthlyProgress);
  await Hive.openBox<GlobalProgress>(HiveBoxes.globalProgress);
  await Hive.openBox(HiveBoxes.watchImports);
}
