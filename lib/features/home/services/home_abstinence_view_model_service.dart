import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/monthly_progress.dart';

class HomeAbstinenceViewModel {
  const HomeAbstinenceViewModel({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.showZeroState,
  });

  final int days;
  final int hours;
  final int minutes;
  final bool showZeroState;
}

class HomeAbstinenceViewModelService {
  const HomeAbstinenceViewModelService._();

  static HomeAbstinenceViewModel build({
    required List<Encounter> encounters,
    required List<MonthlyProgress> monthlyEntries,
    required DateTime now,
  }) {
    final currentMonthId = _monthId(now);
    final hasCurrentSeasonData =
        encounters.any((entry) => _monthId(entry.date) == currentMonthId) ||
        monthlyEntries.any(
          (entry) =>
              entry.monthId == currentMonthId && _hasMeaningfulProgress(entry),
        );
    final hasPreviousHistory = monthlyEntries.any(
      (entry) =>
          entry.monthId != currentMonthId && _hasMeaningfulProgress(entry),
    );

    if (!hasCurrentSeasonData && !hasPreviousHistory) {
      return const HomeAbstinenceViewModel(
        days: 0,
        hours: 0,
        minutes: 0,
        showZeroState: true,
      );
    }

    if (encounters.isEmpty) {
      return const HomeAbstinenceViewModel(
        days: 0,
        hours: 0,
        minutes: 0,
        showZeroState: false,
      );
    }

    final sortedEncounters = List<Encounter>.from(encounters)
      ..sort((a, b) => b.date.compareTo(a.date));
    final diff = now.difference(sortedEncounters.first.date);

    return HomeAbstinenceViewModel(
      days: diff.inDays,
      hours: diff.inHours.remainder(24),
      minutes: diff.inMinutes.remainder(60),
      showZeroState: false,
    );
  }

  static bool _hasMeaningfulProgress(MonthlyProgress entry) {
    return entry.xp > 0 ||
        entry.unlockedBadges.isNotEmpty ||
        entry.finalRank != null ||
        (entry.longestStreakOfMonth ?? 0) > 0;
  }

  static String _monthId(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    return '${date.year}-$month';
  }
}
