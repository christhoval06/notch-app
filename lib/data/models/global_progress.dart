import 'package:hive/hive.dart';
part 'global_progress.g.dart';

@HiveType(typeId: 7)
class GlobalProgress extends HiveObject {
  @HiveField(0)
  List<String> unlockedOnceAchievements;

  GlobalProgress({this.unlockedOnceAchievements = const []});
}
