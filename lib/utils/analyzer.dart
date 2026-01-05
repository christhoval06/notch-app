import '../models/encounter.dart';
import 'package:intl/intl.dart';

class Analyzer {
  final List<Encounter> data;

  Analyzer(this.data);

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
}
