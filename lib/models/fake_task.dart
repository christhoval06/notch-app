import 'package:hive/hive.dart';

part 'fake_task.g.dart';

@HiveType(typeId: 5)
class FakeTask extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isDone;

  FakeTask({required this.id, required this.title, this.isDone = false});
}
