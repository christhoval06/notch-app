import 'package:notch_app/data/models/encounter.dart';

class StatsHeatmapDaySummary {
  const StatsHeatmapDaySummary({
    required this.topPartnerName,
    required this.averageRating,
    required this.dominantMood,
    required this.tagKeys,
    required this.protectedCount,
    required this.unprotectedCount,
  });

  final String topPartnerName;
  final double averageRating;
  final String? dominantMood;
  final List<String> tagKeys;
  final int protectedCount;
  final int unprotectedCount;
}

class StatsHeatmapDaySummaryService {
  const StatsHeatmapDaySummaryService._();

  static StatsHeatmapDaySummary build(List<Encounter> encounters) {
    final topPartner = _topString(encounters.map((item) => item.partnerName));
    final topMood = _topString(
      encounters.where((item) => item.moodEmoji != null).map((item) => item.moodEmoji!),
    );
    final tagCounts = <String, int>{};
    var protectedCount = 0;
    var ratingTotal = 0;
    for (final encounter in encounters) {
      ratingTotal += encounter.rating;
      if (encounter.protected) protectedCount++;
      for (final tag in encounter.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }
    final sortedTags = tagCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return StatsHeatmapDaySummary(
      topPartnerName: topPartner ?? '-',
      averageRating: ratingTotal / encounters.length,
      dominantMood: topMood,
      tagKeys: sortedTags.take(3).map((entry) => entry.key).toList(),
      protectedCount: protectedCount,
      unprotectedCount: encounters.length - protectedCount,
    );
  }

  static String? _topString(Iterable<String> values) {
    final counts = <String, int>{};
    for (final value in values) {
      counts[value] = (counts[value] ?? 0) + 1;
    }
    if (counts.isEmpty) return null;
    final entries = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return entries.first.key;
  }
}
