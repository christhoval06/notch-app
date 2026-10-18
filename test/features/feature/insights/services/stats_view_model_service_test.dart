import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/features/feature/insights/services/stats_view_model_service.dart';

void main() {
  test('buildFromData returns editorial sections and overview summaries', () {
    final model = StatsViewModelService.buildFromData(
      period: StatPeriod.sixMonths,
      encounters: [
        _encounter('1', 'Partner A', DateTime(2026, 6, 20, 21), rating: 9, orgasms: 2, tags: ['tag_travel'], mood: '🔥'),
        _encounter('2', 'Partner A', DateTime(2026, 6, 22, 22), rating: 10, orgasms: 1, tags: ['tag_travel'], mood: '🔥'),
        _encounter('3', 'Partner B', DateTime(2026, 6, 25, 15), rating: 8, orgasms: 3, tags: ['tag_date'], protected: false),
        _encounter('4', 'Partner C', DateTime(2026, 3, 10, 9), rating: 7, orgasms: 1),
      ],
      highestRank: const StatsRankData(rawLevelName: 'Iniciado III', totalXp: 320),
      now: DateTime(2026, 7, 4),
    );

    expect(model.heroMetrics.length, 3);
    expect(model.comparisonState, StatsComparisonState.baseline);
    expect(model.storyCards.isNotEmpty, isTrue);
    expect(model.topPartners.length, lessThanOrEqualTo(3));
    expect(model.topPartners.first.partnerName, 'Partner A');
    expect(model.tagInsights.length, lessThanOrEqualTo(5));
    expect(model.tagInsights.first.tagKey, 'tag_travel');
    expect(model.tagInsights.first.topPartnerName, 'Partner A');
    expect(model.activitySummary.activeDays, 4);
    expect(model.activitySummary.busiestStreak, 1);
    expect(model.activitySummary.currentWeekCount, 0);
    expect(model.activitySummary.previousWeekCount, 2);
    expect(model.protectionSummary.protectionRate, closeTo(0.75, 0.01));
    expect(model.protectionSummary.lastUnprotectedPartnerName, 'Partner B');
    expect(model.rhythmSummary.topBucket, 'night');
  });
}

Encounter _encounter(
  String id,
  String partnerName,
  DateTime date, {
  int rating = 8,
  int orgasms = 1,
  List<String> tags = const [],
  bool protected = true,
  String? mood,
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: partnerName,
    orgasmCount: orgasms,
    rating: rating,
    protected: protected,
    tags: tags,
    moodEmoji: mood,
  );
}
