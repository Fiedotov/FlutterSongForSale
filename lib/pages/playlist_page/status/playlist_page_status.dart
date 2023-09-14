import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/pages/playlist_page/overlay/edit_playlist_overlay.dart';
import 'package:Effexxion/pages/playlist_page/overlay/playlist_panel_bottom_sheet.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaylistPageStatus with ChangeNotifier {
  final BuildContext context;

  PlaylistPageStatus(this.context) {
    _initStatus();
  }

  _initStatus() {
    hideStatusBar();
    setOrientationPortrait();
  }

  onEdit(int id, bool isPlaying) {
    Navigator.of(context).push(
      EditPlaylistOverlay(playlistId: id, isPlaying: isPlaying),
    );
  }

  onTap(PlayListHive hive) {
    FocusScope.of(context).requestFocus(FocusNode());
    showModalBottomSheet(
      context: context,
      elevation: 10,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      constraints: BoxConstraints(maxHeight: 0.6.sh, minHeight: 0.6.sh),
      builder: (_) => PlaylistPanelBottomSheet(playlist: hive),
    );
  }
}
