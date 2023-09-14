import 'package:hive/hive.dart';

part 'playtime_hive.g.dart';

@HiveType(typeId: 2)
class PlayTimeHive extends HiveObject {
  @HiveField(0)
  late String date;
  @HiveField(1)
  late int playtime;

  PlayTimeHive(this.date, this.playtime);
}
