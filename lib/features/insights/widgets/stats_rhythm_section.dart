import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/insights/services/stats_rhythm_copy_service.dart';
import 'package:notch_app/features/insights/services/stats_rhythm_detail_service.dart';
import 'package:notch_app/features/insights/widgets/stats_rhythm_bucket_bar.dart';
import 'package:notch_app/features/insights/widgets/stats_rhythm_detail_sheet.dart';
import 'package:notch_app/features/insights/widgets/stats_section_title.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsRhythmSection extends StatelessWidget {
  const StatsRhythmSection({
    super.key,
    required this.summary,
    required this.encounters,
  });

  final StatsRhythmSummary summary;
  final List<Encounter> encounters;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final bucket = StatsRhythmCopyService.bucketLabel(l10n, summary.topBucket);
    final day = StatsRhythmCopyService.weekdayLabel(l10n, summary.topWeekday);
    final max = summary.bucketCounts.values.fold<int>(0, (a, b) => a > b ? a : b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatsSectionTitle(l10n.statsRhythmTitle),
        const SizedBox(height: 16),
        InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => showModalBottomSheet<void>(
            context: context,
            backgroundColor: scheme.surface,
            builder: (_) => StatsRhythmDetailSheet(
              summary: StatsRhythmDetailService.build(encounters: encounters),
            ),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [scheme.primaryContainer, scheme.surface],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bucket,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${l10n.statsStrongestDayLabel}: $day',
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: 16),
                ...summary.bucketCounts.entries.map((entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: StatsRhythmBucketBar(
                        label: StatsRhythmCopyService.bucketLabel(l10n, entry.key),
                        count: entry.value,
                        max: max,
                      ),
                    )),
                const SizedBox(height: 8),
                Text(
                  l10n.statsRhythmHeadline(day, bucket.toLowerCase()),
                  style: TextStyle(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
