// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FakeTaskAdapter extends TypeAdapter<FakeTask> {
  @override
  final int typeId = 5;

  @override
  FakeTask read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FakeTask(
      id: fields[0] as String,
      title: fields[1] as String,
      isDone: fields[2] as bool,
      createdAt: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, FakeTask obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isDone)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FakeTaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
