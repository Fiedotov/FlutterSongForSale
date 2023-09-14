import 'package:hive/hive.dart';

part 'sleep_time_hive.g.dart';

@HiveType(typeId: 1)
class SleepTimeHive extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late int minutes;

  SleepTimeHive(this.id, this.minutes);
}
