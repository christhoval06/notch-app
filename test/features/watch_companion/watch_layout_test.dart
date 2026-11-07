import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notch_app/core/constants/app_prefs.dart';
import 'package:notch_app/data/repositories/watch_layout_repository.dart';
import 'package:notch_app/features/watch_companion/state/watch_layout_controller.dart';

void main() {
  test(
    'missing preferences use defaults; explicit empty selection survives reload',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final repo = WatchLayoutRepository(prefs);
      expect(repo.load(), ['abstinence', 'level', 'stats']);
      await repo.save([]);
      expect(WatchLayoutRepository(prefs).load(), isEmpty);
    },
  );
  test('saved order ignores unknown and duplicate cards', () async {
    SharedPreferences.setMockInitialValues({
      AppPrefs.watchDashboardCards: ['stats', 'unknown', 'stats', 'abstinence'],
    });
    final prefs = await SharedPreferences.getInstance();
    final repo = WatchLayoutRepository(prefs);
    expect(repo.load(), ['stats', 'abstinence']);
    await repo.save(['orgasms', 'stats']);
    expect(WatchLayoutRepository(prefs).load(), ['orgasms', 'stats']);
  });
  test(
    'rapid toggles and ordering retain every change and persist it',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final controller = WatchLayoutController(WatchLayoutRepository(prefs));
      addTearDown(controller.dispose);
      await Future.wait([
        controller.setEnabled('abstinence', false),
        controller.setEnabled('orgasms', true),
        controller.setEnabled('level', false),
      ]);
      expect(controller.value, ['stats', 'orgasms']);
      await controller.reorder(['orgasms', 'stats']);
      expect(WatchLayoutRepository(prefs).load(), ['orgasms', 'stats']);
      await controller.setEnabled('stats', false);
      await controller.setEnabled('orgasms', false);
      expect(controller.value, isEmpty);
      await controller.setEnabled('abstinence', true);
      expect(controller.value, ['abstinence']);
    },
  );
}
