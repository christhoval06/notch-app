import 'package:flutter/material.dart';
import 'package:notch_app/features/insights/services/insights_view_model.dart';
import 'package:notch_app/features/insights/widgets/insights_dynamic_feed.dart';
import 'package:notch_app/features/insights/widgets/insights_editorial_card.dart';
import 'package:notch_app/features/insights/widgets/insights_empty_state.dart';
import 'package:notch_app/features/insights/widgets/insights_hero.dart';
import 'package:notch_app/features/insights/widgets/insights_risk_radar.dart';

class InsightsContent extends StatelessWidget {
  const InsightsContent({super.key, required this.viewModel});

  final InsightsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsightsHero(hero: viewModel.hero),
          const SizedBox(height: 18),
          if (!viewModel.hasEnoughData) const InsightsEmptyState(),
          if (viewModel.hasEnoughData) ...[
            InsightsEditorialCard(block: viewModel.bestPattern),
            const SizedBox(height: 14),
            InsightsEditorialCard(block: viewModel.watchout),
            const SizedBox(height: 14),
            InsightsRiskRadar(signals: viewModel.riskSignals),
            const SizedBox(height: 14),
            InsightsEditorialCard(block: viewModel.healthSnapshot),
            const SizedBox(height: 24),
            InsightsDynamicFeed(insights: viewModel.dynamicInsights),
          ],
        ],
      ),
    );
  }
}
