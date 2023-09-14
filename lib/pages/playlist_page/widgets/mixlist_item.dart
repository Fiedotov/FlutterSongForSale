import 'package:Effexxion/hive/mix_hive.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MixListItem extends StatelessWidget {
  final int index;
  final MixHive mix;
  final bool isPlaying;

  const MixListItem({
    super.key,
    required this.index,
    required this.mix,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    double size = 50.h;
    return Container(
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 0.4],
          colors: [Color(0xFF393A4B), Color(0xFF282B3A)],
        ),
        borderRadius: BorderRadius.circular(40.h),
        border: Border.all(
          color: isPlaying ? const Color(0xFFB79158) : Colors.transparent,
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF161A26).withOpacity(0.4),
            offset: const Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: EdgeInsets.all(2.h),
      child: Row(
        children: [
          10.width,
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                mix.title,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: whiteTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.w700),
              ),
            ),
          ),
          10.width,
          Container(
            height: 46.h,
            constraints: BoxConstraints(minWidth: 46.h),
            decoration: BoxDecoration(
              color: const Color(0xFF202332),
              borderRadius: BorderRadius.circular(46.h),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              index.toString(),
              style: whiteTextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
