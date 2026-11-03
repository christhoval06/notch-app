import 'package:collection/collection.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_detail_models.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_summary_service.dart';

class StatsRhythmDetailService {
  const StatsRhythmDetailService._();

  static StatsRhythmDetailSummary build({
    required List<Encounter> encounters,
  }) {
    final summary = StatsRhythmSummaryService.build(encounters);
    final weekdayCounts = encounters
        .groupListsBy((item) => item.date.weekday)
        .map((key, value) => MapEntry(key, value.length));
    final recent = [...encounters]..sort((a, b) => b.date.compareTo(a.date));

    return StatsRhythmDetailSummary(
      topBucket: summary.topBucket,
      topWeekday: summary.topWeekday,
      bucketCounts: summary.bucketCounts,
      weekdayCounts: weekdayCounts,
      recentEncounters: recent.take(3).toList(),
    );
  }
}
