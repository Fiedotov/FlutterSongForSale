import 'package:Effexxion/global_state/global_state.dart';
import 'package:Effexxion/pages/main_page/overlay/status/sleep_time_sheet_status.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/constants.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/widgets/gradient_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class SleepTimeBottomSheet extends StatelessWidget {
  const SleepTimeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SleepTimeSheetStatus>(
      create: (_) => SleepTimeSheetStatus(context),
      child: Consumer2<SleepTimeSheetStatus, GlobalState>(
        builder: (_, state, globalState, __) => WillPopScope(
          onWillPop: () async => false,
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: pageBoxDecoration(),
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        70.height,
                        Container(
                          height: 0.21.sh,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.w),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.3, 1],
                              colors: [Color(0xFF161A26), Color(0xFF393C4D)],
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          margin: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Column(
                                  children: [
                                    Text(
                                      "Sleep Timer",
                                      style: whiteTextStyle().copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                    ),
                                    5.height,
                                    Text(
                                      Helper.convertSleepTimeFromDuration(state.minute),
                                      style: whiteTextStyle().copyWith(fontSize: 40.sp, fontWeight: FontWeight.bold),
                                    ),
                                    5.height,
                                    globalState.sleepWatchTimer != null
                                        ? StreamBuilder<int>(
                                            stream: globalState.sleepWatchTimer.rawTime,
                                            initialData: 0,
                                            builder: (context, snap) {
                                              final value = snap.data;
                                              final displayTime = StopWatchTimer.getDisplayTime(value ?? 0, milliSecond: false);
                                              return Text(
                                                displayTime,
                                                style: whiteTextStyle().copyWith(fontSize: 18.sp),
                                              );
                                            },
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              state.sleepTimes.length < Constants.MAX_SLEEP_TIME_COUNT
                                  ? Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          width: 50.sp,
                                          height: 50.sp,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50.sp),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                stops: [0.2, 1],
                                                colors: [Color(0xFFAF953C), Color(0xFFA77956)],
                                              ),
                                              boxShadow: [
                                                BoxShadow(color: const Color(0xFF221111).withOpacity(0.4), offset: Offset(0, 7.h), blurRadius: 7),
                                              ]),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              onTap: () {
                                                state.addNewSleepTime();
                                              },
                                              borderRadius: BorderRadius.circular(50.sp),
                                              child: Center(
                                                child: Icon(Icons.add, color: Colors.white, size: 40.sp),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                top: 0.07.sh,
                                child: Image.asset("assets/images/backgroundmoon.png", fit: BoxFit.cover,),
                              )
                            ],
                          ),
                        ),
                        20.height,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: GradientSlider(
                            trackHeight: 30.h,
                            activeTrackGradient: const LinearGradient(
                              stops: [0.1, 1],
                              colors: [Color(0xFFAF953C), Color(0xFFA77956)],
                            ),
                            inactiveTrackGradient: const LinearGradient(
                              stops: [0.2, 1],
                              colors: [Color(0xFF161A26), Color(0xFF393C4D)],
                            ),
                            slider: Slider(
                              value: state.minute.toDouble(),
                              // max: 720, // 12 hours
                              max: 60,
                              min: 0,
                              onChanged: state.setMinute,
                            ),
                          ),
                        ),
                        20.height,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GradientButton(
                                label: "Start",
                                stops: const [0.2, 1],
                                colors: const [Color(0xFFAF953C), Color(0xFFA77956)],
                                fontSize: 25.sp,
                                onPressed: () {
                                  state.onStartTime(globalState);
                                },
                              ),
                              GradientButton(
                                label: "Stop",
                                stops: const [0.2, 0.9],
                                colors: const [Color(0xFFD9114F), Color(0xFF292D3C)],
                                fontSize: 25.sp,
                                onPressed: () {
                                  state.onStopTime(globalState);
                                },
                              ),
                            ],
                          ),
                        ),
                        40.height,
                        state.sleepTimes.isEmpty
                            ? Expanded(
                                child: Center(
                                  child: Text(
                                    "No items",
                                    style: whiteTextStyle().copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                child: AlignedGridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15.h,
                                  crossAxisSpacing: 10.w,
                                  itemCount: state.sleepTimes.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: SleepTimeButton(
                                        sleepTime: state.sleepTimes[index],
                                        onPressed: () {
                                          state.setMinute(state.sleepTimes[index].minutes.toDouble());
                                        },
                                        onRemoved: () {
                                          state.removeSleepTime(state.sleepTimes[index].id, index);
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 10.w,
                    top: 10.h,
                    child: NormalButton(
                      image: "assets/images/close.png",
                      onPressed: () {
                        Helper.finish(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
