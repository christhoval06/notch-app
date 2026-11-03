import 'package:collection/collection.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';

class StatsTagDetailService {
  const StatsTagDetailService._();

  static StatsTagDetailSummary build({
    required String tagKey,
    required List<Encounter> encounters,
  }) {
    final items = encounters
        .where((item) => item.tags.contains(tagKey))
        .sorted((a, b) => b.date.compareTo(a.date));
    final dominantMood = items
        .where((item) => item.moodEmoji != null)
        .groupListsBy((item) => item.moodEmoji!)
        .entries
        .sorted((a, b) => b.value.length.compareTo(a.value.length))
        .firstOrNull
        ?.key;
    final partnerEntries = groupBy(items, (Encounter item) => item.partnerName)
        .entries
        .sorted((a, b) => b.value.length.compareTo(a.value.length));
    final protectedCount = items.where((item) => item.protected).length;
    return StatsTagDetailSummary(
      tagKey: tagKey,
      encounterCount: items.length,
      averageRating: items.map((item) => item.rating).average,
      topPartnerName: partnerEntries.first.key,
      dominantMood: dominantMood,
      protectionRate: items.isEmpty ? 0 : protectedCount / items.length,
      topPartners: partnerEntries.take(3).map((entry) => entry.key).toList(),
      recentEncounters: items,
    );
  }
}
