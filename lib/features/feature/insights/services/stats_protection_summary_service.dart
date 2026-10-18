import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';

class StatsProtectionSummaryService {
  const StatsProtectionSummaryService._();

  static StatsProtectionSummary build({
    required List<Encounter> current,
    required List<Encounter> previous,
  }) {
    final protectedCount = current.where((item) => item.protected).length;
    final unprotectedCount = current.length - protectedCount;
    final currentRate = current.isEmpty ? 0.0 : protectedCount / current.length;
    final previousProtected = previous.where((item) => item.protected).length;
    final previousRate = previous.isEmpty ? currentRate : previousProtected / previous.length;
    final lastUnprotected = current
        .where((item) => !item.protected)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return StatsProtectionSummary(
      protectionRate: currentRate,
      protectedCount: protectedCount,
      unprotectedCount: unprotectedCount,
      lastUnprotectedPartnerName: lastUnprotected.isEmpty ? null : lastUnprotected.first.partnerName,
      lastUnprotectedDate: lastUnprotected.isEmpty ? null : lastUnprotected.first.date,
      tone: currentRate >= previousRate + 0.1
          ? StatsProtectionTone.improving
          : currentRate + 0.1 < previousRate
          ? StatsProtectionTone.caution
          : StatsProtectionTone.stable,
    );
  }
}
