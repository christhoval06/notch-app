import 'package:intl/intl.dart';
import 'package:notch_app/features/feature/gamification/services/season_activity_metrics_service.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SeasonActivityRhythmTexts {
  static String peakHour(int? hour) {
    if (hour == null) return '--';
    return DateFormat('h a').format(DateTime(2026, 1, 1, hour));
  }

  static String peakWindowRange(int? startHour) {
    if (startHour == null) return '--';
    final endHour = (startHour + 4) % 24;
    final start = DateFormat('h a').format(DateTime(2026, 1, 1, startHour));
    final end = DateFormat('h a').format(DateTime(2026, 1, 1, endHour));
    return '$start - $end';
  }

  static String weeklyChangeValue(AppLocalizations l10n, double? change) {
    if (change == null) return l10n.trophyWeeklyActivityNoData;
    final sign = change >= 0 ? '+' : '';
    return '$sign${change.toStringAsFixed(0)}%';
  }

  static String vibeMessage(
    AppLocalizations l10n,
    SeasonActivityMetrics metrics,
  ) {
    final isNight = metrics.nightShare >= 0.6;
    final selector = metrics.totalEncounters % 3;
    if (isNight) {
      if (selector == 0) return l10n.trophyRhythmVibeNight1;
      if (selector == 1) return l10n.trophyRhythmVibeNight2;
      return l10n.trophyRhythmVibeNight3;
    }
    if (selector == 0) return l10n.trophyRhythmVibeDay1;
    if (selector == 1) return l10n.trophyRhythmVibeDay2;
    return l10n.trophyRhythmVibeDay3;
  }
}
