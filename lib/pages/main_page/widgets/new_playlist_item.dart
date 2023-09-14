import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/theme/src/decoration.dart';
import 'package:Effexxion/theme/src/extensions.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPlayListItem extends StatelessWidget {
  final PlayListHive playlist;
  final VoidCallback addMix;

  const NewPlayListItem({super.key, required this.playlist, required this.addMix});

  @override
  Widget build(BuildContext context) {
    double size = 50.h;
    return Container(
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(size),
          bottomRight: Radius.circular(size),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.2, 1],
          colors: [Color(0xFF393C4D), Color(0xFF161A26)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF161A26).withOpacity(0.4),
            offset: const Offset(0, 0),
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
        border: Border.all(
          color: Colors.transparent,
          width: 1.h,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: size,
            height: size,
            child: Image.asset(
              playlist.musics.isEmpty ? "assets/images/default_image.png" : HiveHelper.getMixById(playlist.musics[0])!.thumbnails,
              fit: BoxFit.cover,
            ),
          ),
          10.width,
          Expanded(
            child: Text(
              playlist.title,
              maxLines: 1,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: whiteTextStyle().copyWith(fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
          ),
          10.width,
          SizedBox(
            width: size,
            height: size,
            child: Padding(
              padding: EdgeInsets.all(5.h),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: addMix,
                  borderRadius: BorderRadius.circular(40.h),
                  child: Image.asset(
                    "assets/images/add.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
