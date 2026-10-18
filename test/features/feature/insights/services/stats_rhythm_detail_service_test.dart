import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_rhythm_detail_service.dart';

void main() {
  test('build returns rhythm detail summary', () {
    final summary = StatsRhythmDetailService.build(
      encounters: [
        _encounter('1', 'Alex', DateTime(2026, 6, 20, 9)),
        _encounter('2', 'Alex', DateTime(2026, 6, 22, 21)),
        _encounter('3', 'Sam', DateTime(2026, 6, 22, 22)),
        _encounter('4', 'Alex', DateTime(2026, 6, 28, 23)),
      ],
    );

    expect(summary.topBucket, 'night');
    expect(summary.topWeekday, DateTime.monday);
    expect(summary.bucketCounts['night'], 3);
    expect(summary.weekdayCounts[DateTime.monday], 2);
    expect(summary.recentEncounters, hasLength(3));
  });
}

Encounter _encounter(String id, String partnerName, DateTime date) {
  return Encounter(
    id: id,
    date: date,
    partnerName: partnerName,
    orgasmCount: 1,
    rating: 8,
  );
}
