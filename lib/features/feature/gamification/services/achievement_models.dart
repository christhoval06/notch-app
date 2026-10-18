enum AchievementEvent {
  appStarted,
  encounterSaved,
  healthLogSaved,
  backupCreated,
}

enum AchievementType { once, seasonal }

class Achievement {
  final String id;
  final String name;
  final String description;
  final String icon;
  final AchievementEvent event;
  final bool Function(Map<String, dynamic> data) condition;
  final AchievementType type;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.event,
    required this.condition,
    this.type = AchievementType.seasonal,
  });
}
