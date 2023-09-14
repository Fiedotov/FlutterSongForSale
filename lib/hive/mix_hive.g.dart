// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mix_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MixHiveAdapter extends TypeAdapter<MixHive> {
  @override
  final int typeId = 4;

  @override
  MixHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MixHive(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as int,
      fields[6] as double,
      fields[7] as double,
      fields[8] as double,
      fields[9] as double,
      fields[10] as double,
      fields[11] as double,
      fields[12] as double,
      fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MixHive obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.thumbnails)
      ..writeByte(3)
      ..write(obj.file)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.playtime)
      ..writeByte(6)
      ..write(obj.volume)
      ..writeByte(7)
      ..write(obj.soundA)
      ..writeByte(8)
      ..write(obj.soundB)
      ..writeByte(9)
      ..write(obj.soundC)
      ..writeByte(10)
      ..write(obj.soundD)
      ..writeByte(11)
      ..write(obj.soundE)
      ..writeByte(12)
      ..write(obj.soundF)
      ..writeByte(13)
      ..write(obj.index);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MixHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
