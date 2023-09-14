import 'package:Effexxion/hive/sleep_time_hive.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../them_util.dart';

class HorizonBorder extends StatelessWidget {
  final double width;
  final Color color;

  const HorizonBorder({Key? key, required this.width, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: double.infinity,
      child: Container(
        decoration: BoxDecoration(color: color),
      ),
    );
  }
}

class VerticalBorder extends StatelessWidget {
  final double height;
  final Color color;

  const VerticalBorder({Key? key, required this.height, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Container(
        decoration: BoxDecoration(color: color),
      ),
    );
  }
}

class NormalButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  final double size;

  const NormalButton({super.key, required this.image, required this.onPressed, this.size = 45});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.w),
        boxShadow: [
          BoxShadow(color: const Color(0xFF222222).withOpacity(0.2), offset: Offset(0, 3.h), blurRadius: 2),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(size.w),
          onTap: onPressed,
          child: Image.asset(
            image,
            colorBlendMode: BlendMode.modulate,
            color: Colors.white.withOpacity(1),
          ),
        ),
      ),
    );
  }
}

class SecondButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;

  const SecondButton({super.key, required this.image, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.07.sh,
      height: 0.07.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.07.sh),
        boxShadow: [
          BoxShadow(color: const Color(0xFF221111).withOpacity(0.4), offset: Offset(0, 7.h), blurRadius: 7),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(0.07.sh),
          onTap: onPressed,
          child: Image.asset(image),
        ),
      ),
    );
  }
}

class StatusButton extends StatelessWidget {
  final bool status;
  final String activeImage;
  final String inactiveImage;
  final VoidCallback onPressed;

  const StatusButton({
    super.key,
    required this.status,
    required this.activeImage,
    required this.inactiveImage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 45.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45.w),
        boxShadow: [
          BoxShadow(color: const Color(0xFF221111).withOpacity(0.4), offset: Offset(0, 7.h), blurRadius: 7),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(45.w),
          onTap: onPressed,
          child: Image.asset(status ? activeImage : inactiveImage),
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final String label;
  final List<Color> colors;
  final List<double> stops;
  final double fontSize;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.label,
    required this.colors,
    required this.stops,
    required this.fontSize,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.w),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
          stops: stops,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF161A26).withOpacity(0.4),
            offset: Offset(0, 12.h),
            blurRadius: 12,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15.w),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 10.h),
            child: Text(
              label,
              style: whiteTextStyle().copyWith(fontSize: fontSize, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class SleepTimeButton extends StatelessWidget {
  final SleepTimeHive sleepTime;
  final VoidCallback onPressed;
  final VoidCallback onRemoved;

  const SleepTimeButton({
    super.key,
    required this.sleepTime,
    required this.onPressed,
    required this.onRemoved,
  });

  @override
  Widget build(BuildContext context) {
    double size = 30.w;
    return SizedBox(
      width: 0.25.sw + size * 2,
      height: 0.25.sw + size * 2,
      child: Stack(
        children: [
          Positioned(
            left: size * 0.5,
            right: size * 0.5,
            bottom: size,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.6, 2],
                  colors: [
                    Color(0xFF222634),
                    Color(0xFF313445),
                  ],
                ),
                boxShadow: [
                  BoxShadow(color: const Color(0xFF161A26).withOpacity(0.4), offset: Offset(0, 10.h), blurRadius: 10),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: BorderRadius.circular(size),
                  child: Center(
                    child: Text(
                      Helper.convertSleepTimeFromDuration(sleepTime.minutes),
                      style: whiteTextStyle().copyWith(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: size - 10.w,
            right: 0,
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.6, 2],
                  colors: [
                    Color(0xFF222634),
                    Color(0xFF313445),
                  ],
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onRemoved,
                  borderRadius: BorderRadius.circular(size),
                  child: Image.asset("assets/images/close.png", fit: BoxFit.cover),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final double size;
  final double opacity;
  final Color background;

  const Loading({
    Key? key,
    this.size = 25,
    this.opacity = 0.5,
    this.background = appBackgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      //decoration: pageBoxDecoration(),
      color: Colors.black.withOpacity(opacity),
      child: Center(
        child: Container(
          width: 50.w,
          height: 50.w,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(color: Colors.black, offset: Offset(0, 5), blurRadius: 5),
            ],
          ),
          child: SpinKitRing(
            color: Colors.black,
            lineWidth: 2,
            duration: const Duration(milliseconds: 1000),
            size: size,
          ),
        ),
      ),
    );
  }
}

class BackButtonV2 extends StatelessWidget {
  final VoidCallback onBack;

  const BackButtonV2({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.w,
      height: 45.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45.w),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(45.w),
          onTap: onBack,
          child: const Center(
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF737783),
            ),
          ),
        ),
      ),
    );
  }
}

