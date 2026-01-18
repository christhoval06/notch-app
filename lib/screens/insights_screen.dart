import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notch_app/models/health_log.dart';
import 'package:notch_app/models/insight.dart';
import '../models/encounter.dart';
import '../utils/analyzer.dart';
import '../utils/translations.dart';

class InsightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final encounters = Hive.box<Encounter>('encounters').values.toList();
    final healthLogs = Hive.box<HealthLog>('health_logs').values.toList();

    final analyzer = Analyzer(encounters, healthLogs);

    final insights = analyzer.generateInsights();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Inteligencia de Datos 🧠"),
      ),
      body: insights.isEmpty
          ? const Center(
              child: Text(
                "Aún no hay suficientes datos para generar insights.\n¡Sigue registrando!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: insights.length,
              itemBuilder: (context, index) {
                return _buildInsightCard(insights[index]);
              },
            ),
    );
  }

  Widget _buildInsightCard(Insight insight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
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
                  style: const TextStyle(
                    color: Colors.white,
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
              color: Colors.grey[300],
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
