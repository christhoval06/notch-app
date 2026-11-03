import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/core/utils/gamification_level_service.dart';

void main() {
  test('returns gran maestro level when xp reaches threshold', () {
    final level = GamificationLevelService.getCurrentLevel(30000);

    expect(level['name'], 'Gran Maestro');
  });

  test('returns next streak milestone after current streak', () {
    final milestone = GamificationLevelService.getNextStreakMilestone(6);

    expect(milestone['milestone'], 7);
    expect(milestone['remaining'], 1);
  });
}
