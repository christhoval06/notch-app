import 'package:notch_app/data/models/challenge.dart';
import 'package:notch_app/data/models/encounter.dart';

class ChallengeProgressViewModel {
  const ChallengeProgressViewModel({
    required this.challenge,
    required this.progressPercent,
    required this.progressText,
    required this.isCompleted,
  });

  final Challenge challenge;
  final double progressPercent;
  final String progressText;
  final bool isCompleted;
}

class ChallengeCategorySummary {
  const ChallengeCategorySummary({
    required this.completedCount,
    required this.totalCount,
  });

  final int completedCount;
  final int totalCount;

  double get completionRate =>
      totalCount == 0 ? 0 : completedCount / totalCount;
}

class ChallengesViewModelService {
  const ChallengesViewModelService._();

  static ChallengeProgressViewModel build(
    Challenge challenge,
    List<Encounter> encounters,
  ) {
    final progress = challenge.getProgress(encounters);
    final progressPercent = challenge.getProgressPercent(encounters);
    final isCompleted = progressPercent >= 1.0;
    final progressText = challenge.id == 'legendary_guardian'
        ? '${progress.toStringAsFixed(0)}% / ${challenge.goal}%'
        : '${progress.toInt()} / ${challenge.goal}';
    return ChallengeProgressViewModel(
      challenge: challenge,
      progressPercent: progressPercent,
      progressText: progressText,
      isCompleted: isCompleted,
    );
  }

  static ChallengeCategorySummary summarize(
    List<Challenge> challenges,
    List<Encounter> encounters,
  ) {
    final completedCount = challenges
        .where((challenge) => build(challenge, encounters).isCompleted)
        .length;
    return ChallengeCategorySummary(
      completedCount: completedCount,
      totalCount: challenges.length,
    );
  }

  static List<Challenge> sortChallenges(
    List<Challenge> challenges,
    List<Encounter> encounters,
  ) {
    final sorted = [...challenges];
    sorted.sort((left, right) {
      final leftViewModel = build(left, encounters);
      final rightViewModel = build(right, encounters);
      if (leftViewModel.isCompleted != rightViewModel.isCompleted) {
        return leftViewModel.isCompleted ? 1 : -1;
      }
      final progressComparison = rightViewModel.progressPercent.compareTo(
        leftViewModel.progressPercent,
      );
      if (progressComparison != 0) return progressComparison;
      final rewardComparison = right.xpReward.compareTo(left.xpReward);
      if (rewardComparison != 0) return rewardComparison;
      return left.id.compareTo(right.id);
    });
    return sorted;
  }
}
