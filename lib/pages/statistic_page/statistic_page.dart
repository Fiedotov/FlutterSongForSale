import 'package:Effexxion/pages/statistic_page/overlay/privacy_policy_overlay.dart';
import 'package:Effexxion/pages/statistic_page/status/statistic_status.dart';
import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:Effexxion/utils/hive_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'widgets/most_played_label.dart';

class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StatisticStatus>(
      create: (_) => StatisticStatus(context),
      child: Consumer<StatisticStatus>(
        builder: (_, state, __) => Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: pageBoxDecoration(),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        children: [
                          70.height,

                          // ADD ST CODE


                          20.height,
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.w),
                              color: const Color(0xFF2E3442),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF161A26).withOpacity(0.4),
                                  offset: const Offset(0, 0),
                                  blurRadius: 10,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      flex: 4,
                                      child: Container(
                                        width: double.infinity,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40.h),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            stops: [0.5, 1],
                                            colors: [Color(0xFF393C4D), Color(0xFF161A26)],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF161A26).withOpacity(0.4),
                                              offset: Offset(0, 10.h),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {},
                                            borderRadius: BorderRadius.circular(40.h),
                                            child: Padding(
                                              padding: EdgeInsets.all(2.h),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 36.h,
                                                    height: 36.h,
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF232938),
                                                      borderRadius: BorderRadius.circular(36.h),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      HiveHelper.getPlaylistCount().toString(),
                                                      style: whiteTextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "Playlists",
                                                      textAlign: TextAlign.center,
                                                      style: whiteTextStyle().copyWith(fontSize: 13.sp, fontWeight: FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    8.width,
                                    Flexible(
                                      flex: 4,
                                      child: Container(
                                        width: double.infinity,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40.h),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            stops: [0.5, 1],
                                            colors: [Color(0xFF393C4D), Color(0xFF161A26)],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF161A26).withOpacity(0.4),
                                              offset: Offset(0, 10.h),
                                              blurRadius: 10,
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {},
                                            borderRadius: BorderRadius.circular(40.h),
                                            child: Padding(
                                              padding: EdgeInsets.all(2.h),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 36.h,
                                                    constraints: BoxConstraints(minWidth: 36.h),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF232938),
                                                      borderRadius: BorderRadius.circular(36.h),
                                                    ),
                                                    alignment: Alignment.center,
                                                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                                                    child: Text(
                                                      HiveHelper.getMixCount().toString(),
                                                      style: whiteTextStyle().copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      "Mixes",
                                                      textAlign: TextAlign.center,
                                                      style: whiteTextStyle().copyWith(fontSize: 13.sp, fontWeight: FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    8.width,
                                    Flexible(
                                      flex: 4,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.h),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                stops: [0.5, 1],
                                                colors: [Color(0xFF393C4D), Color(0xFF161A26)],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF161A26).withOpacity(0.4),
                                                  offset: Offset(0, 10.h),
                                                  blurRadius: 10,
                                                ),
                                              ],
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {},
                                                borderRadius: BorderRadius.circular(20.h),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                                  child: Text(
                                                    "Restore InAPP\nPurchases",
                                                    textAlign: TextAlign.center,
                                                    style: whiteTextStyle().copyWith(fontSize: 12.sp, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          6.height,
                                          Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20.h),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                stops: [0.5, 1],
                                                colors: [Color(0xFF393C4D), Color(0xFF161A26)],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF161A26).withOpacity(0.4),
                                                  offset: Offset(0, 10.h),
                                                  blurRadius: 10,
                                                ),
                                              ],
                                            ),
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(PrivacyPolicyOverlay());
                                                },
                                                borderRadius: BorderRadius.circular(20.h),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                                  child: Text(
                                                    "Privacy Policy",
                                                    textAlign: TextAlign.center,
                                                    style: whiteTextStyle().copyWith(fontSize: 13.sp, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                6.height,
                                const MostPlayedLabel(),
                                6.height,
                                Container(
                                  width: double.infinity,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.h),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.5, 1],
                                      colors: [
                                        Color(0xFF393C4D),
                                        Color(0xFF161A26),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF161A26).withOpacity(0.4),
                                        offset: Offset(0, 10.h),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(40.h),
                                      child: Padding(
                                        padding: EdgeInsets.all(2.h),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                height: 36.h,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF232938),
                                                  borderRadius: BorderRadius.circular(36.h),
                                                ),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                child: Text(
                                                  "Playlist:",
                                                  style: whiteTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            10.width,
                                            Flexible(
                                              flex: 3,
                                              child: Text(
                                                state.getMostPlayedPlayList(),
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: whiteTextStyle().copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                6.height,
                                Container(
                                  width: double.infinity,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.h),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      stops: [0.5, 1],
                                      colors: [
                                        Color(0xFF393C4D),
                                        Color(0xFF161A26),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF161A26).withOpacity(0.4),
                                        offset: Offset(0, 10.h),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(40.h),
                                      child: Padding(
                                        padding: EdgeInsets.all(2.h),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              flex: 1,
                                              child: Container(
                                                height: 36.h,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF232938),
                                                  borderRadius: BorderRadius.circular(36.h),
                                                ),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                                child: Text(
                                                  "Mix:",
                                                  style: whiteTextStyle().copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            10.width,
                                            Flexible(
                                              flex: 3,
                                              child: Text(
                                                state.getMostPlayedMix(),
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: whiteTextStyle().copyWith(fontSize: 15.sp, fontWeight: FontWeight.bold),
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
                          10.height,
                          Align(
                            alignment: Alignment.centerRight,
                            child: GradientButton(
                              label: "Reset Statistics",
                              stops: const [0.2, 0.7],
                              colors: const [Color(0xFFD9114F), Color(0xFF292D3C)],
                              fontSize: 16.sp,
                              onPressed: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                state.reset();
                              },
                            ),
                          ),
                          10.height,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.w,
                    top: 10.h,
                    child: BackButtonV2(
                      onBack: () {
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
