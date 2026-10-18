import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/gamification/widgets/share_preview_rank_hero.dart';
import 'package:notch_app/features/feature/gamification/widgets/share_preview_stat_row.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SharePreviewCard extends StatelessWidget {
  const SharePreviewCard({
    super.key,
    required this.rankName,
    required this.currentXp,
    required this.progressToNextLevel,
    required this.totalEncountersThisMonth,
  });

  final String rankName;
  final int currentXp;
  final double progressToNextLevel;
  final int totalEncountersThisMonth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          colors: [
            scheme.scrim,
            scheme.inverseSurface,
            scheme.surfaceContainerHigh,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.scrim.withValues(alpha: 0.45),
            blurRadius: 36,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(1.2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(31),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: 0.4),
          ),
          gradient: LinearGradient(
            colors: [
              scheme.surfaceContainerHighest.withValues(alpha: 0.92),
              scheme.surfaceContainerHigh.withValues(alpha: 0.82),
              scheme.surfaceContainerLow.withValues(alpha: 0.88),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
          child: Column(
            children: [
              Text(
                l10n.shareCurrentSeason,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: scheme.onSurface.withValues(alpha: 0.62),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.4,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SharePreviewRankHero(
                  rankName: rankName,
                  progressToNextLevel: progressToNextLevel,
                  progressLabel: l10n.shareSeasonXp,
                ),
              ),
              const SizedBox(height: 12),
              SharePreviewStatRow(
                icon: Icons.flash_on_rounded,
                label: l10n.shareSeasonXp,
                value: currentXp.toString(),
                compact: true,
              ),
              const SizedBox(height: 8),
              SharePreviewStatRow(
                icon: Icons.flag_rounded,
                label: l10n.shareMonthEncounters,
                value: totalEncountersThisMonth.toString(),
                compact: true,
              ),
              const SizedBox(height: 10),
              Text(
                'NOTCH',
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: scheme.onSurface.withValues(alpha: 0.56),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
