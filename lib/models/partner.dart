import 'package:hive/hive.dart';

part 'partner.g.dart';

@HiveType(typeId: 1)
class Partner extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name; // Este será el campo de enlace

  @HiveField(2)
  String? notes; // "Le gusta el vino", "Cumpleaños 12 mayo"

  @HiveField(3)
  String? phoneNumber; // Opcional

  @HiveField(4)
  int? rating; // Calificación general (o promedio calculado)

  Partner({
    required this.id,
    required this.name,
    this.notes,
    this.phoneNumber,
    this.rating,
  });
}
