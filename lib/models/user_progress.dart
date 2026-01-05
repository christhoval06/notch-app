import 'package:hive/hive.dart';

part 'user_progress.g.dart';

@HiveType(typeId: 2)
class UserProgress extends HiveObject {
  @HiveField(0)
  int currentXp; // Puntos de experiencia totales

  @HiveField(1)
  List<String> unlockedBadges; // IDs de los logros (ej: 'legend', 'sprinter')

  UserProgress({this.currentXp = 0, this.unlockedBadges = const []});
}
