import 'package:notch_app/features/gamification/services/achievement_models.dart';
import 'package:notch_app/features/gamification/services/app_lifecycle_achievements.dart';
import 'package:notch_app/features/gamification/services/encounter_achievements.dart';
import 'package:notch_app/features/gamification/services/other_achievements.dart';
import 'package:notch_app/features/gamification/services/seasonal_partner_achievements.dart';

class AchievementCatalog {
  const AchievementCatalog._();

  static final List<Achievement> all = [
    ...encounterAchievements,
    ...seasonalPartnerAchievements,
    ...appLifecycleAchievements,
    ...otherAchievements,
  ];
}
