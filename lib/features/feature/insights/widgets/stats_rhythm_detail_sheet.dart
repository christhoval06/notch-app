import 'package:flutter/material.dart';
import 'package:notch_app/core/widgets/professional_bottom_sheet.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_copy_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_detail_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_rhythm_detail_metrics.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_rhythm_recent_encounters.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_rhythm_weekday_breakdown.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsRhythmDetailSheet extends StatelessWidget {
  const StatsRhythmDetailSheet({super.key, required this.summary});

  final StatsRhythmDetailSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final day = StatsRhythmCopyService.weekdayLabel(l10n, summary.topWeekday);
    final bucket = StatsRhythmCopyService.bucketLabel(l10n, summary.topBucket);
    return ProfessionalBottomSheet(
      title: l10n.statsRhythmTitle,
      subtitle: l10n.statsRhythmDetailSubtitle,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.surfaceContainerHighest, scheme.primaryContainer.withValues(alpha: 0.35)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.statsRhythmHeadline(day, bucket.toLowerCase()), style: TextStyle(color: scheme.onSurfaceVariant, height: 1.35)),
            const SizedBox(height: 16),
            StatsRhythmDetailMetrics(summary: summary),
            const SizedBox(height: 16),
            StatsRhythmWeekdayBreakdown(weekdayCounts: summary.weekdayCounts),
            const SizedBox(height: 18),
            StatsRhythmRecentEncounters(encounters: summary.recentEncounters),
          ],
        ),
      ),
    );
  }
}
