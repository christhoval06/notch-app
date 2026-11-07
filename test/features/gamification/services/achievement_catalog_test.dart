import 'package:flutter_test/flutter_test.dart';
import 'package:notch_app/features/gamification/services/achievement_engine.dart';

void main() {
  test('achievement catalog keeps core achievement ids available', () {
    final ids = AchievementEngine.getAllAchievements().map((a) => a.id).toSet();

    expect(ids.contains('rookie'), isTrue);
    expect(ids.contains('monk_mode'), isTrue);
    expect(ids.contains('abstinence_master_45'), isTrue);
    expect(ids.contains('abstinence_master_90'), isTrue);
    expect(ids.contains('abstinence_master_120'), isTrue);
    expect(ids.contains('grand_master'), isTrue);
    expect(ids.contains('archivist'), isTrue);
    expect(ids.contains('single_partner_badge'), isTrue);
    expect(ids.contains('multiple_partners_badge'), isTrue);
  });
}
