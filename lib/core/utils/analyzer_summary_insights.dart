import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:notch_app/core/theme/app_colors.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/insight.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AnalyzerSummaryInsights {
  AnalyzerSummaryInsights(this.data);

  final List<Encounter> data;

  List<Insight> build(AppLocalizations l10n) {
    final insights = <Insight>[];
    _add(insights, _averageSatisfaction(l10n));
    _add(insights, _averageWeeklyFrequency(l10n));
    _add(insights, _bestPartner(l10n));
    _add(insights, _compareTagRatings('tag_date', 'tag_quickie', l10n));
    return insights;
  }

  Insight? _averageSatisfaction(AppLocalizations l10n) {
    if (data.length < 3) return null;
    final avgRating = data.map((item) => item.rating).average;
    return Insight(
      title: l10n.insightAverageSatisfactionTitle,
      description: l10n.insightAverageSatisfactionDescription(
        avgRating.toStringAsFixed(1),
      ),
      icon: Icons.star_half,
      color: AppColors.warning,
    );
  }

  Insight? _averageWeeklyFrequency(AppLocalizations l10n) {
    if (data.length < 5) return null;
    final sorted = List<Encounter>.from(data)
      ..sort((a, b) => a.date.compareTo(b.date));
    final weeks = (sorted.last.date.difference(sorted.first.date).inDays / 7).clamp(
      1,
      double.infinity,
    );
    final avgFrequency = data.length / weeks;
    return Insight(
      title: l10n.insightWeeklyFrequencyTitle,
      description: l10n.insightWeeklyFrequencyDescription(
        avgFrequency.toStringAsFixed(1),
      ),
      icon: Icons.repeat,
      color: Colors.cyanAccent,
    );
  }

  Insight? _bestPartner(AppLocalizations l10n) {
    if (data.length < 5) return null;
    final encountersByPartner = groupBy(data, (Encounter item) => item.partnerName);
    String? bestPartner;
    var maxAverage = 0.0;
    encountersByPartner.forEach((name, encounters) {
      if (encounters.length < 3) return;
      final average = encounters.map((item) => item.rating).average;
      if (average > maxAverage) {
        maxAverage = average;
        bestPartner = name;
      }
    });
    if (bestPartner == null) return null;
    return Insight(
      title: l10n.insightBestChemistryTitle,
      description: l10n.insightBestChemistryDescription(
        bestPartner!,
        maxAverage.toStringAsFixed(1),
      ),
      icon: Icons.favorite,
      color: Colors.pinkAccent,
    );
  }

  Insight? _compareTagRatings(
    String tagA,
    String tagB,
    AppLocalizations l10n,
  ) {
    final ratingsA = data.where((item) => item.tags.contains(tagA)).map((item) => item.rating).toList();
    final ratingsB = data.where((item) => item.tags.contains(tagB)).map((item) => item.rating).toList();
    if (ratingsA.length < 2 || ratingsB.length < 2) return null;
    final avgA = ratingsA.average;
    final avgB = ratingsB.average;
    final diff = (avgA - avgB) / avgB * 100;
    if (diff.abs() <= 15) return null;
    return Insight(
      title: l10n.insightDatesMatterTitle,
      description: l10n.insightDatesMatterDescription(
        diff.toStringAsFixed(0),
        diff > 0 ? l10n.insightHigher : l10n.insightLower,
        l10n.tagDate,
        l10n.tagQuickie,
      ),
      icon: Icons.favorite,
      color: AppColors.error,
    );
  }

  void _add(List<Insight> insights, Insight? insight) {
    if (insight != null) insights.add(insight);
  }
}
