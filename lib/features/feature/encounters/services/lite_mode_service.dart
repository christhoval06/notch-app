import 'package:notch_app/core/constants/feature_flags.dart';
import 'package:notch_app/data/models/encounter.dart';

class LiteModeService {
  const LiteModeService._();

  static bool canAddEncounter({
    required List<Encounter> encounters,
    required DateTime date,
  }) {
    if (!FeatureFlags.liteModeEnabled) return true;
    return countForMonth(encounters: encounters, date: date) <
        FeatureFlags.liteMonthlyEncounterLimit;
  }

  static int countForMonth({
    required List<Encounter> encounters,
    required DateTime date,
  }) {
    return encounters
        .where((encounter) => _isSameMonth(encounter.date, date))
        .length;
  }

  static bool _isSameMonth(DateTime left, DateTime right) {
    return left.year == right.year && left.month == right.month;
  }
}
