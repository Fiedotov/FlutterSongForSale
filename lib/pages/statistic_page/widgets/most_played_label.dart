import 'package:Effexxion/theme/them_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MostPlayedLabel extends StatelessWidget {
  const MostPlayedLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.h),
                  topRight: Radius.circular(10.h),
                ),
                color: const Color(0xFF343a48),
              ),
              padding: const EdgeInsets.only(left: 20, bottom: 0, right: 20, top: 5),
              child: Text(
                "Most Played",
                style: whiteTextStyle().copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: const Color(0xFF353B49),
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
