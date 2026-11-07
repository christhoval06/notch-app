import 'package:notch_app/data/models/encounter.dart';

class AchievementPartnerRuleService {
  const AchievementPartnerRuleService._();

  static bool hasSeasonalSinglePartner({
    required List<Encounter> monthlyEncounters,
    required int minimumEncounters,
  }) {
    if (monthlyEncounters.length < minimumEncounters) return false;
    final partners = monthlyEncounters
        .map((encounter) => encounter.partnerName.trim().toLowerCase())
        .where((name) => name.isNotEmpty)
        .toSet();
    return partners.length == 1;
  }

  static bool hasSeasonalMultiplePartners({
    required List<Encounter> monthlyEncounters,
    required int minimumPartners,
  }) {
    final partners = monthlyEncounters
        .map((encounter) => encounter.partnerName.trim().toLowerCase())
        .where((name) => name.isNotEmpty)
        .toSet();
    return partners.length >= minimumPartners;
  }
}
