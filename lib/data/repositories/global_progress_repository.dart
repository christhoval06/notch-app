import 'package:hive/hive.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/global_progress.dart';

class GlobalProgressRepository {
  const GlobalProgressRepository._();

  static Box<GlobalProgress> get _box =>
      Hive.box<GlobalProgress>(HiveBoxes.globalProgress);

  static GlobalProgress? firstOrNull() {
    if (_box.isEmpty) return null;
    return _box.getAt(0);
  }

  static Future<void> putAtZero(GlobalProgress progress) =>
      _box.put(0, progress);

  static Future<void> clear() => _box.clear();
}
