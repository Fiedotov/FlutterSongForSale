// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';

part 'mix_hive.g.dart';

@HiveType(typeId: 4)
class MixHive extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String thumbnails;

  @HiveField(3)
  late String file;

  @HiveField(4)
  late int duration;

  @HiveField(5)
  late int playtime;

  @HiveField(6)
  late double volume;

  @HiveField(7)
  late double soundA;

  @HiveField(8)
  late double soundB;

  @HiveField(9)
  late double soundC;

  @HiveField(10)
  late double soundD;

  @HiveField(11)
  late double soundE;

  @HiveField(12)
  late double soundF;

  @HiveField(13)
  int index;

  MixHive(
    this.id,
    this.title,
    this.thumbnails,
    this.file,
    this.duration,
    this.playtime,
    this.volume,
    this.soundA,
    this.soundB,
    this.soundC,
    this.soundD,
    this.soundE,
    this.soundF,
    this.index,
  );
}
