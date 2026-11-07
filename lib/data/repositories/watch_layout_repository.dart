import 'package:shared_preferences/shared_preferences.dart';
import 'package:notch_app/core/constants/app_prefs.dart';
import 'package:notch_app/core/constants/watch_dashboard_cards.dart';

class WatchLayoutRepository {
  WatchLayoutRepository(this._prefs);
  final SharedPreferences _prefs;

  List<String> load() => WatchDashboardCards.normalize(
    _prefs.getStringList(AppPrefs.watchDashboardCards) ??
        WatchDashboardCards.defaults,
  );

  Future<void> save(List<String> cards) async {
    final saved = await _prefs.setStringList(
      AppPrefs.watchDashboardCards,
      WatchDashboardCards.normalize(cards),
    );
    if (!saved) throw StateError('watch_layout_save_failed');
  }
}
