// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlyProgressAdapter extends TypeAdapter<MonthlyProgress> {
  @override
  final int typeId = 4;

  @override
  MonthlyProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlyProgress(
      monthId: fields[0] as String,
      xp: fields[1] as int,
      unlockedBadges: (fields[2] as List).cast<String>(),
      finalRank: fields[3] as String?,
      longestStreakOfMonth: fields[4] == null ? 0 : fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, MonthlyProgress obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.monthId)
      ..writeByte(1)
      ..write(obj.xp)
      ..writeByte(2)
      ..write(obj.unlockedBadges)
      ..writeByte(3)
      ..write(obj.finalRank)
      ..writeByte(4)
      ..write(obj.longestStreakOfMonth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
