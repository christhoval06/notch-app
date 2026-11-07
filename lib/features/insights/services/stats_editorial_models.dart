import 'package:notch_app/data/models/encounter.dart';

enum StatsPartnerBadge { mostActive, bestChemistry, mostRecent }

enum StatsProtectionTone { stable, improving, caution }

class StatsPartnerSummary {
  const StatsPartnerSummary({
    required this.partnerName,
    required this.encounterCount,
    required this.avgRating,
    required this.totalOrgasms,
    required this.lastEncounterAt,
    this.badge,
  });

  final String partnerName;
  final int encounterCount;
  final double avgRating;
  final int totalOrgasms;
  final DateTime lastEncounterAt;
  final StatsPartnerBadge? badge;
}

class StatsTagInsight {
  const StatsTagInsight({
    required this.tagKey,
    required this.count,
    required this.avgRating,
    required this.topPartnerName,
    this.dominantMood,
  });

  final String tagKey;
  final int count;
  final double avgRating;
  final String topPartnerName;
  final String? dominantMood;
}

class StatsProtectionSummary {
  const StatsProtectionSummary({
    required this.protectionRate,
    required this.protectedCount,
    required this.unprotectedCount,
    required this.tone,
    this.lastUnprotectedPartnerName,
    this.lastUnprotectedDate,
  });

  final double protectionRate;
  final int protectedCount;
  final int unprotectedCount;
  final StatsProtectionTone tone;
  final String? lastUnprotectedPartnerName;
  final DateTime? lastUnprotectedDate;
}

class StatsRhythmSummary {
  const StatsRhythmSummary({
    required this.topBucket,
    required this.topWeekday,
    required this.bucketCounts,
  });

  final String topBucket;
  final int topWeekday;
  final Map<String, int> bucketCounts;
}

class StatsActivitySummary {
  const StatsActivitySummary({
    required this.activeDays,
    required this.busiestStreak,
    required this.currentWeekCount,
    required this.previousWeekCount,
  });

  final int activeDays;
  final int busiestStreak;
  final int currentWeekCount;
  final int previousWeekCount;
}

class StatsPartnerDetailSummary {
  const StatsPartnerDetailSummary({
    required this.partnerName,
    required this.encounterCount,
    required this.averageRating,
    required this.totalOrgasms,
    required this.protectionRate,
    required this.dominantMood,
    required this.topTags,
    required this.recentEncounters,
    required this.topBucket,
  });

  final String partnerName;
  final int encounterCount;
  final double averageRating;
  final int totalOrgasms;
  final double protectionRate;
  final String? dominantMood;
  final List<String> topTags;
  final List<Encounter> recentEncounters;
  final String topBucket;
}

class StatsTagDetailSummary {
  const StatsTagDetailSummary({
    required this.tagKey,
    required this.encounterCount,
    required this.averageRating,
    required this.topPartnerName,
    required this.dominantMood,
    required this.protectionRate,
    required this.topPartners,
    required this.recentEncounters,
  });

  final String tagKey;
  final int encounterCount;
  final double averageRating;
  final String topPartnerName;
  final String? dominantMood;
  final double protectionRate;
  final List<String> topPartners;
  final List<Encounter> recentEncounters;
}
