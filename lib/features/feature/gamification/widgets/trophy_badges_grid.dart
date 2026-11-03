import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/achievement_localization.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_engine.dart';
import 'package:notch_app/features/feature/gamification/services/achievement_unlock_service.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_badge_tile.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyBadgesGrid extends StatelessWidget {
  const TrophyBadgesGrid({
    super.key,
    required this.progress,
    required this.globalProgress,
    required this.monthlyEntries,
    required this.onBadgeTap,
  });

  final MonthlyProgress progress;
  final GlobalProgress globalProgress;
  final Iterable<MonthlyProgress> monthlyEntries;
  final void Function(String, String, String, String, bool, bool, List<String>)
  onBadgeTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentMonthId = DateTime.now().toIso8601String().substring(0, 7);
    final allAchievements = AchievementEngine.getAllAchievements();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.68,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: allAchievements.length,
      itemBuilder: (context, index) {
        final achievement = allAchievements[index];
        final unlocked = AchievementUnlockService.isUnlocked(
          achievement: achievement,
          monthlyProgress: progress,
          globalProgress: globalProgress,
        );
        final localizedName = localizeAchievementName(
          l10n,
          achievement.id,
          achievement.name,
        );
        final localizedDescription = localizeAchievementDescription(
          l10n,
          achievement.id,
          achievement.description,
        );
        final unlockedSeasonMonthIds =
            monthlyEntries
                .where((entry) => entry.unlockedBadges.contains(achievement.id))
                .map((entry) => entry.monthId)
                .toList()
              ..sort((a, b) {
                if (a == currentMonthId && b != currentMonthId) return -1;
                if (b == currentMonthId && a != currentMonthId) return 1;
                return b.compareTo(a);
              });

        return Tooltip(
          message: localizedDescription,
          child: TrophyBadgeTile(
            id: achievement.id,
            icon: achievement.icon,
            name: localizedName,
            isUnlocked: unlocked,
            isSeasonal: achievement.type == AchievementType.seasonal,
            onTap: () {
              onBadgeTap(
                achievement.id,
                localizedName,
                localizedDescription,
                achievement.icon,
                unlocked,
                achievement.type == AchievementType.seasonal,
                unlockedSeasonMonthIds,
              );
            },
          ),
        );
      },
    );
  }
}
