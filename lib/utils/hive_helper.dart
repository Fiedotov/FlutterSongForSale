import 'package:collection/collection.dart';
import 'package:Effexxion/hive/mix_hive.dart';
import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/hive/playtime_hive.dart';
import 'package:Effexxion/hive/sleep_time_hive.dart';
import 'package:Effexxion/main.dart';
import 'package:Effexxion/utils/helper.dart';

class HiveHelper {
  // --------------sleeptime box---------------------------
  static List<SleepTimeHive> getSleepTimes() {
    List<dynamic> data = sleepTimeBox.values.toList();
    List<SleepTimeHive> result = [];
    data.map((e) {
      if (e.runtimeType == SleepTimeHive) {
        result.add(e);
      }
    }).toList();
    return result;
  }

  static deleteSleepTimeById(int id) {
    int index = sleepTimeBox.values.toList().indexWhere((element) => element.id == id);
    if (index != -1) {
      sleepTimeBox.deleteAt(index);
    }
  }

  // --------------playtime box---------------------------
  static addPlayTime(int milleSeconds, int playlistID, int mixId) {
    if (milleSeconds == 0) return;
    String date = Helper.formatDate(DateTime.now());
    int index = playTimeBox.values.toList().indexWhere((element) => element.date == date);
    int seconds = (milleSeconds / 1000).round();
    if (index != -1) {
      // update record
      PlayTimeHive hive = playTimeBox.getAt(index);
      hive.playtime += seconds;
      playTimeBox.putAt(index, hive);
    } else {
      // add new record
      PlayTimeHive newHive = PlayTimeHive(date, seconds);
      playTimeBox.add(newHive);
    }
    if (playlistID != -1) {
      int playIndex = playlistBox.values.toList().indexWhere((element) => element.id == playlistID);
      if (playIndex != -1) {
        PlayListHive playListHive = playlistBox.getAt(playIndex);
        playListHive.playtime += seconds;
        playlistBox.putAt(playIndex, playListHive);
        if (mixId != -1) {
          int mixIndex = mixBox.values.toList().indexWhere((element) => element.id == mixId);
          if (mixIndex != -1) {
            MixHive mixHive = mixBox.getAt(mixIndex);
            mixHive.playtime += seconds;
            mixBox.putAt(mixIndex, mixHive);
          }
        }
      }
    }
  }

  static String getTotalPlayTime() {
    List<dynamic> data = playTimeBox.values.toList();
    int allSeconds = 0;
    List<PlayTimeHive> result = [];
    data.map((e) {
      if (e.runtimeType == PlayTimeHive) {
        result.add(e);
      }
    }).toList();

    result.map((element) {
      allSeconds += element.playtime;
    }).toList();
    return Helper.convertPlayTimeFromDuration(allSeconds);
  }

  static String getTodayPlayTime() {
    String today = Helper.formatDate(DateTime.now());
    PlayTimeHive? todayHive = playTimeBox.values.firstWhereOrNull((element) => element.date == today);
    if (todayHive != null) {
      return Helper.convertPlayTimeFromDuration(todayHive.playtime);
    }
    return "00:00:00";
  }

  static String getYesterdayPlayTime() {
    String yesterday = Helper.formatDate(DateTime.now().subtract(const Duration(days: 1)));
    PlayTimeHive? yesterdayHive = playTimeBox.values.firstWhereOrNull((element) => element.date == yesterday);
    if (yesterdayHive != null) {
      return Helper.convertPlayTimeFromDuration(yesterdayHive.playtime);
    }
    return "00:00:00";
  }

  static void clearPlayTime() {
    playTimeBox.clear();
  }

  //--------------mix box--------------------

  static int getMixCount() {
    return mixBox.length;
  }

  static MixHive? getMostMix() {
    List<dynamic> data = mixBox.values.toList();
    List<MixHive> result = [];
    data.map((e) {
      if (e.runtimeType == MixHive) {
        result.add(e);
      }
    }).toList();
    if (result.isEmpty) return null;
    result.sort((a, b) => b.playtime.compareTo(a.playtime));
    return result[0];
  }

  static Future<int> addNewMix(
    MixHive music,
    String title,
    double volume,
    double soundA,
    double soundB,
    double soundC,
    double soundD,
    double soundE,
    double soundF,
  ) async {
    int id = DateTime.now().millisecondsSinceEpoch;
    MixHive newMix = MixHive(
      id,
      title,
      music.thumbnails,
      music.file,
      music.duration,
      0,
      volume,
      soundA,
      soundB,
      soundC,
      soundD,
      soundE,
      soundF,
      music.index,
    );
    await mixBox.add(newMix);
    return id;
  }

  static MixHive? getMixById(int id) {
    MixHive? result = mixBox.values.firstWhereOrNull((element) => element.id == id);
    return result;
  }

  static List<MixHive> getMixList(List<int> ids) {
    List<MixHive> mixList = [];
    List<MixHive> result = [];
    List<dynamic> data = mixBox.values.where((element) => ids.contains(element.id)).toList();
    data.map((e) {
      if (e.runtimeType == MixHive) {
        mixList.add(e);
      }
    }).toList();
    ids.map((e) {
      int index = mixList.indexWhere((element) => element.id == e);
      if (index != -1) {
        result.add(mixList[index]);
      }
    }).toList();
    return result;
  }

  static String getMixName(int id) {
    if (id == -1) {
      return "Unknown";
    } else {
      MixHive? hive = getMixById(id);
      if (hive == null) {
        return "Unknown";
      } else {
        return hive.title;
      }
    }
  }

  static bool removeMix(int id) {
    int index = mixBox.values.toList().indexWhere((element) => element.id == id);
    if (index != -1) {
      mixBox.deleteAt(index);
    }
    return true;
  }

  //---------------------playlist box-----------------------

  static int getPlaylistCount() {
    return playlistBox.length;
  }

  static PlayListHive? getMostPlayList() {
    List<dynamic> data = playlistBox.values.toList();
    List<PlayListHive> result = [];
    data.map((e) {
      if (e.runtimeType == PlayListHive) {
        result.add(e);
      }
    }).toList();
    if (result.isEmpty) return null;
    result.sort((a, b) => b.playtime.compareTo(a.playtime));
    return result[0];
  }

  static Future<void> addNewPlayList(String title) async {
    int id = DateTime.now().millisecondsSinceEpoch;
    PlayListHive newPlaylist = PlayListHive(id, title, 0, []);
    await playlistBox.add(newPlaylist);
  }

  static PlayListHive? getPlayListById(int id) {
    PlayListHive? result = playlistBox.values.firstWhereOrNull((element) => element.id == id);
    return result;
  }

  static void updatePlayListTitle(String title, int id) {
    int index = playlistBox.values.toList().indexWhere((element) => element.id == id);
    if (index != -1) {
      //update title
      PlayListHive hive = playlistBox.getAt(index);
      hive.title = title;
      playlistBox.putAt(index, hive);
    }
  }

  static void deletePlayListById(int id) {
    int index = playlistBox.values.toList().indexWhere((element) => element.id == id);
    if (index != -1) {
      PlayListHive playListHive = playlistBox.getAt(index);
      if (playListHive.musics.isNotEmpty) {
        playListHive.musics.map((e) {
          removeMix(e);
        }).toList();
      }
      playlistBox.deleteAt(index);
    }
  }

  static void addNewMixPlaylist(int playlistId, int mixId) {
    int index = playlistBox.values.toList().indexWhere((element) => element.id == playlistId);
    if (index != -1) {
      // update mix
      PlayListHive hive = playlistBox.getAt(index);
      hive.musics.add(mixId);
      playlistBox.putAt(index, hive);
    }
  }

  static void updatePlayListSongs(int playlistId, List<int> musics) {
    int index = playlistBox.values.toList().indexWhere((element) => element.id == playlistId);
    if (index != -1) {
      // update mix
      PlayListHive hive = playlistBox.getAt(index);
      hive.musics = musics;
      playlistBox.putAt(index, hive);
    }
  }

  static int getAllPlaylistDuration(int playlistId) {
    int allSeconds = 0;
    int index = playlistBox.values.toList().indexWhere((element) => element.id == playlistId);
    if (index != -1) {
      PlayListHive playListHive = playlistBox.getAt(index);
      List<MixHive> hives = getMixList(playListHive.musics);
      hives.map((e) => allSeconds += e.duration).toList();
    }
    return allSeconds;
  }
}
