import 'package:Effexxion/hive/mix_hive.dart';
import 'package:Effexxion/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Helper {
  static void showToast(String msg, bool success) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: success ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 12,
    );
  }

  static finish(BuildContext context, [Object? result]) {
    if (Navigator.canPop(context)) Navigator.pop(context, result);
  }

  static void copyClipBoard(String copyVal) async {
    final data = ClipboardData(text: copyVal);
    await Clipboard.setData(data);
    Helper.showToast("コピーされました。", true);
  }

  static parseToInt(dynamic value, {int defValue = -1}) {
    if (value == null) return defValue;
    if (value is String) {
      return double.parse(value).toInt();
    }

    if (value is double) {
      return value.toInt();
    }

    return value;
  }

  static parseToDouble(dynamic value, {double defValue = -1.0}) {
    if (value == null) return defValue;
    if (value is String) {
      return double.parse(value);
    }
    if (value is int) {
      return value.toDouble();
    }
    return value;
  }

  static parseToString(dynamic value, {String defValue = ""}) {
    if (value == null) return defValue;
    if (value is String) {
      return value;
    }
    return value.toString();
  }

  static Future sleep(int second) {
    return Future.delayed(Duration(seconds: second));
  }

  static Future sleepWithMilliseconds(int duration) {
    return Future.delayed(Duration(milliseconds: duration));
  }

  static String twoDigits(int n) => n.toString().padLeft(2, "0");

  static String convertSleepTimeFromDuration(int minutes) {
    Duration result = Duration(minutes: minutes);
    String twoDigitsHours = twoDigits(result.inHours);
    String twoDigitsMinutes = twoDigits(result.inMinutes.remainder(60));
    return "$twoDigitsHours:$twoDigitsMinutes";
  }

  static String convertPlayTimeFromDuration(int seconds) {
    Duration result = Duration(seconds: seconds);
    String twoDigitsHours = twoDigits(result.inHours);
    String twoDigitsMinutes = twoDigits(result.inMinutes.remainder(60));
    String twoDigitsSeconds = twoDigits(result.inSeconds.remainder(60));
    return "$twoDigitsHours:$twoDigitsMinutes:$twoDigitsSeconds";
  }

  static String convertMusicDurationMMSS(int seconds) {
    Duration result = Duration(seconds: seconds);
    String twoDigitsMinutes = twoDigits(result.inMinutes);
    String twoDigitsSeconds = twoDigits(result.inSeconds.remainder(60));
    return "$twoDigitsMinutes:$twoDigitsSeconds";
  }

  static String convertMusicDurationHHMMSS(int seconds) {
    Duration result = Duration(seconds: seconds);
    String twoDigitsHours = twoDigits(result.inHours);
    String twoDigitsMinutes = twoDigits(result.inMinutes.remainder(60));
    String twoDigitsSeconds = twoDigits(result.inSeconds.remainder(60));
    return "$twoDigitsHours:$twoDigitsMinutes:$twoDigitsSeconds";
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static List<MixHive> getDefaultMusic() {
    List<MixHive> result = [
      MixHive(-1, "Music 1", "assets/thumbnail/1.jpg", "assets/musics/1.mp3", 64, 0, 0.5, 0, 0, 0, 0, 0, 0, 0),
      MixHive(-1, "Music 2", "assets/thumbnail/2.jpg", "assets/musics/2.mp3", 142, 0, 0.5, 0, 0, 0, 0, 0, 0, 1),
      MixHive(-1, "Music 3", "assets/thumbnail/3.jpg", "assets/musics/3.mp3", 64, 0, 0.5, 0, 0, 0, 0, 0, 0, 2),
      MixHive(-1, "Music 4", "assets/thumbnail/4.jpg", "assets/musics/4.mp3", 142, 0, 0.5, 0, 0, 0, 0, 0, 0, 3),
      MixHive(-1, "Music 5", "assets/thumbnail/5.jpg", "assets/musics/5.mp3", 64, 0, 0.5, 0, 0, 0, 0, 0, 0, 4),
      MixHive(-1, "Music 6", "assets/thumbnail/6.jpg", "assets/musics/6.mp3", 142, 0, 0.5, 0, 0, 0, 0, 0, 0, 5),
      MixHive(-1, "Music 7", "assets/thumbnail/7.jpg", "assets/musics/7.mp3", 64, 0, 0.5, 0, 0, 0, 0, 0, 0, 6),
      MixHive(-1, "Music 8", "assets/thumbnail/8.jpg", "assets/musics/8.mp3", 142, 0, 0.5, 0, 0, 0, 0, 0, 0, 7),
      MixHive(-1, "Music 9", "assets/thumbnail/9.jpg", "assets/musics/9.mp3", 64, 0, 0.5, 0, 0, 0, 0, 0, 0, 8),
      MixHive(-1, "Music 10", "assets/thumbnail/10.jpg", "assets/musics/10.mp3", 142, 0, 0.5, 0, 0, 0, 0, 0, 0, 9),
      MixHive(-1, "Music 11", "assets/thumbnail/11.jpg", "assets/musics/11.mp3", 64, 0, 0.5, 0, 0, 0, 0, 0, 0, 10),
      MixHive(-1, "Music 12", "assets/thumbnail/12.jpg", "assets/musics/12.mp3", 142, 0, 0.5, 0, 0, 0, 0, 0, 0, 11),
      MixHive(-1, "Music 13", "assets/thumbnail/13.jpg", "assets/musics/13.mp3", 64, 0, 0.5, 0, 0, 0, 0, 0, 0, 12),
      MixHive(-1, "Music 14", "assets/thumbnail/14.jpg", "assets/musics/14.mp3", 142, 0, 0.5, 0, 0, 0, 0, 0, 0, 13),
      MixHive(-1, "Music 15", "assets/thumbnail/15.jpg", "assets/musics/15.mp3", 64, 0, 0.5, 0, 0, 0, 0, 0, 0, 14),
    ];
    if (isPurchased) {
      return result;
    }
    return result.sublist(0, 2);
  }
}
