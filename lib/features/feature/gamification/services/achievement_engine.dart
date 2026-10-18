import 'package:flutter/foundation.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_catalog.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine_data_service.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_models.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_progress_service.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_rebuild_service.dart';

export 'package:notch_app/features/feature/gamification/services/achievement_models.dart';

class AchievementEngine {
  static void _log(String message) {
    debugPrint('[AchievementEngine] $message');
  }

  static Future<List<Achievement>> processEvent({
    required AchievementEvent event,
    Map<String, dynamic> data = const {},
  }) {
    return AchievementProgressService.processEvent(event: event, data: data);
  }

  static List<Achievement> getAllAchievements() {
    return AchievementCatalog.all;
  }

  static Future<void> processAppStarted() async {
    final data = AchievementEngineDataService.loadAppStartedData();
    await processEvent(
      event: AchievementEvent.appStarted,
      data: data.toEventData(),
    );
  }

  static Future<void> recalculateAllDBAchievements() async {
    await recalculateAllAchievements();
  }

  static Future<void> recalculateAllAchievements() async {
    _log('Starting achievement recalculation');
    await AchievementRebuildService.rebuild(
      AchievementEngineDataService.loadRebuildData(),
    );
    await processAppStarted();
    _log('Achievement recalculation completed');
  }
}
