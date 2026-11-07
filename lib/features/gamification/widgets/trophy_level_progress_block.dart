import 'package:flutter/material.dart';

class TrophyLevelProgressBlock extends StatelessWidget {
  const TrophyLevelProgressBlock({
    super.key,
    required this.foreground,
    required this.scheme,
    required this.isCurrentMonth,
    required this.xp,
    required this.progressValue,
    required this.nextXpText,
  });

  final Color foreground;
  final ColorScheme scheme;
  final bool isCurrentMonth;
  final int xp;
  final double progressValue;
  final String nextXpText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: scheme.scrim.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                '$xp XP',
                style: TextStyle(
                  color: foreground,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            if (isCurrentMonth) ...[
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  nextXpText,
                  style: TextStyle(
                    color: foreground.withValues(alpha: 0.84),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        if (isCurrentMonth) ...[
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 12,
              backgroundColor: scheme.scrim.withValues(alpha: 0.34),
              color: scheme.tertiary,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${(progressValue * 100).round()}%',
              style: TextStyle(
                color: foreground.withValues(alpha: 0.88),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
