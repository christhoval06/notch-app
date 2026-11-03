import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/presentation/pages/insights_page.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsScreenHeader extends StatelessWidget {
  const StatsScreenHeader({super.key});

  Future<void> _openInsights(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => InsightsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest.withValues(alpha: 0.42),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: scheme.outline.withValues(alpha: 0.18),
                  ),
                ),
                child: Text(
                  l10n.insightsTitle.toUpperCase(),
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                l10n.homeStatsTitle,
                style: TextStyle(
                  color: scheme.onSurface,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  height: 0.95,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.trophyRoomSubtitle,
                style: TextStyle(
                  color: scheme.onSurfaceVariant,
                  fontSize: 15,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        IconButton.filledTonal(
          onPressed: () => _openInsights(context),
          icon: const Icon(Icons.psychology_alt_outlined),
          style: IconButton.styleFrom(
            backgroundColor: scheme.primary.withValues(alpha: 0.14),
            foregroundColor: scheme.primary,
            padding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}
