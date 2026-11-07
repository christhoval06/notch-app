import 'package:flutter/material.dart';
import 'package:notch_app/data/models/global_progress.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/gamification/widgets/gamification_premium_panel.dart';
import 'package:notch_app/features/gamification/widgets/trophy_badges_grid.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyBadgesPanel extends StatelessWidget {
  const TrophyBadgesPanel({
    super.key,
    required this.progress,
    required this.globalProgress,
    required this.monthlyEntries,
    required this.unlockedCount,
    required this.allCount,
    required this.onBadgeTap,
  });

  final MonthlyProgress progress;
  final GlobalProgress globalProgress;
  final Iterable<MonthlyProgress> monthlyEntries;
  final int unlockedCount;
  final int allCount;
  final void Function(String, String, String, String, bool, bool, List<String>)
  onBadgeTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return GamificationPremiumPanel(
      padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.trophyUnlockedBadges,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$unlockedCount / $allCount',
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
          ),
          const SizedBox(height: 16),
          TrophyBadgesGrid(
            progress: progress,
            globalProgress: globalProgress,
            monthlyEntries: monthlyEntries,
            onBadgeTap: onBadgeTap,
          ),
        ],
      ),
    );
  }
}
