// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playtime_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayTimeHiveAdapter extends TypeAdapter<PlayTimeHive> {
  @override
  final int typeId = 2;

  @override
  PlayTimeHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayTimeHive(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PlayTimeHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.playtime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayTimeHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
