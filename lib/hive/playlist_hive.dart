import 'package:hive/hive.dart';

part 'playlist_hive.g.dart';

@HiveType(typeId: 3)
class PlayListHive extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late int playtime;

  @HiveField(3)
  late List<int> musics;

  PlayListHive(this.id, this.title, this.playtime, this.musics);
}
