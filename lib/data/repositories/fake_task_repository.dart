import 'package:hive/hive.dart';
import 'package:notch_app/data/hive/boxes.dart';
import 'package:notch_app/data/models/fake_task.dart';

class FakeTaskRepository {
  const FakeTaskRepository._();

  static Box<FakeTask> get _box => Hive.box<FakeTask>(HiveBoxes.fakeTasks);

  static List<FakeTask> getAll() => _box.values.toList();

  static Future<void> add(FakeTask task) => _box.add(task);

  static Future<void> clear() => _box.clear();
}
