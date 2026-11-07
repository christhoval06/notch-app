import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/stats_summary_card.dart';
import 'package:notch_app/features/app_clip/services/app_clip_sample_data.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AppClipInsights extends StatelessWidget {
  const AppClipInsights({super.key, required this.sample});

  final AppClipSampleData sample;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.appClipInsights, style: theme.textTheme.titleLarge),
        const SizedBox(height: 16),
        Row(
          children: [
            StatsSummaryCard(
              title: l10n.statsTotal,
              value: '${sample.encounters.length}',
              icon: Icons.flag,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 10),
            StatsSummaryCard(
              title: l10n.orgasms,
              value: '${sample.orgasmCount}',
              icon: Icons.bolt,
              color: theme.colorScheme.tertiary,
            ),
            const SizedBox(width: 10),
            StatsSummaryCard(
              title: l10n.statsAvgRating,
              value: sample.averageRating.toStringAsFixed(1),
              icon: Icons.star,
              color: theme.colorScheme.secondary,
            ),
          ],
        ),
      ],
    );
  }
}
