import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/widgets/stats_section_title.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsQualityBreakdown extends StatelessWidget {
  const StatsQualityBreakdown({super.key, required this.encounters});

  final List<Encounter> encounters;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final total = encounters.length;
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsSectionTitle(l10n.statsQualityBreakdown),
        const SizedBox(height: 15),
        _QualityRow(label: l10n.statsLegendary, count: _count(9, 10), color: scheme.secondary, total: total),
        _QualityRow(label: l10n.statsGood, count: _count(7, 8), color: scheme.tertiary, total: total),
        _QualityRow(label: l10n.statsAverage, count: _count(5, 6), color: scheme.primary, total: total),
        _QualityRow(label: l10n.statsBad, count: _count(1, 4), color: scheme.error, total: total),
      ],
    );
  }

  int _count(int min, int max) {
    return encounters.where((item) => item.rating >= min && item.rating <= max).length;
  }
}

class _QualityRow extends StatelessWidget {
  const _QualityRow({
    required this.label,
    required this.count,
    required this.color,
    required this.total,
  });

  final String label;
  final int count;
  final Color color;
  final int total;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final percentage = total == 0 ? 0.0 : count / total;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: scheme.onSurfaceVariant)),
              Text(
                '$count (${(percentage * 100).toStringAsFixed(0)}%)',
                style: TextStyle(color: scheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: scheme.surface,
              color: color,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
