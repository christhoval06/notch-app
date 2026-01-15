import 'package:hive/hive.dart';

part 'partner.g.dart';

enum AvatarType { initial, image, emoji }

@HiveType(typeId: 6)
class AvatarTypeAdapter extends TypeAdapter<AvatarType> {
  @override
  final int typeId = 6;

  @override
  AvatarType read(BinaryReader reader) {
    return AvatarType.values[reader.readByte()];
  }

  @override
  void write(BinaryWriter writer, AvatarType obj) {
    writer.writeByte(obj.index);
  }
}

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

  // Contenido del avatar:
  // - Si es 'initial', esto es un color (ej. "0xFFF44336")
  // - Si es 'image', esto es la ruta del archivo
  // - Si es 'emoji', esto es el emoji (ej. "😈")
  @HiveField(5, defaultValue: '')
  String avatarContent;

  // Tipo de avatar
  @HiveField(6, defaultValue: AvatarType.initial)
  AvatarType avatarType;

  Partner({
    required this.id,
    required this.name,
    this.notes,
    this.phoneNumber,
    this.rating,
    required this.avatarContent,
    this.avatarType = AvatarType.initial,
  });
}
