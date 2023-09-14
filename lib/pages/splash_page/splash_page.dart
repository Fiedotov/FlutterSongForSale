import 'dart:async';
import 'dart:math' as math;
import 'package:Effexxion/main.dart';
import 'package:Effexxion/pages/main_page/main_page.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/widgets/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final int waitTime = 1; //seconds

  @override
  void initState() {
    super.initState();
    hideStatusBar();
    setOrientationPortrait();
    _initApp();
  }

  Future<void> _initApp() async {
    Timer(Duration(seconds: waitTime), () {
      _calculator();
      const MainPage().launch(context, isNewTask: true, type: PageTransitionType.fade);
    });
  }

  _calculator() {
    if (context.isTablet()) {
      bezierHeight = 30;
      double sw = 1.sw + bezierHeight;
      double radius = (math.pow(bezierHeight, 2) + math.pow(sw / 2, 2)) / (2 * bezierHeight);
      double degreeRadian = math.asin((sw / 2) / radius);
      double degree = radiansToDegrees(degreeRadian);
      startAngle = 270 - degree + 1;
      angleRange = degree * 2 - 2;
    } else if (context.isPhone()) {
      bezierHeight = 20;
      double sw = 1.sw + bezierHeight;
      double radius = (math.pow(bezierHeight, 2) + math.pow(sw / 2, 2)) / (2 * bezierHeight);
      double degreeRadian = math.asin((sw / 2) / radius);
      double degree = radiansToDegrees(degreeRadian);
      startAngle = 270 - degree + 1;
      angleRange = degree * 2 - 2;
    } else {
      bezierHeight = 20;
      double sw = 1.sw + bezierHeight;
      double radius = (math.pow(bezierHeight, 2) + math.pow(sw / 2, 2)) / (2 * bezierHeight);
      double degreeRadian = math.asin((sw / 2) / radius);
      double degree = radiansToDegrees(degreeRadian);
      startAngle = 270 - degree + 1;
      angleRange = degree * 2 - 2;
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0.0.sh,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 1.sh,
                  height: 1.sh,
                  child: Image.asset("assets/images/logo.jpg", fit: BoxFit.cover),
                ),
              ),
            ),
            Positioned(
              bottom: 280.h,
              left: 24.w,
              right: 24.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: SpinKitDualRing(
                        duration: const Duration(milliseconds: 3000),
                        size: 18.w,
                        lineWidth: 1.w,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  20.height,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
