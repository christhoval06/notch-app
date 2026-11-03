import 'package:collection/collection.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';

class StatsRhythmSummaryService {
  const StatsRhythmSummaryService._();

  static StatsRhythmSummary build(List<Encounter> encounters) {
    final bucketCounts = {
      'morning': encounters.where((item) => item.date.hour < 12).length,
      'afternoon': encounters
          .where((item) => item.date.hour >= 12 && item.date.hour < 18)
          .length,
      'night': encounters.where((item) => item.date.hour >= 18).length,
    };
    final topBucket = bucketCounts.entries.sorted((a, b) => b.value.compareTo(a.value)).first.key;
    final topWeekday = encounters
        .groupListsBy((item) => item.date.weekday)
        .entries
        .sorted((a, b) => b.value.length.compareTo(a.value.length))
        .first
        .key;
    return StatsRhythmSummary(
      topBucket: topBucket,
      topWeekday: topWeekday,
      bucketCounts: bucketCounts,
    );
  }
}
