import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/gamification/services/season_activity_metrics_service.dart';
import 'package:notch_app/features/feature/gamification/widgets/season_activity_rhythm_parts.dart';
import 'package:notch_app/features/feature/gamification/widgets/season_activity_rhythm_texts.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class SeasonActivityRhythmCard extends StatelessWidget {
  const SeasonActivityRhythmCard({super.key, required this.metrics});

  final SeasonActivityMetrics metrics;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final hasData = metrics.totalEncounters > 0;
    final dayShare = hasData ? (1 - metrics.nightShare) : 0.0;
    final nightShare = hasData ? metrics.nightShare : 0.0;
    final dominantShare = hasData
        ? (metrics.nightShare >= 0.5 ? metrics.nightShare : (1 - metrics.nightShare))
        : 0.0;
    final pct = (dominantShare * 100).round();
    final isNightDominant = metrics.nightShare >= 0.5;
    final dominantLabel = hasData
        ? (isNightDominant
              ? l10n.trophyRhythmDominantNight
              : l10n.trophyRhythmDominantDay)
        : '--';
    final vibe = SeasonActivityRhythmTexts.vibeMessage(l10n, metrics);
    final peakRange = SeasonActivityRhythmTexts.peakWindowRange(metrics.peakWindowStartHour);
    final detail = l10n.trophyRhythmPeakWindowDetail(
      (metrics.peakWindowShare * 100).round().toString(),
      peakRange,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.trophyActivityRhythm, style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Center(
            child: SizedBox(
              width: 160,
              height: 90,
              child: CustomPaint(
                painter: SeasonActivityGaugePainter(
                  dayShare: dayShare,
                  nightShare: nightShare,
                  dayColor: scheme.tertiary,
                  nightColor: scheme.primary,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 22),
                    child: Text('$pct%', style: TextStyle(color: scheme.onSurface, fontWeight: FontWeight.bold, fontSize: 24)),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.wb_sunny_rounded,
                      size: 18,
                      color: scheme.onSurfaceVariant,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.nightlight_round,
                      size: 18,
                      color: scheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text('${l10n.trophyRhythmDominantLabel}: $dominantLabel', style: TextStyle(color: scheme.onSurfaceVariant, fontWeight: FontWeight.w600, fontSize: 12)),
          const SizedBox(height: 6),
          Text(vibe, style: TextStyle(color: scheme.primary, fontWeight: FontWeight.w700)),
          Text(detail, style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12)),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: SeasonActivityMetricBox(
                  title: l10n.trophyPeakHour,
                  value: SeasonActivityRhythmTexts.peakHour(metrics.peakHour),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SeasonActivityMetricBox(
                  title: l10n.trophyWeeklyActivity,
                  value: SeasonActivityRhythmTexts.weeklyChangeValue(l10n, metrics.weeklyChangePercent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
