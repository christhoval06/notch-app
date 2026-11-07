import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyStreakRecordCard extends StatelessWidget {
  const TrophyStreakRecordCard({
    super.key,
    required this.title,
    required this.icon,
    required this.days,
    required this.color,
    required this.currentStreak,
    required this.recordToBeat,
    this.isAllTime = false,
  });

  final String title;
  final IconData icon;
  final int days;
  final Color color;
  final int currentStreak;
  final int recordToBeat;
  final bool isAllTime;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final bottomText = _bottomText(l10n);
    final progress = _progress();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.scrim.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                days.toString(),
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                l10n.trophyDays,
                style: TextStyle(
                  fontFamily: 'Lato',
                  color: scheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, color: color, size: 12),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: scheme.onSurface,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: scheme.surfaceContainerHighest,
              color: color,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              if (isAllTime && progress == 1.0)
                Icon(Icons.check_circle, color: color, size: 12),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  bottomText,
                  style: TextStyle(
                    fontFamily: 'Lato',
                    color: scheme.onSurfaceVariant,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  double _progress() {
    if (isAllTime) {
      if (recordToBeat <= 0) return 0;
      if (currentStreak >= recordToBeat) return 1;
      return currentStreak / recordToBeat;
    }
    if (days <= 0 || recordToBeat <= 0) return 0;
    return days / recordToBeat;
  }

  String _bottomText(AppLocalizations l10n) {
    if (isAllTime) {
      if (currentStreak >= recordToBeat && recordToBeat > 0) {
        return l10n.trophyRecordReached;
      }
      if (recordToBeat > 0) return l10n.trophyBeatingRecord;
      return l10n.trophyNoRecord;
    }
    if (days > 0 && recordToBeat > 0) {
      return l10n.trophyPercentOfHistorical(
        (_progress() * 100).toStringAsFixed(0),
      );
    }
    return l10n.trophyNoStreakThisMonth;
  }
}
