// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_progress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GlobalProgressAdapter extends TypeAdapter<GlobalProgress> {
  @override
  final int typeId = 7;

  @override
  GlobalProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GlobalProgress(
      unlockedOnceAchievements: (fields[0] as List).cast<String>(),
      claimedHistoricalChallengeRewardIds:
          (fields[1] as List?)?.cast<String>() ?? const [],
    );
  }

  @override
  void write(BinaryWriter writer, GlobalProgress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.unlockedOnceAchievements)
      ..writeByte(1)
      ..write(obj.claimedHistoricalChallengeRewardIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
