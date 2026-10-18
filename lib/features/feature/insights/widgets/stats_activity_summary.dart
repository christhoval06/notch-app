import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/features/feature/insights/services/stats_editorial_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_activity_metric.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_animated_metric_value.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsActivitySummaryCard extends StatelessWidget {
  const StatsActivitySummaryCard({
    super.key,
    required this.period,
    required this.summary,
  });

  final StatPeriod period;
  final StatsActivitySummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return TweenAnimationBuilder<double>(
      key: ValueKey(period),
      duration: const Duration(milliseconds: 320),
      tween: Tween(begin: 0.98, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(scale: value, child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              scheme.surface,
              scheme.primaryContainer.withValues(alpha: 0.35),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: StatsActivityMetric(
                label: l10n.statsBusiestStreakTitle,
                value: StatsAnimatedMetricValue(
                  value: summary.busiestStreak.toDouble(),
                  formatter: (value) => l10n.statsDaysUnit(
                    value.round().toString(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StatsActivityMetric(
                label: l10n.statsActiveDaysLabel,
                value: StatsAnimatedMetricValue(
                  value: summary.activeDays.toDouble(),
                  formatter: (value) => l10n.statsDaysUnit(
                    value.round().toString(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StatsActivityMetric(
                label: l10n.statsWeeklySnapshotTitle,
                value: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 240),
                  child: Text(
                    '${summary.currentWeekCount}/${summary.previousWeekCount}',
                    key: ValueKey(
                      '${summary.currentWeekCount}/${summary.previousWeekCount}',
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                detail:
                    '${l10n.statsCurrentWeekLabel} ${summary.currentWeekCount} • '
                    '${l10n.statsPreviousWeekLabel} ${summary.previousWeekCount}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
