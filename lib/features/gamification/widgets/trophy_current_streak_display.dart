import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyCurrentStreakDisplay extends StatelessWidget {
  const TrophyCurrentStreakDisplay({super.key, required this.currentStreak});

  final int currentStreak;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scheme.tertiary.withValues(alpha: 0.15),
            boxShadow: [
              BoxShadow(
                color: scheme.tertiary.withValues(alpha: 0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            Icons.local_fire_department_rounded,
            color: scheme.tertiary,
            size: 36,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              currentStreak.toString(),
              style: TextStyle(
                fontFamily: 'Montserrat',
                color: scheme.onSurface,
                fontSize: 64,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              l10n.trophyDays,
              style: TextStyle(
                fontFamily: 'Lato',
                color: scheme.onSurfaceVariant,
                fontSize: 20,
              ),
            ),
          ],
        ),
        Text(
          l10n.trophyCurrentStreak,
          style: TextStyle(
            fontFamily: 'Lato',
            color: scheme.tertiary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
