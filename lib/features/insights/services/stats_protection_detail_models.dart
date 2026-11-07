import 'package:notch_app/data/models/encounter.dart';

class StatsProtectionDetailSummary {
  const StatsProtectionDetailSummary({
    required this.protectionRate,
    required this.protectedCount,
    required this.unprotectedCount,
    required this.lastUnprotectedPartnerName,
    required this.lastUnprotectedDate,
    required this.topRiskPartnerName,
    required this.recentUnprotectedEncounters,
  });

  final double protectionRate;
  final int protectedCount;
  final int unprotectedCount;
  final String? lastUnprotectedPartnerName;
  final DateTime? lastUnprotectedDate;
  final String? topRiskPartnerName;
  final List<Encounter> recentUnprotectedEncounters;
}
