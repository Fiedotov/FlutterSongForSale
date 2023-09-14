import 'package:Effexxion/global_state/global_state.dart';
import 'package:Effexxion/hive/sleep_time_hive.dart';
import 'package:Effexxion/main.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';

class SleepTimeSheetStatus with ChangeNotifier {
  final BuildContext context;

  SleepTimeSheetStatus(this.context) {
    _init();
  }

  _init() {
    sleepTimes = HiveHelper.getSleepTimes();
    notifyListeners();
  }

  int _minute = 0;

  int get minute => _minute;

  bool request = false;

  List<SleepTimeHive> sleepTimes = [];

  setMinute(double value) {
    _minute = value.round();
    notifyListeners();
  }

  addNewSleepTime() async {
    if (_minute == 0) {
      Helper.showToast("Please select timer", false);
      return;
    }
    if (request) return;
    request = true;
    notifyListeners();
    int id = DateTime.now().millisecondsSinceEpoch;
    SleepTimeHive newRecord = SleepTimeHive(id, _minute);
    await sleepTimeBox.add(newRecord);
    sleepTimes.add(newRecord);
    request = false;
    notifyListeners();
  }

  removeSleepTime(int id, int index) async {
    if (request) return;
    request = true;
    notifyListeners();
    await HiveHelper.deleteSleepTimeById(id);
    sleepTimes.removeAt(index);
    request = false;
    notifyListeners();
  }

  onStopTime(GlobalState state) {
    state.stopSleepTimer();
    Helper.showToast("Timer is stopped", true);
  }

  onStartTime(GlobalState state) {
    if (_minute == 0) {
      Helper.showToast("Please select the sleep time", false);
      return;
    }
    state.startSleepTimer(_minute);
  }
}
