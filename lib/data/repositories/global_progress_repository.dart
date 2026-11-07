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

  static Future<GlobalProgress> getOrCreate() async {
    final existing = firstOrNull();
    if (existing != null) return existing;
    final progress = GlobalProgress();
    await putAtZero(progress);
    return _box.getAt(0)!;
  }

  static Future<void> putAtZero(GlobalProgress progress) async {
    await _box.put(0, progress);
    await _box.flush();
  }

  static Future<void> clear() => _box.clear();
}
