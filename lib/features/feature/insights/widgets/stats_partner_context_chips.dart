import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/translations.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_copy_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsPartnerContextChips extends StatelessWidget {
  const StatsPartnerContextChips({
    super.key,
    required this.summary,
  });

  final StatsPartnerDetailSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _Chip(label: '${l10n.statsDominantMoodLabel}: ${summary.dominantMood ?? l10n.statsNoMoodLabel}'),
        _Chip(
          label:
              '${l10n.statsStrongestWindowLabel}: ${StatsRhythmCopyService.bucketLabel(l10n, summary.topBucket)}',
        ),
        ...summary.topTags.map(
          (tag) => _Chip(
            label: tagLabelFromL10n(l10n, tag),
            tone: scheme.primaryContainer,
            textColor: scheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    this.tone,
    this.textColor,
  });

  final String label;
  final Color? tone;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tone ?? scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor ?? scheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
