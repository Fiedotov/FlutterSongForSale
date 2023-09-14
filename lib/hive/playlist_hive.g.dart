// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListHiveAdapter extends TypeAdapter<PlayListHive> {
  @override
  final int typeId = 3;

  @override
  PlayListHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListHive(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
      (fields[3] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayListHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.playtime)
      ..writeByte(3)
      ..write(obj.musics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
