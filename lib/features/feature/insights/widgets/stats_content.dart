import 'package:flutter/material.dart';
import 'package:notch_app/features/feature/insights/services/stats_models.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_activity_section.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_empty_state.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_overview_section.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_period_toggle.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_premium_hero.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_premium_story_deck.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_protection_section.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_reveal.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_rhythm_section.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_signal_strip.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_tag_intelligence_section.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_top_partners_section.dart';
import 'package:notch_app/features/feature/insights/widgets/stats_screen_header.dart';

class StatsContent extends StatelessWidget {
  const StatsContent({
    super.key,
    required this.viewModel,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  final StatsViewModel viewModel;
  final StatPeriod selectedPeriod;
  final ValueChanged<StatPeriod> onPeriodChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatsScreenHeader(),
          const SizedBox(height: 18),
          StatsPeriodToggle(
            selectedPeriod: selectedPeriod,
            onChanged: onPeriodChanged,
          ),
          const SizedBox(height: 24),
          if (!viewModel.hasData) const StatsEmptyState(),
          if (viewModel.hasData) ...[
            StatsReveal(
              intervalStart: 0.0,
              child: StatsPremiumHero(hero: viewModel.premiumIntelligence.hero),
            ),
            const SizedBox(height: 18),
            StatsReveal(
              intervalStart: 0.06,
              child: StatsSignalStrip(
                signals: viewModel.premiumIntelligence.signals,
              ),
            ),
            const SizedBox(height: 24),
            StatsReveal(
              intervalStart: 0.12,
              child: StatsPremiumStoryDeck(
                stories: viewModel.premiumIntelligence.stories,
              ),
            ),
            const SizedBox(height: 30),
            StatsReveal(
              intervalStart: 0.18,
              child: StatsOverviewSection(viewModel: viewModel),
            ),
            const SizedBox(height: 30),
            StatsReveal(
              intervalStart: 0.24,
              child: StatsActivitySection(
                period: selectedPeriod,
                activitySummary: viewModel.activitySummary,
                encounters: viewModel.encounters,
                monthlyData: viewModel.monthlyData,
                heatmapData: viewModel.heatmapData,
              ),
            ),
            const SizedBox(height: 32),
            StatsReveal(
              intervalStart: 0.32,
              child: StatsTopPartnersSection(
                partners: viewModel.topPartners,
                encounters: viewModel.encounters,
              ),
            ),
            const SizedBox(height: 32),
            StatsReveal(
              intervalStart: 0.4,
              child: StatsTagIntelligenceSection(
                tags: viewModel.tagInsights,
                encounters: viewModel.encounters,
              ),
            ),
            const SizedBox(height: 32),
            StatsReveal(
              intervalStart: 0.48,
              child: StatsProtectionSection(
                summary: viewModel.protectionSummary,
                encounters: viewModel.encounters,
              ),
            ),
            const SizedBox(height: 32),
            StatsReveal(
              intervalStart: 0.56,
              child: StatsRhythmSection(
                summary: viewModel.rhythmSummary,
                encounters: viewModel.encounters,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
