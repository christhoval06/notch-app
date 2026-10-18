import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/core/utils/gamification_streak_service.dart';
import 'package:notch_app/data/models/encounter.dart';

void main() {
  test('calculates longest streak from unique encounter days', () {
    final streaks = GamificationStreakService.calculateStreaksFromEncounters([
      _encounter('1', DateTime(2026, 6, 1, 10)),
      _encounter('2', DateTime(2026, 6, 1, 20)),
      _encounter('3', DateTime(2026, 6, 2, 10)),
      _encounter('4', DateTime(2026, 6, 3, 10)),
    ], now: DateTime(2026, 6, 3));

    expect(streaks['current'], 3);
    expect(streaks['longest'], 3);
  });
}

Encounter _encounter(String id, DateTime date) {
  return Encounter(
    id: id,
    date: date,
    partnerName: 'Partner $id',
    orgasmCount: 1,
    rating: 8,
  );
}
