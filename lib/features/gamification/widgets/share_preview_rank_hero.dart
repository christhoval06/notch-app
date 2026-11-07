import 'package:flutter/material.dart';
import 'package:notch_app/features/gamification/widgets/share_preview_progress_bar.dart';

class SharePreviewRankHero extends StatelessWidget {
  const SharePreviewRankHero({
    super.key,
    required this.rankName,
    required this.progressToNextLevel,
    required this.progressLabel,
  });

  final String rankName;
  final double progressToNextLevel;
  final String progressLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 150;
        final dense = constraints.maxHeight < 130;
        final minimal = constraints.maxHeight < 72;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(
            minimal ? 10 : (dense ? 12 : (compact ? 16 : 22)),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                scheme.primaryContainer.withValues(alpha: 0.9),
                scheme.tertiaryContainer.withValues(alpha: 0.8),
              ],
            ),
          ),
          child: minimal
              ? _MinimalHero(
                  rankName: rankName,
                  progressToNextLevel: progressToNextLevel,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            rankName.toUpperCase(),
                            maxLines: dense ? 1 : (compact ? 1 : 2),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'BebasNeue',
                              color: scheme.onPrimaryContainer,
                              fontSize: dense ? 28 : (compact ? 36 : 48),
                              height: 0.95,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: dense ? 6 : (compact ? 10 : 14)),
                    SharePreviewProgressBar(
                      label: progressLabel,
                      progress: progressToNextLevel,
                      compact: compact,
                      dense: dense,
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _MinimalHero extends StatelessWidget {
  const _MinimalHero({
    required this.rankName,
    required this.progressToNextLevel,
  });

  final String rankName;
  final double progressToNextLevel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final value = progressToNextLevel.clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  rankName.toUpperCase(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: scheme.onPrimaryContainer,
                    fontSize: 22,
                    letterSpacing: 1.4,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${(value * 100).round()}%',
                style: TextStyle(
                  fontFamily: 'BebasNeue',
                  color: scheme.onPrimaryContainer.withValues(alpha: 0.84),
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            minHeight: 4,
            value: value,
            backgroundColor: scheme.surfaceContainerHighest.withValues(
              alpha: 0.55,
            ),
            valueColor: AlwaysStoppedAnimation(scheme.onPrimaryContainer),
          ),
        ),
      ],
    );
  }
}
