import 'package:collection/collection.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';

class StatsTagSummaryService {
  const StatsTagSummaryService._();

  static List<StatsTagInsight> build(List<Encounter> encounters) {
    final grouped = <String, List<Encounter>>{};
    for (final encounter in encounters) {
      for (final tag in encounter.tags) {
        grouped.putIfAbsent(tag, () => []).add(encounter);
      }
    }
    return grouped.entries.map((entry) {
      final items = entry.value;
      final topPartner = groupBy(items, (Encounter item) => item.partnerName).entries
          .sorted((a, b) => b.value.length.compareTo(a.value.length))
          .first
          .key;
      final dominantMood = items
          .where((item) => item.moodEmoji != null)
          .groupListsBy((item) => item.moodEmoji!)
          .entries
          .sorted((a, b) => b.value.length.compareTo(a.value.length))
          .firstOrNull
          ?.key;
      return StatsTagInsight(
        tagKey: entry.key,
        count: items.length,
        avgRating: items.map((item) => item.rating).average,
        topPartnerName: topPartner,
        dominantMood: dominantMood,
      );
    }).sorted((a, b) {
      final countOrder = b.count.compareTo(a.count);
      return countOrder != 0 ? countOrder : b.avgRating.compareTo(a.avgRating);
    }).take(5).toList();
  }
}
