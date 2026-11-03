import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsHeroPanel extends StatelessWidget {
  const StatsHeroPanel({super.key, required this.metrics});

  final List<StatsHeroMetric> metrics;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primaryContainer,
            scheme.surface,
            scheme.secondaryContainer.withValues(alpha: 0.45),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.insightsTitle,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: metrics.map((metric) {
              return Expanded(
                child: _MetricTile(
                  label: _label(l10n, metric.id),
                  value: _value(metric),
                  delta: metric.deltaLabel,
                  trend: metric.trend,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _label(AppLocalizations l10n, String id) {
    switch (id) {
      case 'encounters':
        return l10n.statsTotal;
      case 'orgasms':
        return l10n.orgasms;
      default:
        return l10n.statsAvgRating;
    }
  }


  String _value(StatsHeroMetric metric) {
    return metric.currentValue is double
        ? (metric.currentValue as double).toStringAsFixed(1)
        : '${metric.currentValue}';
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.label,
    required this.value,
    required this.delta,
    required this.trend,
  });

  final String label;
  final String value;
  final String delta;
  final StatsTrend trend;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = switch (trend) {
      StatsTrend.up => scheme.tertiary,
      StatsTrend.down => scheme.error,
      StatsTrend.neutral => scheme.onSurfaceVariant,
    };
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: TextStyle(
            color: scheme.onSurface,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            delta,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
