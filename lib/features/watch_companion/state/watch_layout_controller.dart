import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notch_app/core/constants/watch_dashboard_cards.dart';
import 'package:notch_app/data/repositories/watch_layout_repository.dart';

class WatchLayoutController extends ValueNotifier<List<String>> {
  WatchLayoutController(this._repository) : super(_repository.load());
  final WatchLayoutRepository _repository;
  Future<void> _pending = Future.value();
  static late WatchLayoutController instance;

  static void initialize(SharedPreferences prefs) {
    instance = WatchLayoutController(WatchLayoutRepository(prefs));
  }

  Future<void> setEnabled(String id, bool enabled) => _update((current) {
    if (!WatchDashboardCards.all.contains(id)) return current;
    if (current.contains(id) == enabled) return current;
    current.remove(id);
    if (enabled) current.add(id);
    return current;
  });

  Future<void> reorder(List<String> ids) => _update(
    (current) => [
      ...WatchDashboardCards.normalize(ids).where(current.contains),
      ...current.where((id) => !ids.contains(id)),
    ],
  );

  Future<void> _update(List<String> Function(List<String>) change) {
    final operation = _pending.then((_) async {
      final next = change([...value]);
      if (listEquals(next, value)) return;
      await _repository.save(next);
      value = List.unmodifiable(next);
    });
    _pending = operation.then<void>(
      (_) {},
      onError: (Object _, StackTrace _) {},
    );
    return operation;
  }
}
