import 'package:notch_app/data/models/encounter.dart';

class StatsRhythmDetailSummary {
  const StatsRhythmDetailSummary({
    required this.topBucket,
    required this.topWeekday,
    required this.bucketCounts,
    required this.weekdayCounts,
    required this.recentEncounters,
  });

  final String topBucket;
  final int topWeekday;
  final Map<String, int> bucketCounts;
  final Map<int, int> weekdayCounts;
  final List<Encounter> recentEncounters;
}
