import 'package:Effexxion/global_state/global_state.dart';
import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/main.dart';
import 'package:Effexxion/pages/playlist_page/status/playlist_page_status.dart';
import 'package:Effexxion/pages/playlist_page/widgets/playlists_label.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'widgets/edit_playlist_item.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlaylistPageStatus>(
      create: (_) => PlaylistPageStatus(context),
      child: Consumer2<PlaylistPageStatus, GlobalState>(
        builder: (_, state, globalState, __) => ValueListenableBuilder(
          valueListenable: playlistBox.listenable(),
          builder: (context, box, child) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: pageBoxDecoration(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButtonV2(
                        onBack: () {
                          Helper.finish(context);
                        },
                      ),
                      const PlaylistsLabel(),
                      Expanded(
                        child: box.values.isEmpty
                            ? Center(
                                child: Text(
                                  "No playlist",
                                  style: whiteTextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                                ),
                              )
                            : AnimationLimiter(
                                child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: box.values.length,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  separatorBuilder: (context, index) => 15.height,
                                  itemBuilder: (context, index) {
                                    PlayListHive hive = box.getAt(index);
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      child: SlideAnimation(
                                        horizontalOffset: 100.w,
                                        duration: const Duration(milliseconds: 375),
                                        child: FadeInAnimation(
                                          child: EditPlayListItem(
                                            playlist: hive,
                                            isPlaying: hive.id == globalState.playingMode,
                                            onTap: () {
                                              state.onTap(hive);
                                            },
                                            onEdit: () {
                                              state.onEdit(hive.id, hive.id == globalState.playingMode);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
