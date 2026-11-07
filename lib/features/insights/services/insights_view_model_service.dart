import 'package:notch_app/core/utils/analyzer.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/features/insights/services/insights_editorial_service.dart';
import 'package:notch_app/features/insights/services/insights_watchout_service.dart';
import 'package:notch_app/features/insights/services/insights_view_model.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class InsightsViewModelService {
  const InsightsViewModelService._();

  static InsightsViewModel build({
    required List<Encounter> encounters,
    required List<HealthLog> healthLogs,
    required AppLocalizations l10n,
    DateTime? now,
  }) {
    final analyzer = Analyzer(encounters, healthLogs);
    final date = now ?? DateTime.now();
    return InsightsViewModel(
      hero: InsightsEditorialService.hero(encounters, healthLogs, l10n),
      bestPattern: InsightsEditorialService.bestPattern(
        encounters,
        analyzer,
        l10n,
      ),
      watchout: InsightsWatchoutService.watchout(
        encounters,
        healthLogs,
        l10n,
        date,
      ),
      healthSnapshot: InsightsEditorialService.healthSnapshot(
        healthLogs,
        l10n,
        date,
      ),
      riskSignals: InsightsWatchoutService.riskSignals(
        encounters,
        healthLogs,
        l10n,
        date,
      ),
      dynamicInsights: analyzer.generateInsights(l10n),
      hasEnoughData: encounters.isNotEmpty || healthLogs.isNotEmpty,
    );
  }
}
