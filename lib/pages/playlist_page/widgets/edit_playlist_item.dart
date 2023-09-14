import 'package:Effexxion/hive/playlist_hive.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditPlayListItem extends StatelessWidget {
  final PlayListHive playlist;
  final VoidCallback onEdit;
  final VoidCallback onTap;
  final bool isPlaying;

  const EditPlayListItem({
    super.key,
    required this.playlist,
    required this.onEdit,
    required this.onTap,
    required this.isPlaying,
  });

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
          color: isPlaying ? const Color(0xFFB79158) : Colors.transparent,
          width: 1.h,
        ),
      ),


      // ADD CODE XA



    );
  }
}
