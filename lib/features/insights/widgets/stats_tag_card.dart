import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsTagCard extends StatelessWidget {
  const StatsTagCard({
    super.key,
    required this.tag,
    required this.rank,
    required this.onTap,
  });

  final StatsTagInsight tag;
  final int rank;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              rank == 1 ? scheme.secondaryContainer : scheme.surfaceContainerHighest,
              scheme.surface,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '#$rank',
                  style: TextStyle(
                    color: scheme.secondary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tagLabelFromL10n(l10n, tag.tagKey),
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _TagMetric(
                    label: l10n.statsEncountersLabel,
                    value: '${tag.count}',
                  ),
                ),
                Expanded(
                  child: _TagMetric(
                    label: l10n.statsAvgRating,
                    value: tag.avgRating.toStringAsFixed(1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              '${l10n.statsMostFrequentPartnerLabel}: ${tag.topPartnerName}',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: 4),
            Text(
              '${l10n.statsDominantMoodLabel}: ${tag.dominantMood ?? l10n.statsNoMoodLabel}',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagMetric extends StatelessWidget {
  const _TagMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
