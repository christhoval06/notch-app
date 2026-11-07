import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/gamification/services/challenge_service.dart';

abstract final class EncounterRewardReconciliationService {
  static void reconcile({
    required MonthlyProgress progress,
    required GlobalProgress global,
    required List<Encounter> all,
    required List<MonthlyProgress> seasons,
    required DateTime now,
  }) {
    final catalog = ChallengeService.getChallengesWithProgress();
    final historicIds = catalog
        .where((c) => c.family == ChallengeFamily.historical)
        .map((c) => c.id)
        .toSet();
    final globalClaims = {
      ...global.claimedHistoricalChallengeRewardIds,
      for (final season in seasons)
        ...season.claimedChallengeRewardIds.where(historicIds.contains),
    };
    final claims = progress.claimedChallengeRewardIds.toSet();
    final currentId = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    for (final challenge in catalog) {
      if (claims.contains(challenge.id)) continue;
      if (challenge.family == ChallengeFamily.historical) {
        if (globalClaims.contains(challenge.id)) continue;
      } else if (progress.monthId != currentId) {
        continue;
      }
      if (challenge.getProgressPercent(all) < 1) continue;
      claims.add(challenge.id);
      if (challenge.family == ChallengeFamily.historical) {
        globalClaims.add(challenge.id);
      }
    }
    progress.claimedChallengeRewardIds = claims.toList();
    global.claimedHistoricalChallengeRewardIds = globalClaims.toList();
    progress.xp += catalog
        .where((c) => claims.contains(c.id))
        .fold(0, (sum, c) => sum + c.xpReward);
  }
}
