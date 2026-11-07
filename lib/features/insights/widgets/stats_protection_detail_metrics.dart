import 'package:flutter/material.dart';
import 'package:notch_app/features/insights/services/stats_protection_detail_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsProtectionDetailMetrics extends StatelessWidget {
  const StatsProtectionDetailMetrics({super.key, required this.summary});

  final StatsProtectionDetailSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _Metric(label: l10n.statsProtectionRateLabel, value: '${(summary.protectionRate * 100).round()}%'),
        _Metric(label: l10n.statsFilterProtected, value: '${summary.protectedCount}'),
        _Metric(label: l10n.statsFilterUnprotected, value: '${summary.unprotectedCount}'),
      ],
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}
