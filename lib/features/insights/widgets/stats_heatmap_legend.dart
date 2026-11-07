import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsHeatmapLegend extends StatelessWidget {
  const StatsHeatmapLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final shades = [0.16, 0.34, 0.58, 0.9];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          l10n.statsActivityLegendLess,
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
        ),
        const SizedBox(width: 8),
        ...shades.map(
          (alpha) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: alpha),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          l10n.statsActivityLegendMore,
          style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
        ),
      ],
    );
  }
}
