import 'package:hive/hive.dart';

part 'encounter.g.dart';

@HiveType(typeId: 0)
class Encounter extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String partnerName;

  @HiveField(3)
  final int orgasmCount;

  @HiveField(4)
  final int rating;

  @HiveField(5)
  final String? notes;

  @HiveField(6)
  final List<String> tags;

  @HiveField(7)
  final String? moodEmoji;

  @HiveField(8, defaultValue: true)
  final bool protected;

  Encounter({
    required this.id,
    required this.date,
    required this.partnerName,
    required this.orgasmCount,
    required this.rating,
    this.notes,
    this.tags = const [],
    this.moodEmoji,
    this.protected = true,
  });
}
