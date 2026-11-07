import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/core/widgets/professional_bottom_sheet.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_heatmap_day_summary_service.dart';
import 'package:notch_app/features/insights/widgets/stats_heatmap_day_encounters.dart';
import 'package:notch_app/features/insights/widgets/stats_heatmap_day_tokens.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsHeatmapDaySheet extends StatelessWidget {
  const StatsHeatmapDaySheet({
    super.key,
    required this.title,
    required this.date,
    required this.count,
    required this.summary,
    required this.encounters,
  });

  final String title;
  final DateTime date;
  final int count;
  final StatsHeatmapDaySummary summary;
  final List<Encounter> encounters;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    return ProfessionalBottomSheet(
      title: title,
      subtitle: DateFormat.yMMMMd(locale).format(date),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              scheme.surfaceContainerHighest,
              scheme.primaryContainer.withValues(alpha: 0.35),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(
              '$count',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 36,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.statsHeatmapSelectionCount(count.toString()),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.statsHeatmapDayInsight(count.toString()),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                StatsHeatmapDayFactChip(
                  label: l10n.statsHeatmapTopPartnerLabel,
                  value: summary.topPartnerName,
                ),
                StatsHeatmapDayFactChip(
                  label: l10n.statsDominantMoodLabel,
                  value: summary.dominantMood ?? l10n.statsNoMoodLabel,
                ),
                StatsHeatmapDayFactChip(
                  label: l10n.statsAvgRating,
                  value: summary.averageRating.toStringAsFixed(1),
                ),
                StatsHeatmapDayFactChip(
                  label: l10n.statsProtectionTitle,
                  value: _protectionLabel(l10n),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.statsHeatmapTagsLabel,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: summary.tagKeys.isEmpty
                  ? [
                      StatsHeatmapDayTagPill(
                        label: l10n.statsHeatmapNoTags,
                        tone: scheme.surfaceContainerLow,
                        textColor: scheme.onSurfaceVariant,
                      ),
                    ]
                  : summary.tagKeys
                        .map(
                          (tag) => StatsHeatmapDayTagPill(
                            label: tagLabelFromL10n(l10n, tag),
                            tone: scheme.primaryContainer,
                            textColor: scheme.onPrimaryContainer,
                          ),
                        )
                        .toList(),
            ),
            if (encounters.length > 1) ...[
              const SizedBox(height: 16),
              StatsHeatmapDayEncounters(encounters: encounters),
            ],
          ],
        ),
      ),
    );
  }

  String _protectionLabel(AppLocalizations l10n) {
    if (summary.unprotectedCount == 0) return l10n.statsHeatmapProtectionSafe;
    if (summary.protectedCount == 0) return l10n.statsHeatmapProtectionNone;
    return l10n.statsHeatmapProtectionMixed;
  }
}
