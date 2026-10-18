import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyMilestoneProgress extends StatelessWidget {
  const TrophyMilestoneProgress({
    super.key,
    required this.currentStreak,
    required this.milestoneData,
  });

  final int currentStreak;
  final Map<String, int> milestoneData;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final milestone = milestoneData['milestone'] ?? 0;
    final remaining = milestoneData['remaining'] ?? 0;
    final progress = milestone > 0 ? currentStreak / milestone : 1.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.trophyNextMilestoneDays(milestone.toString()),
              style: TextStyle(
                fontFamily: 'Lato',
                color: scheme.onSurface,
                fontSize: 12,
              ),
            ),
            Text(
              remaining > 0
                  ? l10n.trophyDaysRemaining(remaining.toString())
                  : l10n.trophyMilestoneReached,
              style: TextStyle(
                fontFamily: 'Lato',
                color: scheme.tertiary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            backgroundColor: scheme.surfaceContainerHighest,
            color: scheme.tertiary,
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
