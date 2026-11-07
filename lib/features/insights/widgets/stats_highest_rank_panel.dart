import 'package:flutter/material.dart';
import 'package:notch_app/core/utils/level_localization.dart';
import 'package:notch_app/features/insights/services/stats_models.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsHighestRankPanel extends StatelessWidget {
  const StatsHighestRankPanel({super.key, required this.rank});

  final StatsRankData rank;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final levelName = localizeLevelName(l10n, rank.rawLevelName);
    final levelDescription = localizeLevelDescription(l10n, rank.rawLevelName);

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.statsHighestRankReached,
            textAlign: TextAlign.center,
            style: TextStyle(letterSpacing: 2, fontSize: 12, color: scheme.onSecondaryContainer),
          ),
          const SizedBox(height: 10),
          Text(
            levelName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: scheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            l10n.statsXpTotal(rank.totalXp.toString()),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: scheme.onSecondaryContainer),
          ),
          const SizedBox(height: 15),
          Text(
            levelDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: scheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
