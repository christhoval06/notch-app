import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';

class SettingsMaintenanceService {
  const SettingsMaintenanceService._();

  static Future<void> recalculateAchievements() {
    return AchievementEngine.recalculateAllAchievements();
  }

  static Future<void> recalculateXp() {
    return GamificationEngine.recalculateAllXp();
  }
}
