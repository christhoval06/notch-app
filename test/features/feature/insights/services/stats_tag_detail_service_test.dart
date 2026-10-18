import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_tag_detail_service.dart';

void main() {
  test('build returns editorial tag detail summary', () {
    final summary = StatsTagDetailService.build(
      tagKey: 'tag_travel',
      encounters: [
        _encounter('1', 'Partner A', DateTime(2026, 6, 20, 21), rating: 9, tags: ['tag_travel'], mood: '🔥'),
        _encounter('2', 'Partner A', DateTime(2026, 6, 22, 22), rating: 10, tags: ['tag_travel', 'tag_date'], mood: '🔥'),
        _encounter('3', 'Partner B', DateTime(2026, 6, 25, 15), rating: 8, tags: ['tag_travel'], protected: false),
      ],
    );

    expect(summary.tagKey, 'tag_travel');
    expect(summary.encounterCount, 3);
    expect(summary.topPartnerName, 'Partner A');
    expect(summary.dominantMood, '🔥');
    expect(summary.protectionRate, closeTo(0.67, 0.01));
    expect(summary.topPartners, containsAll(['Partner A', 'Partner B']));
    expect(summary.recentEncounters.first.date, DateTime(2026, 6, 25, 15));
  });
}

Encounter _encounter(
  String id,
  String partnerName,
  DateTime date, {
  int rating = 8,
  List<String> tags = const [],
  bool protected = true,
  String? mood,
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: partnerName,
    orgasmCount: 1,
    rating: rating,
    protected: protected,
    tags: tags,
    moodEmoji: mood,
  );
}
