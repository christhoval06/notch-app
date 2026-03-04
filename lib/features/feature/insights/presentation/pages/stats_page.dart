import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notch_app/core/theme/app_colors.dart';
import 'package:notch_app/l10n/app_localizations.dart';
import 'package:notch_app/core/utils/analyzer.dart';
import 'package:notch_app/core/utils/level_localization.dart';
import 'package:notch_app/core/utils/translations.dart';

import 'package:notch_app/core/utils/gamification_engine.dart';
import 'package:notch_app/data/models/monthly_progress.dart';

import 'package:notch_app/data/models/encounter.dart';

enum StatPeriod { month, sixMonths, allTime }

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  StatPeriod _selectedPeriod = StatPeriod.sixMonths;

  Map<String, dynamic> _getHighestRankData() {
    final progressBox = Hive.box<MonthlyProgress>('monthly_progress');
    if (progressBox.isEmpty) {
      // Si no hay datos, devolvemos el primer nivel como default
      return GamificationEngine.getCurrentLevel(0);
    }

    int maxXP = 0;
    for (var progress in progressBox.values) {
      if (progress.xp > maxXP) {
        maxXP = progress.xp;
      }
    }

    return GamificationEngine.getCurrentLevel(maxXP);
  }

  Widget _buildHighestRankPanel(
    Map<String, dynamic> levelData,
    AppLocalizations l10n,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final rawLevelName = levelData['name'] as String;
    final levelName = localizeLevelName(l10n, rawLevelName);
    final levelDescription = localizeLevelDescription(l10n, rawLevelName);

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.warning, AppColors.warning],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.statsHighestRankReached,
            textAlign: TextAlign.center,
            style: TextStyle(letterSpacing: 2, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Text(
            levelName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            l10n.statsXpTotal(levelData['current_total_xp'].toString()),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 15),
          Text(
            levelDescription,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    // Obtenemos la caja de datos
    final box = Hive.box<Encounter>('encounters');
    List<Encounter> encounters = box.values.toList();

    final now = DateTime.now();
    if (_selectedPeriod == StatPeriod.month) {
      encounters = encounters
          .where((e) => e.date.isAfter(now.subtract(const Duration(days: 30))))
          .toList();
    } else if (_selectedPeriod == StatPeriod.sixMonths) {
      encounters = encounters
          .where((e) => e.date.isAfter(now.subtract(const Duration(days: 180))))
          .toList();
    }

    final analyzer = Analyzer(encounters, []);

    // Si no hay datos, mostramos mensaje
    if (encounters.isEmpty) {
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Center(
          child: Text(
            l10n.statsNoData,
            style: TextStyle(color: scheme.onSurfaceVariant),
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

    final heatmapData = analyzer.getHeatmapData();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ToggleButtons(
                isSelected: [
                  _selectedPeriod == StatPeriod.month,
                  _selectedPeriod == StatPeriod.sixMonths,
                  _selectedPeriod == StatPeriod.allTime,
                ],
                onPressed: (index) {
                  setState(() {
                    _selectedPeriod = StatPeriod.values[index];
                  });
                },
                borderRadius: BorderRadius.circular(8),
                fillColor: scheme.primary.withValues(alpha: 0.3),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(l10n.statsPeriod30Days),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(l10n.statsPeriod6Months),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text(l10n.statsPeriodTotal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- MAYOR RANGO ALCANZADO ---
            _buildHighestRankPanel(_getHighestRankData(), l10n),

            const SizedBox(height: 30),
            // 1. TARJETAS DE RESUMEN (SCOREBOARD)
            Row(
              children: [
                _buildStatCard(
                  l10n.statsTotal,
                  "$totalEncounters",
                  Icons.flag,
                  scheme.primary,
                ),
                const SizedBox(width: 10),
                _buildStatCard(
                  l10n.orgasms,
                  "$totalOrgasms",
                  Icons.bolt,
                  scheme.tertiary,
                ),
                const SizedBox(width: 10),
                _buildStatCard(
                  l10n.statsAvgRating,
                  avgRating.toStringAsFixed(1),
                  Icons.star,
                  scheme.secondary,
                ),
              ],
            ),
            const SizedBox(height: 10),

            Text(
              l10n.statsActivityDistribution,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 200,
              child: _buildPieChart(analyzer.getTagDistribution()),
            ),

            const SizedBox(height: 40),

            // 2. GRÁFICO DE BARRAS (ACTIVIDAD MENSUAL)
            Text(
              l10n.statsActivityLast6Months,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
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
                      getTooltipColor: (_) => scheme.surfaceContainerHighest,
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
                                  color: scheme.onSurfaceVariant,
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

            // --- 3. NUEVO: HEATMAP CALENDAR ---
            Text(
              l10n.statsAnnualActivityMap,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(15),
              ),
              child: HeatMap(
                datasets: heatmapData,
                // endDate: DateTime.now(), // Por defecto muestra el último año
                fontSize: 10,
                // Colores personalizados para el Dark Mode
                textColor: scheme.onSurface,
                colorMode: ColorMode.opacity,
                showColorTip: false, // Más limpio
                scrollable: true,
                colorsets: {
                  1: scheme.primary, // Color base para la intensidad
                },
                onClick: (date) {
                  // Opcional: Mostrar un SnackBar o diálogo con la info de ese día
                  final count = heatmapData[date] ?? 0;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        l10n.statsHeatmapSnackBar(
                          DateFormat('d MMM y').format(date),
                          count.toString(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            // 3. DESGLOSE DE CALIDAD (Rating Breakdown)
            Text(
              l10n.statsQualityBreakdown,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildQualityRow(
              l10n.statsLegendary,
              _countRatings(encounters, 9, 10),
              scheme.secondary,
              totalEncounters,
            ),
            _buildQualityRow(
              l10n.statsGood,
              _countRatings(encounters, 7, 8),
              scheme.tertiary,
              totalEncounters,
            ),
            _buildQualityRow(
              l10n.statsAverage,
              _countRatings(encounters, 5, 6),
              scheme.primary,
              totalEncounters,
            ),
            _buildQualityRow(
              l10n.statsBad,
              _countRatings(encounters, 1, 4),
              scheme.error,
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
    final scheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: scheme.surface,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 10),
            Text(
              value,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQualityRow(String label, int count, Color color, int total) {
    final scheme = Theme.of(context).colorScheme;
    double percentage = total == 0 ? 0 : count / total;
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(color: scheme.onSurfaceVariant)),
              Text(
                "$count (${(percentage * 100).toStringAsFixed(0)}%)",
                style: TextStyle(color: scheme.onSurface),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: scheme.surface,
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
            color: Theme.of(context).colorScheme.primary,
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: _getMaxY(data), // Fondo gris hasta el tope
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPieChart(Map<String, double> data) {
    if (data.isEmpty)
      return Center(
        child: Text(
          AppLocalizations.of(context).statsNoTagData,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      );

    final scheme = Theme.of(context).colorScheme;
    final colors = [
      scheme.primary,
      scheme.secondary,
      scheme.tertiary,
      scheme.primaryContainer,
      scheme.error,
    ];
    int colorIndex = 0;

    return PieChart(
      PieChartData(
        sections: data.entries.map((entry) {
          final color = colors[colorIndex % colors.length];
          colorIndex++;
          return PieChartSectionData(
            color: color,
            value: entry.value,
            title: tagLabelFromLanguageCode(entry.key, currentLang),
            radius: 80,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: scheme.onPrimary,
              shadows: [Shadow(color: scheme.scrim, blurRadius: 2)],
            ),
          );
        }).toList(),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
      ),
    );
  }
}
