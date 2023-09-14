import 'package:Effexxion/hive/mix_hive.dart';
import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayListPlayPanel extends StatelessWidget {
  final int playlistId;
  final MixHive mix;
  final VoidCallback onStop;

  const PlayListPlayPanel({super.key, required this.playlistId, required this.mix, required this.onStop});

  @override
  Widget build(BuildContext context) {
    double size = 60.h;
    PlayListHive hive = HiveHelper.getPlayListById(playlistId)!;
    return Container(
      height: size,
      width: 0.9.sw,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(size),
          bottomRight: Radius.circular(size),
        ),
      ),
      padding: EdgeInsets.all(2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 56.h,
            height: 56.h,
            child: Image.asset(
              HiveHelper.getMixById(hive.musics[0])!.thumbnails,
              fit: BoxFit.cover,
            ),
          ),
          10.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: "Playlist: ",
                    style: whiteTextStyle().copyWith(
                      fontSize: 13.sp,
                    ),
                    children: [
                      TextSpan(
                        text: hive.title,
                        style: whiteTextStyle().copyWith(fontSize: 15.sp, fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                Text(
                  "Mix: ${mix.title}",
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: whiteTextStyle().copyWith(fontSize: 13.sp),
                )
              ],
            ),
          ),
          10.width,
          NormalButton(
            image: "assets/images/stopplaylist.png",
            onPressed: onStop,
            size: 54.h,
          )
        ],
      ),
    );
  }
}
