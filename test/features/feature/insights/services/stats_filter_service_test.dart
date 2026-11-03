import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/features/feature/insights/services/stats_filter_service.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';

void main() {
  test('builds current and previous windows for month and six months', () {
    final now = DateTime(2026, 7, 3);
    final encounters = [
      _encounter('1', now.subtract(const Duration(days: 10))),
      _encounter('2', now.subtract(const Duration(days: 20))),
      _encounter('3', now.subtract(const Duration(days: 40))),
      _encounter('4', now.subtract(const Duration(days: 200))),
    ];

    final month = StatsFilterService.filter(
      encounters: encounters,
      period: StatPeriod.month,
      segment: StatsSegment.all,
      now: now,
    );
    final sixMonths = StatsFilterService.filter(
      encounters: encounters,
      period: StatPeriod.sixMonths,
      segment: StatsSegment.all,
      now: now,
    );

    expect(month.current.length, 2);
    expect(month.previous.length, 1);
    expect(sixMonths.current.length, 3);
    expect(sixMonths.previous.length, 1);
  });

  test('filters by tag, protection, and day time selection', () {
    final now = DateTime(2026, 7, 3);
    final encounters = [
      _encounter('1', DateTime(2026, 6, 25, 9), tags: ['tag_travel']),
      _encounter(
        '2',
        DateTime(2026, 6, 26, 15),
        protected: false,
        tags: ['tag_date'],
      ),
      _encounter('3', DateTime(2026, 6, 27, 21), tags: ['tag_travel']),
    ];

    final byTag = StatsFilterService.filter(
      encounters: encounters,
      period: StatPeriod.sixMonths,
      segment: StatsSegment.tags,
      selection: 'tag_travel',
      now: now,
    );
    final byProtection = StatsFilterService.filter(
      encounters: encounters,
      period: StatPeriod.sixMonths,
      segment: StatsSegment.protection,
      selection: 'unprotected',
      now: now,
    );
    final byDayTime = StatsFilterService.filter(
      encounters: encounters,
      period: StatPeriod.sixMonths,
      segment: StatsSegment.dayTime,
      selection: 'night',
      now: now,
    );

    expect(byTag.current.length, 2);
    expect(byProtection.current.single.id, '2');
    expect(byDayTime.current.single.id, '3');
  });
}

Encounter _encounter(
  String id,
  DateTime date, {
  bool protected = true,
  List<String> tags = const [],
}) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    orgasmCount: 1,
    rating: 8,
    protected: protected,
    tags: tags,
  );
}
