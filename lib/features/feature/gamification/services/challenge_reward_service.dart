import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/gamification/services/challenge_service.dart';

class ChallengeRewardService {
  const ChallengeRewardService._();

  static int rewardXpForIds(List<String> ids) {
    return ChallengeService.getChallengesWithProgress()
        .where((challenge) => ids.contains(challenge.id))
        .fold<int>(0, (sum, challenge) => sum + challenge.xpReward);
  }

  static Future<void> syncRewards({
    required List<Encounter> allEncounters,
    required MonthlyProgress monthlyProgress,
    required GlobalProgress globalProgress,
  }) async {
    var monthlyChanged = false;
    var globalChanged = false;

    for (final challenge in ChallengeService.getChallengesWithProgress()) {
      if (challenge.getProgressPercent(allEncounters) < 1) continue;
      if (_alreadyClaimed(
        challenge: challenge,
        monthlyProgress: monthlyProgress,
        globalProgress: globalProgress,
      )) {
        continue;
      }

      monthlyProgress.claimedChallengeRewardIds = List<String>.from(
        monthlyProgress.claimedChallengeRewardIds,
      )..add(challenge.id);
      monthlyProgress.xp += challenge.xpReward;
      monthlyChanged = true;

      if (challenge.family == ChallengeFamily.historical) {
        globalProgress.claimedHistoricalChallengeRewardIds = List<String>.from(
          globalProgress.claimedHistoricalChallengeRewardIds,
        )..add(challenge.id);
        globalChanged = true;
      }
    }

    if (monthlyChanged) await monthlyProgress.save();
    if (globalChanged) await globalProgress.save();
  }

  static bool _alreadyClaimed({
    required Challenge challenge,
    required MonthlyProgress monthlyProgress,
    required GlobalProgress globalProgress,
  }) {
    if (challenge.family == ChallengeFamily.historical) {
      return globalProgress.claimedHistoricalChallengeRewardIds.contains(
        challenge.id,
      );
    }
    return monthlyProgress.claimedChallengeRewardIds.contains(challenge.id);
  }
}
