import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

InputDecoration authInputDecoration({required String hint}) {
  return InputDecoration(
    labelText: hint,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    labelStyle: TextStyle(
      color: inputHintTextColor,
      fontSize: 14.sp,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: inputBorderColor, width: 1.h),
      borderRadius: BorderRadius.circular(8.sp),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: inputBorderColor, width: 1.h),
      borderRadius: BorderRadius.circular(8.sp),
    ),
    disabledBorder: InputBorder.none,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: inputFocusBorderColor, width: 1.h),
      borderRadius: BorderRadius.circular(8.sp),
    ),
    isDense: true,
    filled: true,
    fillColor: inputFilledColor,
    errorStyle: TextStyle(fontSize: 12.sp, height: 1, color: errorColor),
  );
}

InputDecoration normalInputDecoration({required String hint, double borderRadius = 7}) {
  return InputDecoration(
    labelText: hint,
    floatingLabelBehavior: FloatingLabelBehavior.never,
    labelStyle: TextStyle(
      color: inputNormalHintTextColor,
      fontSize: 13.sp,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.h),
      borderRadius: BorderRadius.circular(borderRadius.sp),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.h),
      borderRadius: BorderRadius.circular(borderRadius.sp),
    ),
    disabledBorder: InputBorder.none,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.h),
      borderRadius: BorderRadius.circular(borderRadius.sp),
    ),
    isDense: true,
    errorStyle: TextStyle(fontSize: 12.sp, height: 1, color: errorColor),
  );
}

BoxDecoration pageBoxDecoration() {
  return const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0, 1],
      colors: [Color(0xFF393C4D), Color(0xFF161A26)],
    ),
  );
}

TextStyle primaryTextStyle() {
  return TextStyle(fontSize: 14.sp, color: textPrimaryColor);
}

TextStyle secondaryTextStyle() {
  return TextStyle(fontSize: 14.sp, color: textSecondaryColor);
}

TextStyle thirdTextStyle() {
  return TextStyle(fontSize: 14.sp, color: textThirdColor);
}

TextStyle additionTextStyle() {
  return TextStyle(fontSize: 14.sp, color: textAdditionColor);
}

TextStyle whiteTextStyle() {
  return TextStyle(fontSize: 14.sp, color: textWhiteColor);
}

TextStyle errorTextStyle() {
  return TextStyle(fontSize: 14.sp, color: errorColor);
}
