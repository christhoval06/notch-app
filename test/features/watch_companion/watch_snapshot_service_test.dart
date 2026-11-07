import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/features/watch_companion/services/watch_snapshot_service.dart';
import 'package:notch_app/l10n/app_localizations_en.dart';

void main() {
  final now = DateTime(2026, 11, 7, 12);
  Encounter entry(int day, int rating, bool protected) => Encounter(
    id: '$day', date: DateTime(2026, 11, day), partnerName: 'Private',
    orgasmCount: 1, rating: rating, protected: protected);
  Map<String, Object?> build(List<Encounter> entries, {DateTime? at}) =>
    WatchSnapshotService.build(now: at ?? now, encounters: entries,
      monthlyProgress: [MonthlyProgress(monthId: '2026-11', xp: 150)],
      l10n: AppLocalizationsEn(), generation: 'g', revision: 1).toMap();
  test('snapshot contains authoritative aggregates without partner history', () {
    final data = build([entry(4, 8, true), entry(6, 10, false)]);
    expect(data['entryCount'], 2);
    expect(data['averageRating'], 9.0);
    expect(data['protectionRate'], .5);
    expect(data['xp'], 150);
    expect(data['progress'], closeTo(1 / 3, .001));
    expect(data['abstinenceReferenceMs'], DateTime(2026, 11, 6).millisecondsSinceEpoch);
    expect(data.values.contains('Private'), isFalse);
  });
  test('empty and rolled-over stats never invent averages or previous-season XP', () {
    final data = build([entry(4, 8, true)], at: DateTime(2026, 12, 1));
    expect(data['monthId'], '2026-12');
    expect(data['entryCount'], 0);
    expect(data['averageRating'], isNull);
    expect(data['protectionRate'], isNull);
    expect(data['xp'], 0);
    expect(build([])['abstinenceReferenceMs'], isNull);
  });
}
