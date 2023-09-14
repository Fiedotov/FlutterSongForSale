import 'dart:async';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Effexxion/global_state/global_state.dart';
import 'package:Effexxion/main.dart';
import 'package:Effexxion/pages/main_page/widgets/mix_label.dart';
import 'package:Effexxion/pages/main_page/widgets/playlist_play_panel.dart';
import 'package:Effexxion/pages/playlist_page/playlist_page.dart';
import 'package:Effexxion/pages/statistic_page/statistic_page.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/widgets/clip_shadow_path.dart';
import 'package:Effexxion/widgets/curve_shadow_painter.dart';
import 'package:Effexxion/widgets/sleek_circular_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import 'sound_panel.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    hideStatusBar();
    setOrientationPortrait();
    Timer(const Duration(seconds: 1), () {
      Provider.of<GlobalState>(context, listen: false).startApp(-1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalState>(
      builder: (_, state, __) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: appBackgroundColor,
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Container(
                constraints: const BoxConstraints.expand(),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Positioned.fill(
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            right: 0,
                            top: -20,
                            child: SizedBox(
                              height: 0.39.sh + bezierHeight,
                              child: state.isInit
                                  ? Stack(
                                      children: [
                                        Positioned.fill(
                                          child: CarouselSlider.builder(
                                            carouselController: state.carouselController,
                                            itemCount: state.musics.length,
                                            itemBuilder: (context, index, realIndex) {
                                              return Image.asset(state.musics[index].thumbnails, fit: BoxFit.cover);
                                            },
                                            options: CarouselOptions(
                                              initialPage: 0,
                                              viewportFraction: 1,
                                              enlargeCenterPage: true,
                                              enableInfiniteScroll: state.playingMode == -1 ? true : false,
                                              scrollPhysics: state.musicSwitch ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                                              height: double.infinity,
                                              enlargeFactor: 0,
                                              onPageChanged: (index, reason) {
                                                if(reason == CarouselPageChangedReason.manual) {
                                                  state.switchMusic(index);
                                                }
                                              },
                                            ),
                                          ),
                                        ),





                                        // Add CODE here P List






                                      ],
                                    )
                                  : Container(),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0.35.sh - bezierHeight,
                            child: SizedBox(
                              height: bezierHeight * 2,
                              child: CustomPaint(
                                painter: CurveShadowPainter(startAngle: 0, angleRange: 0),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 15.h,
                            left: 0.03.sw,
                            child: Column(
                              children: [
                                NormalButton(
                                  image: "assets/images/sleeptimer.png",
                                  onPressed: () {
                                    if (isPurchased) {
                                      state.onSleepTimerHandler(context);
                                    } else {
                                      //todo purchased
                                    }
                                  },
                                ),
                                5.height,
                                state.sleepWatchTimer != null
                                    ? StreamBuilder<int>(
                                        stream: state.sleepWatchTimer.rawTime,
                                        initialData: 0,
                                        builder: (context, snap) {
                                          final value = snap.data;
                                          final displayTime = StopWatchTimer.getDisplayTime(value ?? 0, milliSecond: false);
                                          return Text(
                                            displayTime,
                                            style: whiteTextStyle().copyWith(fontSize: 10.sp),
                                          );
                                        },
                                      )
                                    : Container(),
                              ],
                            ),
                          ),



                          // ADD CODE M BUTTON



                          Positioned(
                            top: 20.h,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: OpacityAnimatedWidget.tween(
                                enabled: state.isLooping,
                                opacityDisabled: 0,
                                opacityEnabled: 1,
                                duration: const Duration(milliseconds: 150),
                                curve: Curves.easeIn,
                                child: SizedBox(
                                  width: 30.w,
                                  height: 30.w,
                                  child: Image.asset("assets/images/displayloop.png", fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0.33.sh,
                            bottom: 0,
                            child: Container(
                              constraints: const BoxConstraints.expand(),
                              child: ClipPath(
                                clipper: ProsteBezierCurve(
                                  position: ClipPosition.top,
                                  list: [
                                    BezierCurveSection(
                                      start: Offset(1.sw, bezierHeight),
                                      top: Offset(1.sw / 2, 10),
                                      end: Offset(0, bezierHeight),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  constraints: const BoxConstraints.expand(),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF282B3A),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        top: -10,
                                        child: SizedBox(
                                          height: bezierHeight * 3,
                                          child: CustomPaint(
                                            painter: CurveShadowPainter(startAngle: 0, angleRange: 0),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: Column(
                                          children: [
                                            5.height,
                                            SleekCircularSlider(
                                              min: 0,
                                              max: 1,
                                              initialValue: state.volume,
                                              appearance: CircularSliderAppearance(
                                                size: 1.sw,
                                                angleRange: angleRange,
                                                startAngle: startAngle,
                                              ),
                                              onChange: state.isMute ? null : state.setVolume,
                                            ),
                                            5.height,
                                            Expanded(
                                              child: ClipShadowPath(
                                                clipper: ProsteBezierCurve(
                                                  position: ClipPosition.top,
                                                  list: [
                                                    BezierCurveSection(
                                                      start: Offset(1.sw, bezierHeight * 1.8),
                                                      top: Offset(1.sw / 2, 0),
                                                      end: Offset(0, bezierHeight * 1.8),
                                                    ),
                                                  ],
                                                ),
                                                shadow: BoxShadow(
                                                  blurRadius: 20.h,
                                                  color: const Color(0xFF171A26),
                                                  spreadRadius: 100,
                                                  offset: Offset(0, -10.h),
                                                ),
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.bottomRight,
                                                      colors: [Color(0xFF333645), Color(0xFF171A26), Color(0xFF070A0B)],
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      10.height,
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height: 0.18.sh,
                                                        child: Stack(
                                                          children: [
                                                            Positioned(
                                                              bottom: 0,
                                                              left: 0.22.sw,
                                                              child: StatusButton(
                                                                status: state.isLooping,
                                                                activeImage: "assets/images/unloop.png",
                                                                inactiveImage: "assets/images/loop.png",
                                                                onPressed: state.toggleLoop,
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 40,
                                                              left: 20,
                                                              child: SecondButton(
                                                                image: "assets/images/statistics.png",
                                                                onPressed: () {
                                                                  const StatisticPage().launch(context);
                                                                },
                                                              ),
                                                            ),
                                                            Positioned(
                                                              top: 40,
                                                              right: 20,
                                                              child: SecondButton(
                                                                image: "assets/images/playlists.png",
                                                                onPressed: () {
                                                                  const PlaylistPage().launch(context);
                                                                },
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 0,
                                                              right: 0,
                                                              top: 0,
                                                              child: Center(
                                                                child: Container(
                                                                  width: 0.17.sh,
                                                                  height: 0.17.sh,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(0.17.sh),
                                                                    image: DecorationImage(
                                                                      image: AssetImage(state.playing ? "assets/images/Pause_Button.png" : "assets/images/Play_Button.png"),
                                                                    ),
                                                                    boxShadow: [
                                                                      BoxShadow(color: const Color(0xFF221111).withOpacity(0.7), offset: Offset(0, 10.h), blurRadius: 7),
                                                                    ],
                                                                  ),
                                                                  child: Material(
                                                                    color: Colors.transparent,
                                                                    child: InkWell(
                                                                      borderRadius: BorderRadius.circular(0.17.sh),
                                                                      onTap: state.togglePlay,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 0,
                                                              right: 0.22.sw,
                                                              child: StatusButton(
                                                                status: state.isMute,
                                                                activeImage: "assets/images/Mute_All_Active.png",
                                                                inactiveImage: "assets/images/Mute_All.png",
                                                                onPressed: state.muteHandler,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      5.height,
                                                      const MixLabel(),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            20.width,
                                                            Expanded(
                                                              flex: 1,
                                                              child: SoundPanel(
                                                                key: state.soundAKey,
                                                                label: "A",
                                                                image: "assets/images/A.png",
                                                                sound: "assets/audios/Button_A.mp3",
                                                                disabled: !isPurchased,
                                                                duration: const Duration(milliseconds: 60004),
                                                              ),
                                                            ),
                                                            5.width,
                                                            Expanded(
                                                              flex: 1,
                                                              child: SoundPanel(
                                                                key: state.soundBKey,
                                                                label: "B",
                                                                image: "assets/images/B.png",
                                                                sound: "assets/audios/Button_B.mp3",
                                                                disabled: false,
                                                                duration: const Duration(milliseconds: 60029),
                                                              ),
                                                            ),
                                                            5.width,
                                                            Expanded(
                                                              flex: 1,
                                                              child: SoundPanel(
                                                                key: state.soundCKey,
                                                                label: "C",
                                                                image: "assets/images/C.png",
                                                                sound: "assets/audios/Button_C.mp3",
                                                                disabled: !isPurchased,
                                                                duration: const Duration(milliseconds: 60004),
                                                              ),
                                                            ),
                                                            5.width,
                                                            Expanded(
                                                              flex: 1,
                                                              child: SoundPanel(
                                                                key: state.soundDKey,
                                                                label: "D",
                                                                image: "assets/images/D.png",
                                                                sound: "assets/audios/Button_D.mp3",
                                                                disabled: !isPurchased,
                                                                duration: const Duration(milliseconds: 60029),
                                                              ),
                                                            ),
                                                            5.width,
                                                            Expanded(
                                                              flex: 1,
                                                              child: SoundPanel(
                                                                key: state.soundEKey,
                                                                label: "E",
                                                                image: "assets/images/E.png",
                                                                sound: "assets/audios/Button_E.mp3",
                                                                disabled: false,

                                                                duration: const Duration(milliseconds: 60029),
                                                              ),
                                                            ),
                                                            5.width,
                                                            Expanded(
                                                              flex: 1,
                                                              child: SoundPanel(
                                                                key: state.soundFKey,
                                                                label: "F",
                                                                image: "assets/images/F.png",
                                                                sound: "assets/audios/Button_F.mp3",
                                                                disabled: !isPurchased,
                                                                duration: const Duration(milliseconds: 60004),
                                                              ),
                                                            ),
                                                            20.width,
                                                          ],
                                                        ),
                                                      ),
                                                      20.height,
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    !state.isInit ? const Loading() : Container(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
