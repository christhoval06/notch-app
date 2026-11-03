import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_copy_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_detail_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsRhythmDetailMetrics extends StatelessWidget {
  const StatsRhythmDetailMetrics({super.key, required this.summary});

  final StatsRhythmDetailSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _Metric(label: l10n.statsStrongestWindowLabel, value: StatsRhythmCopyService.bucketLabel(l10n, summary.topBucket)),
        _Metric(label: l10n.statsStrongestDayLabel, value: StatsRhythmCopyService.weekdayLabel(l10n, summary.topWeekday)),
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
