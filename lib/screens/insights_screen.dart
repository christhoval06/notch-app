import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/encounter.dart';
import '../utils/analyzer.dart';
import '../utils/translations.dart'; // Para traducir el tag y día si quieres

class InsightsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Encounter>('encounters');
    final encounters = box.values.toList();
    final analyzer = Analyzer(encounters);

    // Si hay pocos datos, mostrar mensaje
    if (encounters.length < 3) {
      return Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Insights 🧠"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              "Necesitas al menos 3 registros para generar inteligencia de datos.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Insights 🧠"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            "PATRONES DETECTADOS",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 20),

          // TARJETA 1: DÍA DE ORO
          _buildInsightCard(
            icon: Icons.calendar_today,
            color: Colors.orangeAccent,
            title: "Tu Mejor Día",
            value: analyzer.getBestDayOfWeek(),
            desc:
                "Los encuentros en este día tienen el promedio de calificación más alto.",
          ),

          // TARJETA 2: SEGURIDAD
          _buildInsightCard(
            icon: Icons.security,
            color: Colors.greenAccent,
            title: "Tasa de Protección",
            value: analyzer.getProtectionStats(),
            desc: "Porcentaje de veces que usaste protección en tus registros.",
          ),

          // TARJETA 3: TAG FAVORITO
          _buildInsightCard(
            icon: Icons.local_offer,
            color: Colors.purpleAccent,
            title: "Lo que más te gusta",
            // Aquí usamos AppStrings para traducir el tag (ej. tag_morning -> Mañanero)
            value: AppStrings.get(
              analyzer.getMostFrequentTag(),
              lang: currentLang,
            ),
            desc: "Es la etiqueta que más se repite en tus encuentros.",
          ),

          // TARJETA 4: MEJOR QUÍMICA (Pareja)
          Builder(
            builder: (_) {
              final best = analyzer.getBestPartner();
              return _buildInsightCard(
                icon: Icons.favorite,
                color: Colors.redAccent,
                title: "Mejor Química",
                value: best['name'],
                desc:
                    "Promedio de ${best['avg'].toStringAsFixed(1)}/10. (Mín. 2 encuentros)",
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
    required String desc,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ), // Borde lateral de color
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.grey[400], fontSize: 14),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(desc, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }
}
