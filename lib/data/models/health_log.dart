import 'package:hive/hive.dart';

part 'health_log.g.dart';

@HiveType(typeId: 3)
class HealthLog extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final String testType; // Ej: "Panel Completo", "VIH", "Sifilis"

  @HiveField(2)
  final String result; // "Negativo", "Positivo", "Pendiente"

  @HiveField(3)
  final String? notes;

  HealthLog({
    required this.date,
    required this.testType,
    required this.result,
    this.notes,
  });
}
