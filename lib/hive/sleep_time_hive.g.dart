// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_time_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SleepTimeHiveAdapter extends TypeAdapter<SleepTimeHive> {
  @override
  final int typeId = 1;

  @override
  SleepTimeHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SleepTimeHive(
      fields[0] as int,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SleepTimeHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.minutes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepTimeHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
