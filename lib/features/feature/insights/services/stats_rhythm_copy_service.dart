import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsRhythmCopyService {
  const StatsRhythmCopyService._();

  static String bucketLabel(AppLocalizations l10n, String value) {
    switch (value) {
      case 'morning':
        return l10n.statsFilterMorning;
      case 'afternoon':
        return l10n.statsFilterAfternoon;
      default:
        return l10n.statsFilterNight;
    }
  }

  static String weekdayLabel(AppLocalizations l10n, int value) {
    switch (value) {
      case 1:
        return l10n.insightDayMonday;
      case 2:
        return l10n.insightDayTuesday;
      case 3:
        return l10n.insightDayWednesday;
      case 4:
        return l10n.insightDayThursday;
      case 5:
        return l10n.insightDayFriday;
      case 6:
        return l10n.insightDaySaturday;
      default:
        return l10n.insightDaySunday;
    }
  }

  static String protectionTone(
    AppLocalizations l10n,
    StatsProtectionTone tone,
  ) {
    switch (tone) {
      case StatsProtectionTone.improving:
        return l10n.statsProtectionImproving;
      case StatsProtectionTone.caution:
        return l10n.statsProtectionCaution;
      case StatsProtectionTone.stable:
        return l10n.statsProtectionStable;
    }
  }
}
