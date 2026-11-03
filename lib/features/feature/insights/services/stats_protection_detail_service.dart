import 'package:collection/collection.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_protection_detail_models.dart';

class StatsProtectionDetailService {
  const StatsProtectionDetailService._();

  static StatsProtectionDetailSummary build({
    required List<Encounter> encounters,
  }) {
    final protectedCount = encounters.where((item) => item.protected).length;
    final unprotected = encounters.where((item) => !item.protected).toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    final grouped = unprotected.groupListsBy((item) => item.partnerName);
    final topRiskPartner = grouped.entries.sorted(
      (a, b) => b.value.length.compareTo(a.value.length),
    );

    return StatsProtectionDetailSummary(
      protectionRate: encounters.isEmpty ? 0 : protectedCount / encounters.length,
      protectedCount: protectedCount,
      unprotectedCount: unprotected.length,
      lastUnprotectedPartnerName: unprotected.firstOrNull?.partnerName,
      lastUnprotectedDate: unprotected.firstOrNull?.date,
      topRiskPartnerName: topRiskPartner.firstOrNull?.key,
      recentUnprotectedEncounters: unprotected.take(3).toList(),
    );
  }
}
