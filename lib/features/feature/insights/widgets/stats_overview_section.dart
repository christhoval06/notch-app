import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_comparison_summary.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_hero_panel.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_story_cards.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class StatsOverviewSection extends StatelessWidget {
  const StatsOverviewSection({super.key, required this.viewModel});

  final StatsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.surfaceContainerHighest.withValues(alpha: 0.6),
            scheme.surface.withValues(alpha: 0.92),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: scheme.outline.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.homeStatsTitle,
            style: TextStyle(
              color: scheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.insightsTitle,
            style: TextStyle(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: 18),
          StatsHeroPanel(metrics: viewModel.heroMetrics),
          const SizedBox(height: 16),
          StatsComparisonSummary(state: viewModel.comparisonState),
          const SizedBox(height: 26),
          StatsStoryCards(cards: viewModel.storyCards),
        ],
      ),
    );
  }
}
