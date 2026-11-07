import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/insights/services/stats_story_service.dart';

void main() {
  test('builds best context and momentum story cards when sample is enough', () {
    final stories = StatsStoryService.build(
      current: [
        _encounter('1', DateTime(2026, 6, 20, 21), rating: 9, tags: ['tag_travel']),
        _encounter('2', DateTime(2026, 6, 27, 22), rating: 10, tags: ['tag_travel']),
        _encounter('3', DateTime(2026, 6, 25, 21), rating: 9, tags: ['tag_date']),
        _encounter('4', DateTime(2026, 6, 26, 21), rating: 9, tags: ['tag_date']),
      ],
      previous: [
        _encounter('5', DateTime(2026, 5, 20), rating: 7, protected: false),
        _encounter('6', DateTime(2026, 5, 22), rating: 7, protected: false),
      ],
    );

    expect(stories.any((item) => item.id == 'best_context'), isTrue);
    expect(stories.any((item) => item.id == 'momentum'), isTrue);
    expect(stories.any((item) => item.id == 'protection_trend'), isTrue);
    expect(stories.any((item) => item.id == 'prime_time'), isTrue);
    expect(stories.any((item) => item.id == 'peak_month'), isTrue);
  });
}

Encounter _encounter(
  String id,
  DateTime date, {
  int rating = 8,
  List<String> tags = const [],
  bool protected = true,
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    orgasmCount: 1,
    rating: rating,
    protected: protected,
    tags: tags,
  );
}
