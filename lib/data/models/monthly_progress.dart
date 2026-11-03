import 'package:hive/hive.dart';

part 'monthly_progress.g.dart';

@HiveType(typeId: 4)
class MonthlyProgress extends HiveObject {
  // ID Único del mes, ej: "2024-08"
  @HiveField(0)
  final String monthId;

  @HiveField(1)
  int xp;

  @HiveField(2)
  List<String> unlockedBadges;

  // Para guardar el rango final cuando el mes termina
  @HiveField(3)
  String? finalRank;

  @HiveField(4, defaultValue: 0)
  int? longestStreakOfMonth;

  @HiveField(5)
  List<String> claimedChallengeRewardIds;

  MonthlyProgress({
    required this.monthId,
    this.xp = 0,
    this.unlockedBadges = const [],
    this.finalRank,
    this.longestStreakOfMonth,
    this.claimedChallengeRewardIds = const [],
  });
}
