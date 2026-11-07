import 'package:hive/hive.dart';
import 'package:notch_app/data/hive/boxes.dart';

abstract final class WatchImportRepository {
  static Box get _box => Hive.box(HiveBoxes.watchImports);
  static Map<String, Object?>? get(String id) {
    final value = _box.get(id);
    return value is Map ? Map<String, Object?>.from(value) : null;
  }

  static Future<void> put(String id, Map<String, Object?> value) async {
    await _box.put(id, value);
    await _box.flush();
  }

  static Future<void> clear() async {
    await _box.clear();
    await _box.flush();
  }
}
