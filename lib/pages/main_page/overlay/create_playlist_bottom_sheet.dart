import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/main.dart';
import 'package:Effexxion/pages/main_page/overlay/create_new_playlist_overlay.dart';
import 'package:Effexxion/pages/main_page/overlay/status/create_playlist_status.dart';
import 'package:Effexxion/pages/main_page/widgets/new_playlist_item.dart';
import 'package:Effexxion/pages/playlist_page/widgets/playlists_label.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/constants.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

class CreatePlaylistBottomSheet extends StatelessWidget {
  final int mixID;

  const CreatePlaylistBottomSheet({super.key, required this.mixID});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreatePlaylistStatus>(
      create: (_) => CreatePlaylistStatus(context, mixID),
      child: Consumer<CreatePlaylistStatus>(
        builder: (_, state, __) => ValueListenableBuilder(
          valueListenable: playlistBox.listenable(),
          builder: (context, box, child) {
            return Container(
              constraints: const BoxConstraints.expand(),
              decoration: pageBoxDecoration(),
              child: Material(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            70.height,
                            const PlaylistsLabel(),
                            10.height,
                            Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (HiveHelper.getPlaylistCount() < Constants.MAX_PLAY_LIST_COUNT) {
                                    Navigator.of(context).push(CreateNewPlayListOverlay());
                                  } else {
                                    Helper.showToast("Your playlist is full!", false);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black12,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.w),
                                  ),
                                ),
                                child: Text(
                                  "CREATE PLAYLIST",
                                  style: whiteTextStyle().copyWith(
                                    color: const Color(0xFF393C4D),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            10.height,
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
                                        separatorBuilder: (context, index) => 20.height,
                                        itemBuilder: (context, index) {
                                          PlayListHive hive = box.getAt(index);
                                          return AnimationConfiguration.staggeredList(
                                            position: index,
                                            child: SlideAnimation(
                                              horizontalOffset: 100.w,
                                              duration: const Duration(milliseconds: 375),
                                              child: FadeInAnimation(
                                                child: NewPlayListItem(
                                                  playlist: hive,
                                                  addMix: () {
                                                    HiveHelper.addNewMixPlaylist(hive.id, mixID);
                                                    Helper.showToast("Success!", true);
                                                    Helper.finish(context, true);
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
                    Positioned(
                      left: 10.w,
                      top: 10.h,
                      child: IconButton(
                        onPressed: () {
                          Helper.finish(context);
                        },
                        padding: EdgeInsets.zero,
                        splashRadius: 20.w,
                        icon: Image.asset("assets/images/close.png", fit: BoxFit.cover),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
