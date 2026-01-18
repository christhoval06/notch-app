import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:notch_app/models/health_log.dart';
import 'package:notch_app/models/insight.dart';
import 'package:notch_app/utils/translations.dart';

import '../models/encounter.dart';
import 'package:intl/intl.dart';

class Analyzer {
  final List<Encounter> data;
  final List<HealthLog> healthData;

  Analyzer(this.data, this.healthData);

  // 1. DÍA DE LA SEMANA CON MEJOR RATING
  String getBestDayOfWeek() {
    if (data.isEmpty) return "N/A";

    // Mapa para sumar ratings por día: { 'Monday': [9, 8, 10], ... }
    Map<String, List<int>> dayRatings = {};

    for (var e in data) {
      String dayName = DateFormat('EEEE').format(e.date); // 'Monday'
      if (!dayRatings.containsKey(dayName)) dayRatings[dayName] = [];
      dayRatings[dayName]!.add(e.rating);
    }

    // Calcular promedios
    String bestDay = "";
    double bestAvg = 0;

    dayRatings.forEach((day, ratings) {
      double avg = ratings.reduce((a, b) => a + b) / ratings.length;
      if (avg > bestAvg) {
        bestAvg = avg;
        bestDay = day;
      }
    });

    return bestDay; // Retorna ej: "Saturday"
  }

  // 2. PORCENTAJE DE PROTECCIÓN
  String getProtectionStats() {
    if (data.isEmpty) return "0%";
    int protectedCount = data.where((e) => e.protected).length;
    double percentage = (protectedCount / data.length) * 100;
    return "${percentage.toStringAsFixed(1)}%";
  }

  // 3. TAG MÁS FRECUENTE
  String getMostFrequentTag() {
    if (data.isEmpty) return "Ninguno";

    Map<String, int> tagCounts = {};

    for (var e in data) {
      for (var tag in e.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }

    if (tagCounts.isEmpty) return "Ninguno";

    // Ordenar y sacar el top
    var sortedKeys = tagCounts.keys.toList(growable: false)
      ..sort((k1, k2) => tagCounts[k2]!.compareTo(tagCounts[k1]!));

    return sortedKeys.first; // Retorna el tag, ej: "tag_morning"
  }

  // 4. MEJOR PAREJA (Por Rating Promedio)
  Map<String, dynamic> getBestPartner() {
    if (data.isEmpty) return {'name': 'N/A', 'avg': 0.0};

    Map<String, List<int>> partnerRatings = {};

    for (var e in data) {
      if (!partnerRatings.containsKey(e.partnerName))
        partnerRatings[e.partnerName] = [];
      partnerRatings[e.partnerName]!.add(e.rating);
    }

    String bestPartner = "";
    double maxAvg = 0;

    partnerRatings.forEach((name, ratings) {
      // Solo consideramos si hay al menos 2 encuentros para que sea estadísticamente relevante
      if (ratings.length >= 2) {
        double avg = ratings.reduce((a, b) => a + b) / ratings.length;
        if (avg > maxAvg) {
          maxAvg = avg;
          bestPartner = name;
        }
      }
    });

    if (bestPartner.isEmpty) return {'name': 'N/A', 'avg': 0.0};
    return {'name': bestPartner, 'avg': maxAvg};
  }

  Map<DateTime, int> getHeatmapData() {
    final Map<DateTime, int> dataset = {};

    for (var encounter in data) {
      // Usamos una fecha "limpia" (sin hora) como clave
      final dateOnly = DateTime(
        encounter.date.year,
        encounter.date.month,
        encounter.date.day,
      );

      // Incrementamos el contador para esa fecha
      dataset[dateOnly] = (dataset[dateOnly] ?? 0) + 1;
    }

    return dataset;
  }

  Map<String, double> getTagDistribution() {
    if (data.isEmpty) return {};
    final tagCounts = <String, int>{};
    for (var e in data) {
      for (var tag in e.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }
    return tagCounts.map((key, value) => MapEntry(key, value.toDouble()));
  }

  List<Insight> generateInsights() {
    final List<Insight> insights = [];

    // Llama a todas las funciones. Si devuelven un insight, se añade.
    _getAverageSatisfaction()?.let((it) => insights.add(it));
    _getAverageWeeklyFrequency()?.let((it) => insights.add(it));
    _findBestPartner()?.let((it) => insights.add(it));
    _findBestDayOfWeek()?.let((it) => insights.add(it));
    _getMostFrequentTag()?.let((it) => insights.add(it));
    _getProtectionStats()?.let((it) => insights.add(it));
    _compareTagRatings(
      'tag_date',
      'tag_quickie',
    )?.let((it) => insights.add(it));
    _analyzeFrequencyTrend()?.let((it) => insights.add(it));
    _checkQualityStreak()?.let((it) => insights.add(it));
    _checkHealthLog()?.let((it) => insights.add(it));

    return insights;
  }

  Insight? _getAverageSatisfaction() {
    if (data.length < 3) return null;
    final avgRating = data.map((e) => e.rating).average;
    return Insight(
      title: "Satisfacción Promedio",
      description:
          "Tu calificación promedio de todos los encuentros es de ${avgRating.toStringAsFixed(1)} sobre 10.",
      icon: Icons.star_half,
      color: Colors.amber,
    );
  }

  // 2. FRECUENCIA SEMANAL PROMEDIO
  Insight? _getAverageWeeklyFrequency() {
    if (data.length < 5) return null;
    // Calculamos el número de semanas entre el primer y último encuentro
    final sorted = List<Encounter>.from(data)
      ..sort((a, b) => a.date.compareTo(b.date));
    final firstDate = sorted.first.date;
    final lastDate = sorted.last.date;
    final weeks = (lastDate.difference(firstDate).inDays / 7).clamp(
      1,
      double.infinity,
    ); // Evitar división por cero
    final avgFreq = data.length / weeks;

    return Insight(
      title: "Frecuencia Semanal",
      description:
          "En promedio, registras ${avgFreq.toStringAsFixed(1)} encuentros por semana.",
      icon: Icons.repeat,
      color: Colors.cyanAccent,
    );
  }

  // 3. MEJOR QUÍMICA (MEJOR PAREJA)
  Insight? _findBestPartner() {
    if (data.length < 5) return null;

    // Agrupamos encuentros por nombre de pareja
    final encountersByPartner = groupBy(data, (Encounter e) => e.partnerName);

    String? bestPartner;
    double maxAvg = 0;

    encountersByPartner.forEach((name, encounters) {
      // Solo consideramos si hay al menos 3 encuentros para que sea relevante
      if (encounters.length >= 3) {
        final avg = encounters.map((e) => e.rating).average;
        if (avg > maxAvg) {
          maxAvg = avg;
          bestPartner = name;
        }
      }
    });

    if (bestPartner == null) return null;
    return Insight(
      title: "Mejor Química",
      description:
          "Tus encuentros con '$bestPartner' tienen la calificación promedio más alta (${maxAvg.toStringAsFixed(1)}/10).",
      icon: Icons.favorite,
      color: Colors.pinkAccent,
    );
  }

  Insight? _compareTagRatings(String tagA, String tagB) {
    final ratingsA = data
        .where((e) => e.tags.contains(tagA))
        .map((e) => e.rating)
        .toList();
    final ratingsB = data
        .where((e) => e.tags.contains(tagB))
        .map((e) => e.rating)
        .toList();
    if (ratingsA.length < 2 || ratingsB.length < 2) return null;

    final avgA = ratingsA.average;
    final avgB = ratingsB.average;
    final diff = (avgA - avgB) / avgB * 100;

    if (diff.abs() > 15) {
      return Insight(
        title: "Las Citas Importan",
        description:
            "Tu calificación promedio es un ${diff.toStringAsFixed(0)}% ${diff > 0 ? 'más alta' : 'más baja'} en encuentros con la etiqueta 'Cita' en comparación con los 'Rápidos'.",
        icon: Icons.favorite,
        color: Colors.redAccent,
      );
    }
    return null;
  }

  // 2. Tendencia de Frecuencia Mensual
  Insight? _analyzeFrequencyTrend() {
    final now = DateTime.now();
    final currentMonthEncounters = data
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .length;
    final lastMonth = now.subtract(const Duration(days: 30));
    final lastMonthEncounters = data
        .where(
          (e) =>
              e.date.year == lastMonth.year && e.date.month == lastMonth.month,
        )
        .length;
    if (lastMonthEncounters < 2 || currentMonthEncounters < 2) return null;

    final diff =
        (currentMonthEncounters - lastMonthEncounters) /
        lastMonthEncounters *
        100;

    if (diff.abs() > 20) {
      return Insight(
        title: "Cambio de Ritmo",
        description:
            "Tu frecuencia de actividad ha ${diff > 0 ? 'aumentado' : 'disminuido'} un ${diff.abs().toStringAsFixed(0)}% este mes en comparación con el anterior.",
        icon: Icons.trending_up,
        color: diff > 0 ? Colors.greenAccent : Colors.orangeAccent,
      );
    }
    return null;
  }

  // 3. Recordatorio de Salud
  Insight? _checkHealthLog() {
    if (healthData.isEmpty) return null;
    final lastLog = healthData.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
    final monthsSince = DateTime.now().difference(lastLog.date).inDays / 30;

    if (monthsSince >= 6) {
      return Insight(
        title: "Chequeo de Salud Sugerido",
        description:
            "Han pasado más de 6 meses desde tu último registro en el Health Passport. Considera programar uno.",
        icon: Icons.local_hospital,
        color: Colors.blueAccent,
      );
    }
    return null;
  }

  // 4. Racha de Alta Calidad
  Insight? _checkQualityStreak() {
    int streak = 0;
    final sortedData = List<Encounter>.from(data)
      ..sort((a, b) => b.date.compareTo(a.date));
    for (var e in sortedData) {
      if (e.rating >= 8) {
        streak++;
      } else {
        break;
      }
    }
    if (streak >= 3) {
      return Insight(
        title: "¡En la Zona!",
        description:
            "Estás en una racha de $streak encuentros seguidos con calificación 'Buena' o 'Legendaria' (8+). ¡Sigue así!",
        icon: Icons.military_tech,
        color: Colors.amberAccent,
      );
    }
    return null;
  }

  // 5. Día de la Semana con Mejor Rating
  Insight? _findBestDayOfWeek() {
    if (data.length < 5) return null;
    Map<int, List<int>> dayRatings = {};
    for (var e in data) {
      dayRatings.putIfAbsent(e.date.weekday, () => []).add(e.rating);
    }
    int bestDay = 0;
    double bestAvg = 0;
    dayRatings.forEach((day, ratings) {
      if (ratings.length < 2) return;
      double avg = ratings.average;
      if (avg > bestAvg) {
        bestAvg = avg;
        bestDay = day;
      }
    });
    if (bestDay == 0) return null;

    final dayNames = [
      "",
      "Lunes",
      "Martes",
      "Miércoles",
      "Jueves",
      "Viernes",
      "Sábado",
      "Domingo",
    ];
    return Insight(
      title: "Tu Día Dorado",
      description:
          "Tus encuentros de los ${dayNames[bestDay]} suelen tener la calificación promedio más alta (${bestAvg.toStringAsFixed(1)}/10).",
      icon: Icons.calendar_today,
      color: Colors.orangeAccent,
    );
  }

  // 6. Tasa de Uso de Protección
  Insight? _getProtectionStats() {
    if (data.length < 3) return null;
    int protectedCount = data.where((e) => e.protected).length;
    double percentage = (protectedCount / data.length) * 100;
    return Insight(
      title: "Estadística de Protección",
      description:
          "Has usado protección en un ${percentage.toStringAsFixed(0)}% de tus encuentros registrados.",
      icon: Icons.security,
      color: Colors.greenAccent,
    );
  }

  // 7. Tag Más Frecuente
  Insight? _getMostFrequentTag() {
    final tagCounts = <String, int>{};
    for (var e in data) {
      for (var tag in e.tags) {
        tagCounts[tag] = (tagCounts[tag] ?? 0) + 1;
      }
    }
    if (tagCounts.isEmpty) return null;

    final sortedTags = tagCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final mostFrequentTag = sortedTags.first.key;

    return Insight(
      title: "Tu Estilo Predominante",
      description:
          "Tu etiqueta más frecuente es '${AppStrings.get(mostFrequentTag, lang: currentLang)}'. Parece que es una parte importante de tu rutina.",
      icon: Icons.local_offer,
      color: Colors.purpleAccent,
    );
  }
}

extension Let<T> on T {
  R let<R>(R Function(T) block) => block(this);
}
