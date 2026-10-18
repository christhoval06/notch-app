import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsComparisonCopyService {
  const StatsComparisonCopyService._();

  static String message(
    AppLocalizations l10n,
    StatsComparisonState state,
  ) {
    switch (state) {
      case StatsComparisonState.baseline:
        return l10n.statsComparisonBaseline;
      case StatsComparisonState.up:
        return l10n.statsComparisonUp;
      case StatsComparisonState.down:
        return l10n.statsComparisonDown;
      case StatsComparisonState.stable:
        return l10n.statsComparisonStable;
    }
  }
}
