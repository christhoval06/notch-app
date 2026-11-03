import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/encounter.dart';

class EncounterRepository {
  const EncounterRepository._();

  static Box<Encounter> get _box => Hive.box<Encounter>(HiveBoxes.encounters);

  static List<Encounter> getAll() => _box.values.toList();

  static ValueListenable<Box<Encounter>> listenable() => _box.listenable();

  static Future<void> put(Encounter encounter) => _box.put(encounter.id, encounter);

  static Future<void> delete(String id) => _box.delete(id);

  static Future<void> clear() => _box.clear();
}
