import 'package:Effexxion/global_state/global_state.dart';
import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/pages/playlist_page/status/playlist_panel_status.dart';
import 'package:Effexxion/pages/playlist_page/widgets/playlist_item.dart';
import 'package:Effexxion/pages/playlist_page/widgets/playlist_label_v2.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PlaylistPanelBottomSheet extends StatelessWidget {
  final PlayListHive playlist;

  const PlaylistPanelBottomSheet({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlaylistPanelStatus>(
      create: (_) => PlaylistPanelStatus(context, playlist),


      // ADD PANEL CODE


    );
  }
}
