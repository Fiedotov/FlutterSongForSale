import 'package:Effexxion/hive/mix_hive.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaylistItem extends StatelessWidget {
  final int index;
  final bool current;
  final bool past;
  final MixHive music;
  final double progress;

  const PlaylistItem({
    super.key,
    required this.index,
    required this.past,
    required this.music,
    required this.current,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.4],
          colors: [Color(0xFF393A4B), Color(0xFF282B3A)],
        ),
        borderRadius: BorderRadius.circular(40.h),
        border: Border.all(
          color: current ? const Color(0xFFB79158) : Colors.transparent,
          width: current ? 1.h : 0,
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.all(2.h),
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                Container(
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF232938),
                    borderRadius: BorderRadius.circular(36.h),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    Helper.convertMusicDurationMMSS(music.duration),
                    style: whiteTextStyle().copyWith(fontSize: 16.sp),
                  ),
                ),
                10.width,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        music.title,
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: whiteTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w700),
                      ),
                      3.height,
                      LinearProgressIndicator(
                        minHeight: 2.h,
                        backgroundColor: Colors.transparent,
                        color: const Color(0xFFB79158),
                        value: progress,
                      ),
                    ],
                  ),
                ),
                10.width,
                Container(
                  width: 36.h,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF202332),
                    borderRadius: BorderRadius.circular(36.h),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (index + 1).toString(),
                    style: whiteTextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          past
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(40.h),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
