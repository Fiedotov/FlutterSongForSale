import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';

class PlaylistPanelStatus with ChangeNotifier {
  final BuildContext context;
  final PlayListHive playlist;

  PlaylistPanelStatus(this.context, this.playlist) {
    _initState();
  }

  _initState() {
    musics = [...playlist.musics];
  }

  List<int> musics = [];

  onReorderHandler(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    int row = musics.removeAt(oldIndex);
    musics.insert(newIndex, row);
    notifyListeners();
  }

  onRemoveMix(int mixId) {
    int index = musics.indexWhere((element) => element == mixId);
    if (index != -1) {
      musics.removeAt(index);
      HiveHelper.updatePlayListSongs(playlist.id, musics);
      HiveHelper.removeMix(mixId);
      notifyListeners();
      Helper.showToast("Deleted successfully!", true);
    }
  }

  save() {
    HiveHelper.updatePlayListSongs(playlist.id, musics);
    Helper.showToast("Saved successfully!", true);
    Helper.finish(context);
  }
}
