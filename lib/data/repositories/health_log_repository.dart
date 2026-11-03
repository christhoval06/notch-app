import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/health_log.dart';

class HealthLogRepository {
  const HealthLogRepository._();

  static Box<HealthLog> get _box => Hive.box<HealthLog>(HiveBoxes.healthLogs);

  static List<HealthLog> getAll() => _box.values.toList();

  static ValueListenable<Box<HealthLog>> listenable() => _box.listenable();

  static Future<void> add(HealthLog log) => _box.add(log);

  static Future<void> clear() => _box.clear();
}
