import 'package:notch_app/core/utils/gamification_xp_service.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/monthly_progress_repository.dart';
import 'package:notch_app/data/repositories/global_progress_repository.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_catalog.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_evaluator_service.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_models.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_recalculation_service.dart';
import 'package:notch_app/features/feature/gamification/services/encounter_reward_reconciliation_service.dart';

abstract final class EncounterProgressReconciliationService {
  static Future<List<Achievement>> reconcile({
    required DateTime eventDate,
    DateTime? now,
  }) async {
    final monthId =
        '${eventDate.year}-${eventDate.month.toString().padLeft(2, '0')}';
    final all = EncounterRepository.getAll()
      ..sort((a, b) => a.date.compareTo(b.date));
    final seasons = MonthlyProgressRepository.getAll();
    final old = seasons.where((p) => p.monthId == monthId).firstOrNull;
    final month = all
        .where(
          (e) =>
              e.date.year == eventDate.year && e.date.month == eventDate.month,
        )
        .toList();
    final progress = MonthlyProgress(
      monthId: monthId,
      xp: month.fold(
        0,
        (sum, e) => sum + GamificationXpService.xpForEncounter(e),
      ),
      unlockedBadges: [...?old?.unlockedBadges],
      claimedChallengeRewardIds: [...?old?.claimedChallengeRewardIds],
      finalRank: old?.finalRank,
      longestStreakOfMonth: old?.longestStreakOfMonth,
    );
    final oldGlobal = GlobalProgressRepository.firstOrNull();
    final global = GlobalProgress(
      unlockedOnceAchievements: [...?oldGlobal?.unlockedOnceAchievements],
      claimedHistoricalChallengeRewardIds: [
        ...?oldGlobal?.claimedHistoricalChallengeRewardIds,
      ],
    );
    EncounterRewardReconciliationService.reconcile(
      progress: progress,
      global: global,
      all: all,
      seasons: seasons,
      now: now ?? DateTime.now(),
    );
    final unlocked = <Achievement>[];
    for (var i = 0; i < all.length; i++) {
      if (!month.contains(all[i])) continue;
      unlocked.addAll(
        AchievementEvaluatorService.evaluate(
          achievements: AchievementCatalog.all.where(
            (a) => a.event == AchievementEvent.encounterSaved,
          ),
          monthlyProgress: progress,
          globalProgress: global,
          data: AchievementRecalculationService.buildEncounterStepData(
            sortedEncounters: all,
            currentIndex: i,
          ),
        ),
      );
    }
    await MonthlyProgressRepository.persistForMonth(progress);
    await GlobalProgressRepository.putAtZero(global);
    return unlocked;
  }
}
