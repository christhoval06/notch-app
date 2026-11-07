import 'package:collection/collection.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_editorial_models.dart';

class StatsPartnerSummaryService {
  const StatsPartnerSummaryService._();

  static List<StatsPartnerSummary> build(List<Encounter> encounters) {
    final grouped = groupBy(encounters, (Encounter item) => item.partnerName);
    final sorted = grouped.entries.map((entry) {
      final items = entry.value;
      final latest = items.sorted((a, b) => b.date.compareTo(a.date)).first.date;
      return StatsPartnerSummary(
        partnerName: entry.key,
        encounterCount: items.length,
        avgRating: items.map((item) => item.rating).average,
        totalOrgasms: items.fold(0, (sum, item) => sum + item.orgasmCount),
        lastEncounterAt: latest,
      );
    }).sorted((a, b) {
      final countOrder = b.encounterCount.compareTo(a.encounterCount);
      return countOrder != 0 ? countOrder : b.avgRating.compareTo(a.avgRating);
    }).take(3).toList();
    if (sorted.isEmpty) return const [];
    final latest = sorted.sorted(
      (a, b) => b.lastEncounterAt.compareTo(a.lastEncounterAt),
    ).first.partnerName;
    return [
      for (var index = 0; index < sorted.length; index++)
        StatsPartnerSummary(
          partnerName: sorted[index].partnerName,
          encounterCount: sorted[index].encounterCount,
          avgRating: sorted[index].avgRating,
          totalOrgasms: sorted[index].totalOrgasms,
          lastEncounterAt: sorted[index].lastEncounterAt,
          badge: index == 0
              ? StatsPartnerBadge.mostActive
              : sorted[index].partnerName == latest
              ? StatsPartnerBadge.mostRecent
              : StatsPartnerBadge.bestChemistry,
        ),
    ];
  }
}
