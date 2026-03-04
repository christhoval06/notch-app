import 'package:flutter/material.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/data/models/health_log.dart';
import 'package:notch_app/data/models/insight.dart';
import 'package:notch_app/data/models/encounter.dart';
import 'package:notch_app/core/utils/analyzer.dart';

class InsightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    final encounters = Hive.box<Encounter>('encounters').values.toList();
    final healthLogs = Hive.box<HealthLog>('health_logs').values.toList();

    final analyzer = Analyzer(encounters, healthLogs);

    final insights = analyzer.generateInsights(l10n);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("${l10n.insightsTitle} 🧠"),
      ),
      body: insights.isEmpty
          ? Center(
              child: Text(
                l10n.insightsEmpty,
                textAlign: TextAlign.center,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: insights.length,
              itemBuilder: (context, index) {
                return _buildInsightCard(context, insights[index]);
              },
            ),
    );
  }

  Widget _buildInsightCard(BuildContext context, Insight insight) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(15),
        border: Border(left: BorderSide(color: insight.color, width: 5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(insight.icon, color: insight.color, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  insight.title,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            insight.description,
            style: TextStyle(
              color: scheme.onSurfaceVariant,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
