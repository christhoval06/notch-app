import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/partner.dart';

class PartnerRepository {
  const PartnerRepository._();

  static Box<Partner> get _box => Hive.box<Partner>(HiveBoxes.partners);

  static ValueListenable<Box<Partner>> listenable() => _box.listenable();

  static List<Partner> getAll() => _box.values.toList();

  static Future<void> put(Partner partner) => _box.put(partner.id, partner);

  static Future<void> delete(String id) => _box.delete(id);

  static Future<void> clear() => _box.clear();
}
