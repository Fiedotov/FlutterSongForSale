import 'dart:async';

import 'package:Effexxion/hive/mix_hive.dart';
import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';

class StatisticStatus with ChangeNotifier {
  final BuildContext context;

  StatisticStatus(this.context) {
    _initState();
  }

  String _playTimeTotal = "00:00:00";
  String _yesterdayTime = "00:00:00";
  String _todayTime = "00:00:00";

  _initState() {
    hideStatusBar();
    setOrientationPortrait();
    _playTimeTotal = HiveHelper.getTotalPlayTime();
    _todayTime = HiveHelper.getTodayPlayTime();
    _yesterdayTime = HiveHelper.getYesterdayPlayTime();
    notifyListeners();
  }

  String get playTimeTotal => _playTimeTotal;

  String get yesterdayTime => _yesterdayTime;

  String get todayTime => _todayTime;

  String getMostPlayedPlayList() {
    PlayListHive? hive = HiveHelper.getMostPlayList();
    if (hive == null) return "";
    if (hive.playtime == 0) return "";
    return hive.title;
  }

  String getMostPlayedMix() {
    MixHive? hive = HiveHelper.getMostMix();
    if (hive == null) return "";
    if (hive.playtime == 0) return "";
    return hive.title;
  }

  reset() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Warning"),
          content: const Text("Do you want really Reset Statistics?"),
          actions: [
            TextButton(
              onPressed: () {
                HiveHelper.clearPlayTime();
                Helper.finish(context);
              },
              child: const Text("YES"),
            ),
            TextButton(
              onPressed: () {
                Helper.finish(context);
              },
              child: const Text("NO"),
            ),
          ],
        );
      },
    ).then((value) {
      Timer(const Duration(milliseconds: 150), () {
        _initState();
      });
    });
  }
}
