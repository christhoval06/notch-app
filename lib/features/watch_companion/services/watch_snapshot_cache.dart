import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';
import 'package:notch_app/data/repositories/encounter_repository.dart';
import 'package:notch_app/data/repositories/monthly_progress_repository.dart';

class WatchSnapshotCache {
  List<Encounter> encounters = [];
  List<MonthlyProgress> monthlyProgress = [];
  bool _dirty = true;
  void invalidate() => _dirty = true;
  void refresh() {
    if (!_dirty) return;
    encounters = EncounterRepository.getAll();
    monthlyProgress = MonthlyProgressRepository.getAll();
    _dirty = false;
  }
}
