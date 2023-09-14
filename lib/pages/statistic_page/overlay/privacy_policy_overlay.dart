import 'package:Effexxion/theme/them_util.dart';
import 'package:Effexxion/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyOverlay extends ModalRoute<void> {
  @override
  Color? get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => "";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return const Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Center(
          child: PrivacyPolicyPage(),
        ),
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.9.sw,
      height: 0.7.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.w),
        color: const Color(0xFF161A26),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                20.height,
                Text(
                  "Privacy Policy",
                  style: whiteTextStyle().copyWith(fontSize: 20.sp, fontWeight: FontWeight.w700),
                ),
                10.height,
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        20.height,
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vestibulum lectus mauris ultrices eros in cursus turpis. Et egestas quis ipsum suspendisse ultrices gravida dictum. Arcu vitae elementum curabitur vitae nunc sed velit dignissim. At tempor commodo ullamcorper a. Egestas diam in arcu cursus euismod. Aliquam faucibus purus in massa tempor. Cursus eget nunc scelerisque viverra mauris in aliquam sem fringilla. Amet nisl purus in mollis nunc sed id. Mi ipsum faucibus vitae aliquet. Aliquam purus sit amet luctus venenatis lectus magna fringilla. Sed vulputate odio ut enim blandit volutpat maecenas volutpat. Vestibulum lectus mauris ultrices eros in. Gravida arcu ac tortor dignissim convallis aenean. Odio ut sem nulla pharetra diam. Urna id volutpat lacus laoreet non curabitur gravida. Semper quis lectus nulla at volutpat diam ut. Gravida in fermentum et sollicitudin ac orci. Mattis pellentesque id nibh tortor id aliquet lectus proin. Ut enim blandit volutpat maecenas volutpat blandit aliquam etiam erat. Viverra justo nec ultrices dui. Mauris ultrices eros in cursus turpis massa. Nisl condimentum id venenatis a condimentum vitae sapien pellentesque. Sapien faucibus et molestie ac feugiat. Malesuada proin libero nunc consequat. Amet consectetur adipiscing elit duis tristique sollicitudin nibh sit amet. Dui accumsan sit amet nulla facilisi morbi tempus. Amet justo donec enim diam vulputate ut pharetra. In egestas erat imperdiet sed euismod nisi. Arcu odio ut sem nulla pharetra diam. Vitae turpis massa sed elementum. Lobortis scelerisque fermentum dui faucibus in ornare. Arcu felis bibendum ut tristique et egestas quis. Et netus et malesuada fames ac turpis egestas sed. Eu mi bibendum neque egestas congue. Pellentesque id nibh tortor id aliquet lectus proin nibh. Orci eu lobortis elementum nibh tellus molestie. Eu ultrices vitae auctor eu. Aliquam ultrices sagittis orci a scelerisque purus semper. Lobortis mattis aliquam faucibus purus in massa tempor nec. Facilisis mauris sit amet massa vitae tortor. Vulputate eu scelerisque felis imperdiet proin fermentum leo. Quis vel eros donec ac odio tempor orci dapibus ultrices. Vitae semper quis lectus nulla at. At risus viverra adipiscing at in tellus integer feugiat scelerisque. Lectus nulla at volutpat diam ut venenatis tellus in metus. Eget est lorem ipsum dolor sit amet consectetur. Amet facilisis magna etiam tempor. Interdum varius sit amet mattis vulputate. Diam in arcu cursus euismod quis viverra nibh. Lacus vel facilisis volutpat est velit egestas dui id. Consectetur adipiscing elit duis tristique sollicitudin nibh sit amet. Scelerisque in dictum non consectetur a. Placerat in egestas erat imperdiet sed euismod nisi porta lorem. Facilisis magna etiam tempor orci. Posuere sollicitudin aliquam ultrices sagittis orci a. Tincidunt eget nullam non nisi est sit. Vitae congue eu consequat ac. Nunc sed id semper risus in. Nunc eget lorem dolor sed viverra. Et netus et malesuada fames. Rutrum quisque non tellus orci ac. Magna sit amet purus gravida quis blandit. Cras tincidunt lobortis feugiat vivamus at augue. Hac habitasse platea dictumst quisque. At volutpat diam ut venenatis tellus in metus vulputate. Est ante in nibh mauris cursus. Penatibus et magnis dis parturient montes nascetur ridiculus mus. Nec ultrices dui sapien eget mi proin sed libero. Condimentum lacinia quis vel eros donec ac odio. Sagittis eu volutpat odio facilisis mauris. Proin nibh nisl condimentum id venenatis a. Et magnis dis parturient montes nascetur ridiculus mus mauris vitae. Nisl rhoncus mattis rhoncus urna neque viverra justo nec ultrices. Dui nunc mattis enim ut tellus elementum. Vel quam elementum pulvinar etiam non. Id eu nisl nunc mi ipsum. Tempus quam pellentesque nec nam aliquam sem et tortor consequat. Rhoncus urna neque viverra justo nec ultrices dui. Eget dolor morbi non arcu risus quis varius. Nunc mi ipsum faucibus vitae aliquet nec ullamcorper sit amet. Nibh tellus molestie nunc non blandit. Arcu vitae elementum curabitur vitae nunc. Quam lacus suspendisse faucibus interdum posuere lorem ipsum dolor sit. Mauris rhoncus aenean vel elit scelerisque. Commodo ullamcorper a lacus vestibulum. Non odio euismod lacinia at. Hac habitasse platea dictumst vestibulum rhoncus est pellentesque elit ullamcorper. Lorem ipsum dolor sit amet consectetur adipiscing elit ut. Odio pellentesque diam volutpat commodo sed egestas egestas fringilla phasellus. Molestie at elementum eu facilisis sed odio morbi quis. Pulvinar sapien et ligula ullamcorper malesuada proin libero nunc. Vel eros donec ac odio tempor orci dapibus ultrices. Mauris cursus mattis molestie a iaculis at erat pellentesque. Lorem ipsum dolor sit amet consectetur adipiscing elit. Sapien pellentesque habitant morbi tristique senectus. Cum sociis natoque penatibus et magnis dis. Condimentum vitae sapien pellentesque habitant morbi tristique senectus et netus. Commodo nulla facilisi nullam vehicula ipsum. Pulvinar pellentesque habitant morbi tristique senectus et netus et.",
                          style: whiteTextStyle().copyWith(fontSize: 14.sp),
                        )
                      ],
                    ),
                  ),
                ),
                20.height,
              ],
            ),
          ),
          Positioned(
            right: 10.w,
            top: 10.h,
            child: NormalButton(
              image: "assets/images/close.png",
              size: 30.sp,
              onPressed: () {
                Helper.finish(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
