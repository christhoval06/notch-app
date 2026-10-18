import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/data/models/insight.dart';
import 'package:notch_app/l10n/app_localizations.dart';

class AnalyzerPartnerInsights {
  AnalyzerPartnerInsights(this.data);

  final List<Encounter> data;

  List<Insight> build(AppLocalizations l10n) {
    final insights = <Insight>[];
    _add(insights, _mostConsistentPartner(l10n));
    _add(insights, _mostUnpredictablePartner(l10n));
    _add(insights, _bestRecentPartnerTrend(l10n));
    _add(insights, _recentChemistry(l10n));
    return insights;
  }

  Insight? _mostConsistentPartner(AppLocalizations l10n) {
    final entries = _partnerSpreadEntries()..sort((a, b) => a.spread.compareTo(b.spread));
    if (entries.isEmpty) return null;
    final best = entries.first;
    return Insight(
      title: l10n.insightMostConsistentPartnerTitle,
      description: l10n.insightMostConsistentPartnerDescription(
        best.name,
        best.average.toStringAsFixed(1),
      ),
      icon: Icons.favorite_border,
      color: Colors.tealAccent,
    );
  }

  Insight? _mostUnpredictablePartner(AppLocalizations l10n) {
    final entries = _partnerSpreadEntries()..sort((a, b) => b.spread.compareTo(a.spread));
    if (entries.isEmpty || entries.first.spread < 1.5) return null;
    final wildest = entries.first;
    return Insight(
      title: l10n.insightMostUnpredictablePartnerTitle,
      description: l10n.insightMostUnpredictablePartnerDescription(
        wildest.name,
        wildest.spread.toStringAsFixed(1),
      ),
      icon: Icons.casino_outlined,
      color: Colors.orangeAccent,
    );
  }

  Insight? _bestRecentPartnerTrend(AppLocalizations l10n) {
    _TrendEntry? best;
    for (final entry in groupBy(data, (Encounter item) => item.partnerName).entries) {
      if (entry.value.length < 4) continue;
      final sorted = [...entry.value]..sort((a, b) => a.date.compareTo(b.date));
      final recent = sorted.sublist(sorted.length - 2);
      final previous = sorted.sublist(0, sorted.length - 2);
      final diff = recent.map((item) => item.rating).average -
          previous.map((item) => item.rating).average;
      if (diff <= 0) continue;
      if (best == null || diff > best.improvement) {
        best = _TrendEntry(entry.key, diff);
      }
    }
    if (best == null) return null;
    return Insight(
      title: l10n.insightBestRecentPartnerTrendTitle,
      description: l10n.insightBestRecentPartnerTrendDescription(
        best.name,
        best.improvement.toStringAsFixed(0),
      ),
      icon: Icons.trending_up,
      color: Colors.lightGreenAccent,
    );
  }

  Insight? _recentChemistry(AppLocalizations l10n) {
    final threshold = DateTime.now().subtract(const Duration(days: 120));
    String? bestPartner;
    var bestAverage = 0.0;
    for (final entry in groupBy(data, (Encounter item) => item.partnerName).entries) {
      final recent = entry.value.where((item) => item.date.isAfter(threshold)).toList();
      if (recent.length < 2) continue;
      final average = recent.map((item) => item.rating).average;
      if (average > bestAverage) {
        bestAverage = average;
        bestPartner = entry.key;
      }
    }
    if (bestPartner == null) return null;
    return Insight(
      title: l10n.insightRecentChemistryTitle,
      description: l10n.insightRecentChemistryDescription(
        bestPartner,
        bestAverage.toStringAsFixed(1),
      ),
      icon: Icons.local_fire_department,
      color: Colors.redAccent,
    );
  }

  List<_SpreadEntry> _partnerSpreadEntries() {
    return groupBy(data, (Encounter item) => item.partnerName).entries
        .where((entry) => entry.value.length >= 3)
        .map((entry) {
          final ratings = entry.value.map((item) => item.rating.toDouble()).toList();
          final average = ratings.average;
          final spread = ratings.map((item) => (item - average).abs()).average;
          return _SpreadEntry(entry.key, average, spread);
        }).toList();
  }

  void _add(List<Insight> insights, Insight? insight) {
    if (insight != null) insights.add(insight);
  }
}

class _SpreadEntry {
  const _SpreadEntry(this.name, this.average, this.spread);

  final String name;
  final double average;
  final double spread;
}

class _TrendEntry {
  const _TrendEntry(this.name, this.improvement);

  final String name;
  final double improvement;
}
