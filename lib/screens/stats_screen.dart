import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/screens/insights_screen.dart';
import '../models/encounter.dart';
import '../utils/translations.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtenemos la caja de datos
    final box = Hive.box<Encounter>('encounters');
    final encounters = box.values.toList();

    // Si no hay datos, mostramos mensaje
    if (encounters.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF121212),
        body: Center(
          child: Text(
            "No data yet / Sin datos",
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    // --- CÁLCULOS ESTADÍSTICOS ---
    final totalEncounters = encounters.length;
    final totalOrgasms = encounters.fold(
      0,
      (sum, item) => sum + item.orgasmCount,
    );
    final avgRating =
        encounters.fold(0, (sum, item) => sum + item.rating) / totalEncounters;

    // Datos para el gráfico (Últimos 6 meses)
    final monthlyData = _getMonthlyData(encounters);

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TARJETAS DE RESUMEN (SCOREBOARD)
            Row(
              children: [
                _buildStatCard(
                  "Total",
                  "$totalEncounters",
                  Icons.flag,
                  Colors.blueAccent,
                ),
                const SizedBox(width: 10),
                _buildStatCard(
                  "Orgasms",
                  "$totalOrgasms",
                  Icons.bolt,
                  Colors.orangeAccent,
                ),
                const SizedBox(width: 10),
                _buildStatCard(
                  "Avg Rating",
                  avgRating.toStringAsFixed(1),
                  Icons.star,
                  Colors.purpleAccent,
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 2. GRÁFICO DE BARRAS (ACTIVIDAD MENSUAL)
            Text(
              "Activity (Last 6 Months)",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 250,
              padding: EdgeInsets.only(right: 20), // Espacio para etiquetas
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: _getMaxY(monthlyData), // Escala dinámica
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) => Colors.blueGrey,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          // Convertir índice 0-5 a nombre del mes
                          final index = value.toInt();
                          if (index >= 0 && index < monthlyData.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                monthlyData[index]['label'] as String,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          }
                          return Text('');
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: false,
                  ), // Sin cuadrícula para look limpio
                  borderData: FlBorderData(show: false),
                  barGroups: _generateBarGroups(monthlyData),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 3. DESGLOSE DE CALIDAD (Rating Breakdown)
            Text(
              "Quality Breakdown",
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildQualityRow(
              "Legendary (9-10)",
              _countRatings(encounters, 9, 10),
              Colors.purpleAccent,
              totalEncounters,
            ),
            _buildQualityRow(
              "Good (7-8)",
              _countRatings(encounters, 7, 8),
              Colors.greenAccent,
              totalEncounters,
            ),
            _buildQualityRow(
              "Average (5-6)",
              _countRatings(encounters, 5, 6),
              Colors.blueAccent,
              totalEncounters,
            ),
            _buildQualityRow(
              "Bad (1-4)",
              _countRatings(encounters, 1, 4),
              Colors.redAccent,
              totalEncounters,
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[900]!),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityRow(String label, int count, Color color, int total) {
    double percentage = total == 0 ? 0 : count / total;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(color: Colors.white70)),
              Text(
                "$count (${(percentage * 100).toStringAsFixed(0)}%)",
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[900],
              color: color,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  // --- LÓGICA DE DATOS ---

  // Cuenta cuántos encuentros caen en un rango de calificación
  int _countRatings(List<Encounter> list, int min, int max) {
    return list.where((e) => e.rating >= min && e.rating <= max).length;
  }

  // Prepara los datos para los últimos 6 meses
  List<Map<String, dynamic>> _getMonthlyData(List<Encounter> list) {
    List<Map<String, dynamic>> data = [];
    DateTime now = DateTime.now();

    // Iteramos los últimos 6 meses (de atrás hacia adelante o viceversa)
    for (int i = 5; i >= 0; i--) {
      DateTime month = DateTime(now.year, now.month - i, 1);

      // Filtramos cuántos ocurrieron en este mes y año
      int count = list
          .where(
            (e) => e.date.year == month.year && e.date.month == month.month,
          )
          .length;

      data.add({
        'label': DateFormat('MMM').format(month), // Ej: "Jan"
        'value': count,
      });
    }
    return data;
  }

  double _getMaxY(List<Map<String, dynamic>> data) {
    int max = 0;
    for (var item in data) {
      if ((item['value'] as int) > max) max = item['value'] as int;
    }
    return (max + 2).toDouble(); // Un poco de margen arriba
  }

  List<BarChartGroupData> _generateBarGroups(List<Map<String, dynamic>> data) {
    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (data[index]['value'] as int).toDouble(),
            color: Colors.blueAccent,
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: _getMaxY(data), // Fondo gris hasta el tope
              color: Colors.grey[900],
            ),
          ),
        ],
      );
    });
  }
}
