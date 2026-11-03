import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_current_streak_display.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_milestone_progress.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_streak_record_card.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyStreaksSection extends StatelessWidget {
  const TrophyStreaksSection({
    super.key,
    required this.currentStreak,
    required this.seasonBestStreak,
    required this.allTimeBestStreak,
    required this.showCurrentStreak,
  });

  final int currentStreak;
  final int seasonBestStreak;
  final int allTimeBestStreak;
  final bool showCurrentStreak;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final nextMilestoneData = GamificationEngine.getNextStreakMilestone(
      currentStreak,
    );
    final leftCard = TrophyStreakRecordCard(
      title: l10n.trophyMonthRecord,
      icon: Icons.military_tech,
      days: seasonBestStreak,
      color: scheme.primary,
      currentStreak: currentStreak,
      recordToBeat: allTimeBestStreak,
    );
    final rightCard = TrophyStreakRecordCard(
      title: l10n.trophyHistorical,
      icon: Icons.star,
      days: allTimeBestStreak,
      color: scheme.tertiary,
      currentStreak: currentStreak,
      recordToBeat: allTimeBestStreak,
      isAllTime: true,
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          if (showCurrentStreak) ...[
            TrophyCurrentStreakDisplay(currentStreak: currentStreak),
            const SizedBox(height: 24),
          ],
          LayoutBuilder(
            builder: (context, constraints) {
              final stacked = constraints.maxWidth < 360;

              if (stacked) {
                return Column(
                  children: [leftCard, const SizedBox(height: 16), rightCard],
                );
              }

              return Row(
                children: [
                  Expanded(child: leftCard),
                  const SizedBox(width: 16),
                  Expanded(child: rightCard),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          TrophyMilestoneProgress(
            currentStreak: currentStreak,
            milestoneData: nextMilestoneData,
          ),
        ],
      ),
    );
  }
}
