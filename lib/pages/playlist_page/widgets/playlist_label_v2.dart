import 'package:Effexxion/theme/them_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaylistLabelV2 extends StatelessWidget {
  final String title;

  const PlaylistLabelV2({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.h),
                  topRight: Radius.circular(10.h),
                ),
                color: const Color(0xFF4C6879),
              ),
              padding: const EdgeInsets.only(left: 20, bottom: 0, right: 20, top: 5),
              child: Text(
                "Playlists",
                style: whiteTextStyle().copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            ),
            10.width,
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Text(
                  title,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: whiteTextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
        Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: const Color(0xFF4C6879),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.h),
              bottomRight: Radius.circular(10.h),
              topRight: Radius.circular(10.h),
            ),
          ),
        ),
      ],
    );
  }
}
