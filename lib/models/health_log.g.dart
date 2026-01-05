// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_log.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthLogAdapter extends TypeAdapter<HealthLog> {
  @override
  final int typeId = 3;

  @override
  HealthLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthLog(
      date: fields[0] as DateTime,
      testType: fields[1] as String,
      result: fields[2] as String,
      notes: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, HealthLog obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.testType)
      ..writeByte(2)
      ..write(obj.result)
      ..writeByte(3)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
