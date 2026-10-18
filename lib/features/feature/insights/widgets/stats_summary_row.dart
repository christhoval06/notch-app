import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsSummaryRow extends StatelessWidget {
  const StatsSummaryRow({super.key, required this.viewModel});

  final StatsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final encounters = _metricValue('encounters').round();
    final orgasms = _metricValue('orgasms').round();
    final rating = _metricValue('rating');
    return Row(
      children: [
        StatsSummaryCard(
          title: l10n.statsTotal,
          value: '$encounters',
          icon: Icons.flag,
          color: scheme.primary,
        ),
        const SizedBox(width: 10),
        StatsSummaryCard(
          title: l10n.orgasms,
          value: '$orgasms',
          icon: Icons.bolt,
          color: scheme.tertiary,
        ),
        const SizedBox(width: 10),
        StatsSummaryCard(
          title: l10n.statsAvgRating,
          value: rating.toStringAsFixed(1),
          icon: Icons.star,
          color: scheme.secondary,
        ),
      ],
    );
  }

  num _metricValue(String id) {
    for (final metric in viewModel.heroMetrics) {
      if (metric.id == id) return metric.currentValue;
    }
    return 0;
  }
}

class StatsSummaryCard extends StatelessWidget {
  const StatsSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
