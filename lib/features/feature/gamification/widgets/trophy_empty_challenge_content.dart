import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class TrophyEmptyChallengeContent extends StatelessWidget {
  const TrophyEmptyChallengeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.trophyExploreGoals,
          style: TextStyle(
            color: scheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.trophyExploreGoalsSubtitle,
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 13),
        ),
      ],
    );
  }
}
