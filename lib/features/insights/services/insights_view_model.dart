import 'package:flutter/material.dart';
import 'package:notch_app/data/models/insight.dart';

enum InsightsTone { positive, neutral, caution }

class InsightsHeroData {
  const InsightsHeroData({
    required this.eyebrow,
    required this.title,
    required this.summary,
    required this.primaryChip,
    required this.secondaryChip,
    required this.tone,
  });

  final String eyebrow;
  final String title;
  final String summary;
  final String primaryChip;
  final String secondaryChip;
  final InsightsTone tone;
}

class InsightsEditorialBlockData {
  const InsightsEditorialBlockData({
    required this.label,
    required this.headline,
    required this.body,
    required this.detail,
    required this.recommendation,
    required this.icon,
    required this.tone,
  });

  final String label;
  final String headline;
  final String body;
  final String detail;
  final String recommendation;
  final IconData icon;
  final InsightsTone tone;
}

class InsightsRiskSignalData {
  const InsightsRiskSignalData({
    required this.label,
    required this.value,
    required this.tone,
  });

  final String label;
  final String value;
  final InsightsTone tone;
}

class InsightsViewModel {
  const InsightsViewModel({
    required this.hero,
    required this.bestPattern,
    required this.watchout,
    required this.healthSnapshot,
    required this.riskSignals,
    required this.dynamicInsights,
    required this.hasEnoughData,
  });

  final InsightsHeroData hero;
  final InsightsEditorialBlockData bestPattern;
  final InsightsEditorialBlockData watchout;
  final InsightsEditorialBlockData healthSnapshot;
  final List<InsightsRiskSignalData> riskSignals;
  final List<Insight> dynamicInsights;
  final bool hasEnoughData;
}
