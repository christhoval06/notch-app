// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AvatarTypeAdapterAdapter extends TypeAdapter<AvatarTypeAdapter> {
  @override
  final int typeId = 6;

  @override
  AvatarTypeAdapter read(BinaryReader reader) {
    return AvatarTypeAdapter();
  }

  @override
  void write(BinaryWriter writer, AvatarTypeAdapter obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AvatarTypeAdapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PartnerAdapter extends TypeAdapter<Partner> {
  @override
  final int typeId = 1;

  @override
  Partner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Partner(
      id: fields[0] as String,
      name: fields[1] as String,
      notes: fields[2] as String?,
      phoneNumber: fields[3] as String?,
      rating: fields[4] as int?,
      avatarContent: fields[5] == null ? '' : fields[5] as String,
      avatarType:
          fields[6] == null ? AvatarType.initial : fields[6] as AvatarType,
    );
  }

  @override
  void write(BinaryWriter writer, Partner obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.notes)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.avatarContent)
      ..writeByte(6)
      ..write(obj.avatarType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PartnerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
