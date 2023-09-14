import 'package:Effexxion/theme/them_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MixLabel extends StatelessWidget {
  const MixLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.h),
                    topRight: Radius.circular(10.h),
                  ),
                  color: const Color(0xFF343a48),
                ),
                padding: EdgeInsets.only(left: 20.w, bottom: 0, right: 20.w, top: 5.h),
                child: Text(
                  "Mix",
                  style: whiteTextStyle().copyWith(fontSize: 14.sp),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Container(
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF353B49),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.h),
                bottomRight: Radius.circular(10.h),
                topRight: Radius.circular(10.h),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
