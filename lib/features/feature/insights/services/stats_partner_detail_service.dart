import 'package:collection/collection.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_summary_service.dart';

class StatsPartnerDetailService {
  const StatsPartnerDetailService._();

  static StatsPartnerDetailSummary build({
    required String partnerName,
    required List<Encounter> encounters,
  }) {
    final items = encounters
        .where((item) => item.partnerName == partnerName)
        .sorted((a, b) => b.date.compareTo(a.date));
    final tagCounts = <String, int>{};
    for (final encounter in items) {
      for (final tag in encounter.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }
    final dominantMood = items
        .where((item) => item.moodEmoji != null)
        .groupListsBy((item) => item.moodEmoji!)
        .entries
        .sorted((a, b) => b.value.length.compareTo(a.value.length))
        .firstOrNull
        ?.key;
    final topTags = tagCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final protectedCount = items.where((item) => item.protected).length;
    return StatsPartnerDetailSummary(
      partnerName: partnerName,
      encounterCount: items.length,
      averageRating: items.map((item) => item.rating).average,
      totalOrgasms: items.fold(0, (sum, item) => sum + item.orgasmCount),
      protectionRate: items.isEmpty ? 0 : protectedCount / items.length,
      dominantMood: dominantMood,
      topTags: topTags.take(3).map((entry) => entry.key).toList(),
      recentEncounters: items,
      topBucket: StatsRhythmSummaryService.build(items).topBucket,
    );
  }
}
