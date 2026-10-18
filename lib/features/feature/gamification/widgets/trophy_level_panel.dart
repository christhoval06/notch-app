import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/app_colors.dart';
import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/core/utils/level_localization.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_level_panel_header.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_level_progress_block.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyLevelPanel extends StatelessWidget {
  const TrophyLevelPanel({
    super.key,
    required this.progress,
    required this.isCurrentMonth,
    required this.onShareTap,
  });

  final MonthlyProgress progress;
  final bool isCurrentMonth;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final foreground = scheme.onPrimaryContainer;
    final levelData = GamificationEngine.getCurrentLevel(progress.xp);
    final progressValue = (levelData['progress'] as num).toDouble();
    final levelName =
        (isCurrentMonth
                ? levelData['name']
                : (progress.finalRank ?? levelData['name']))
            as String;
    final title = isCurrentMonth
        ? l10n.trophyCurrentLevel
        : l10n.trophyFinalRank;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [AppColors.levelGradientBlue, AppColors.levelGradientMagenta],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.levelGradientMagenta.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [
              scheme.surfaceContainerHighest.withValues(alpha: 0.14),
              scheme.surfaceContainerHigh.withValues(alpha: 0.06),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TrophyLevelPanelHeader(
              title: title,
              isCurrentMonth: isCurrentMonth,
              onShareTap: onShareTap,
            ),
            const SizedBox(height: 18),
            Text(
              localizeLevelName(l10n, levelName),
              style: TextStyle(
                color: foreground,
                fontSize: 34,
                fontWeight: FontWeight.w800,
                height: 0.95,
                shadows: [
                  Shadow(
                    color: scheme.scrim.withValues(alpha: 0.18),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TrophyLevelProgressBlock(
              foreground: foreground,
              scheme: scheme,
              isCurrentMonth: isCurrentMonth,
              xp: progress.xp,
              progressValue: progressValue,
              nextXpText: l10n.trophyNextLevelInXp(
                levelData['next_xp'].toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
