import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/gamification/widgets/trophy_badge_panel.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyBadgeHistoryCard extends StatelessWidget {
  const TrophyBadgeHistoryCard({
    super.key,
    required this.l10n,
    required this.isUnlocked,
    required this.isSeasonal,
    required this.seasonLabels,
    required this.visibleSeasons,
    required this.showAllSeasons,
    required this.onToggle,
  });

  final AppLocalizations l10n;
  final bool isUnlocked;
  final bool isSeasonal;
  final List<String> seasonLabels;
  final List<String> visibleSeasons;
  final bool showAllSeasons;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final hasSeasonHistory = seasonLabels.isNotEmpty;
    final title = isSeasonal
        ? l10n.trophyBadgeUnlockedInSeasons(seasonLabels.length.toString())
        : l10n.trophyBadgeOneTimeTitle;
    final summary = !isSeasonal
        ? (isUnlocked
              ? l10n.trophyBadgeOneTimeUnlocked
              : l10n.trophyBadgeNotUnlockedHistory)
        : hasSeasonHistory
        ? seasonLabels.length == 1
              ? seasonLabels.first
              : '${seasonLabels.first} +${seasonLabels.length - 1}'
        : l10n.trophyBadgeNotUnlockedHistory;
    final showSeasonChips = isSeasonal && hasSeasonHistory;

    return TrophyBadgePanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                hasSeasonHistory || !isSeasonal
                    ? Icons.history_rounded
                    : Icons.lock_outline_rounded,
                size: 18,
                color: scheme.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            summary,
            style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
          ),
          if (showSeasonChips) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: visibleSeasons.map((season) {
                return Chip(
                  label: Text(season),
                  backgroundColor: scheme.surface.withValues(alpha: 0.94),
                  side: BorderSide(color: scheme.outlineVariant),
                  labelStyle: TextStyle(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }).toList(),
            ),
          ],
          if (isSeasonal && seasonLabels.length > 6)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: TextButton(
                onPressed: onToggle,
                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                child: Text(
                  showAllSeasons ? l10n.trophyShowLess : l10n.trophyShowMore,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
