import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_partner_detail_service.dart';

void main() {
  test('build returns editorial partner detail summary', () {
    final summary = StatsPartnerDetailService.build(
      partnerName: 'Partner A',
      encounters: [
        _encounter('1', 'Partner A', DateTime(2026, 6, 20, 21), rating: 9, orgasms: 2, tags: ['tag_travel'], mood: '🔥'),
        _encounter('2', 'Partner A', DateTime(2026, 6, 22, 22), rating: 10, orgasms: 1, tags: ['tag_travel', 'tag_date'], mood: '🔥'),
        _encounter('3', 'Partner A', DateTime(2026, 6, 25, 15), rating: 8, orgasms: 3, tags: ['tag_date'], protected: false),
        _encounter('4', 'Partner B', DateTime(2026, 3, 10, 9), rating: 7, orgasms: 1),
      ],
    );

    expect(summary.partnerName, 'Partner A');
    expect(summary.encounterCount, 3);
    expect(summary.averageRating, closeTo(9, 0.01));
    expect(summary.totalOrgasms, 6);
    expect(summary.protectionRate, closeTo(0.67, 0.01));
    expect(summary.dominantMood, '🔥');
    expect(summary.topTags, containsAll(['tag_travel', 'tag_date']));
    expect(summary.recentEncounters.first.date, DateTime(2026, 6, 25, 15));
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
