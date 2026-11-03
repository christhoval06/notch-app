import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_catalog.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_evaluator_service.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_models.dart';

class AchievementProgressService {
  const AchievementProgressService._();

  static List<Achievement> getAllAchievements() => AchievementCatalog.all;

  static Future<List<Achievement>> processEvent({
    required AchievementEvent event,
    Map<String, dynamic> data = const {},
  }) async {
    final monthlyProgress = await GamificationEngine.getCurrentMonthlyProgress();
    final globalProgressBox = Hive.box<GlobalProgress>('global_progress');
    final globalProgress = globalProgressBox.isNotEmpty
        ? globalProgressBox.getAt(0)!
        : GlobalProgress();
    final relevantAchievements = AchievementCatalog.all.where(
      (achievement) => achievement.event == event,
    );
    final unlockedAchievements = AchievementEvaluatorService.evaluate(
      achievements: relevantAchievements,
      monthlyProgress: monthlyProgress,
      globalProgress: globalProgress,
      data: data,
    );

    if (unlockedAchievements.isNotEmpty) {
      await monthlyProgress.save();
      if (globalProgressBox.isNotEmpty) {
        await globalProgress.save();
      } else {
        await globalProgressBox.add(globalProgress);
      }
    }

    return unlockedAchievements;
  }
}
