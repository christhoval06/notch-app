import 'package:intl/intl.dart';
import 'package:notch_app/data/models/encounter.dart';

class ChallengePartnerProgressService {
  const ChallengePartnerProgressService._();

  static int seasonalSinglePartnerProgress(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    final monthId = DateFormat('yyyy-MM').format(now);
    final seasonal = encounters
        .where((entry) => DateFormat('yyyy-MM').format(entry.date) == monthId)
        .toList();
    if (seasonal.isEmpty) return 0;
    final partners = seasonal
        .map((entry) => _normalizePartner(entry.partnerName))
        .where((name) => name.isNotEmpty)
        .toSet();
    if (partners.length != 1) return 0;
    return seasonal.length;
  }

  static int historicalSinglePartnerProgress(List<Encounter> encounters) {
    return _topPartnerCount(encounters);
  }

  static int historicalProtectedPartnerProgress(List<Encounter> encounters) {
    return _topPartnerCount(encounters.where((entry) => entry.protected));
  }

  static int seasonalDistinctPartnerCount(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    final monthId = DateFormat('yyyy-MM').format(now);
    return encounters
        .where((entry) => DateFormat('yyyy-MM').format(entry.date) == monthId)
        .map((entry) => _normalizePartner(entry.partnerName))
        .where((name) => name.isNotEmpty)
        .toSet()
        .length;
  }

  static int historicalDistinctPartnerCount(List<Encounter> encounters) {
    return encounters
        .map((entry) => _normalizePartner(entry.partnerName))
        .where((name) => name.isNotEmpty)
        .toSet()
        .length;
  }

  static int seasonalHighRatingPartnerCount(
    List<Encounter> encounters, {
    required DateTime now,
    required int minimumRating,
  }) {
    return _seasonalPartners(
      encounters,
      now: now,
      predicate: (entry) => entry.rating >= minimumRating,
    ).length;
  }

  static int seasonalProtectedPartnerCount(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    return _seasonalPartners(
      encounters,
      now: now,
      predicate: (entry) => entry.protected,
    ).length;
  }

  static int seasonalWeekendPartnerCount(
    List<Encounter> encounters, {
    required DateTime now,
  }) {
    return _seasonalPartners(
      encounters,
      now: now,
      predicate: (entry) => entry.date.weekday >= DateTime.friday,
    ).length;
  }

  static int _topPartnerCount(Iterable<Encounter> encounters) {
    final counts = <String, int>{};
    for (final entry in encounters) {
      final partner = _normalizePartner(entry.partnerName);
      if (partner.isEmpty) continue;
      counts.update(partner, (value) => value + 1, ifAbsent: () => 1);
    }
    return counts.values.fold<int>(
      0,
      (best, count) => count > best ? count : best,
    );
  }

  static String _normalizePartner(String value) => value.trim().toLowerCase();

  static Set<String> _seasonalPartners(
    List<Encounter> encounters, {
    required DateTime now,
    required bool Function(Encounter entry) predicate,
  }) {
    final monthId = DateFormat('yyyy-MM').format(now);
    return encounters
        .where((entry) => DateFormat('yyyy-MM').format(entry.date) == monthId)
        .where(predicate)
        .map((entry) => _normalizePartner(entry.partnerName))
        .where((name) => name.isNotEmpty)
        .toSet();
  }
}
