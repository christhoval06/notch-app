import 'package:hive/hive.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/monthly_progress.dart';

class MonthlyProgressRepository {
  const MonthlyProgressRepository._();

  static Box<MonthlyProgress> get _box =>
      Hive.box<MonthlyProgress>(HiveBoxes.monthlyProgress);

  static List<MonthlyProgress> getAll() => _box.values.toList();

  static Future<void> put(MonthlyProgress progress) =>
      _box.put(progress.monthId, progress);

  static Future<void> delete(String monthId) => _box.delete(monthId);

  static Future<void> clear() => _box.clear();
}
