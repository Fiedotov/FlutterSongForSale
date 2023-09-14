import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientSlider extends StatefulWidget {
  final Widget slider;
  final double? trackHeight;
  final Gradient? activeTrackGradient;
  final Gradient? inactiveTrackGradient;
  final Color? inactiveTrackColor;
  final double? trackBorder;
  final Color? trackBorderColor;

  const GradientSlider({
    super.key,
    required this.slider,
    this.activeTrackGradient,
    this.trackHeight,
    this.inactiveTrackColor,
    this.inactiveTrackGradient,
    this.trackBorder,
    this.trackBorderColor,
  });

  @override
  State<GradientSlider> createState() => _GradientSliderState();
}

class _GradientSliderState extends State<GradientSlider> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbColor: Colors.white,
        trackHeight: widget.trackHeight,
        // overlayColor: Colors.transparent,
        inactiveTrackColor: widget.inactiveTrackColor,
        trackShape: GradientSliderTrackShape(
          activeTrackGradient: widget.activeTrackGradient ?? _defaultAciveGradient,
          inactiveTrackGradient: widget.inactiveTrackGradient,
          trackBorder: widget.trackBorder,
          trackBorderColor: widget.trackBorderColor,
        ),
      ),
      child: widget.slider,
    );
  }

  final _defaultAciveGradient = const LinearGradient(colors: [Colors.red, Colors.blue]);
}

class GradientSliderTrackShape extends SliderTrackShape with BaseSliderTrackShape {
  GradientSliderTrackShape({
    required this.activeTrackGradient,
    this.inactiveTrackGradient,
    this.trackBorder,
    this.trackBorderColor,
  });

  final Gradient activeTrackGradient;
  final Gradient? inactiveTrackGradient;
  final double? trackBorder;
  final Color? trackBorderColor;

  @override
  void paint(
    PaintingContext context,
    ui.Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required ui.TextDirection textDirection,
    required ui.Offset thumbCenter,
    ui.Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null);
    assert(sliderTheme.disabledInactiveTrackColor != null);
    assert(sliderTheme.activeTrackColor != null);
    assert(sliderTheme.inactiveTrackColor != null);
    assert(sliderTheme.thumbShape != null);
    if (sliderTheme.trackHeight == null || sliderTheme.trackHeight! <= 0) {
      return;
    }
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final ColorTween activeTrackColorTween = ColorTween(begin: sliderTheme.disabledActiveTrackColor, end: Colors.white);
    final ColorTween inactiveTrackColorTween = ColorTween(begin: sliderTheme.disabledInactiveTrackColor, end: inactiveTrackGradient != null ? Colors.white : sliderTheme.inactiveTrackColor);
    final Paint activePaint = Paint()
      ..shader = activeTrackGradient.createShader(trackRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final Paint inactivePaint = Paint()..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    if (inactiveTrackGradient != null) {
      inactivePaint.shader = inactiveTrackGradient!.createShader(trackRect);
    }
    final canvas = context.canvas;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    leftTrackPaint = activePaint;
    rightTrackPaint = inactivePaint;

    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2);

    // background rect
    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left - trackRect.height / 2 - 3.w,
        trackRect.top - 3.h,
        trackRect.right + trackRect.height / 2 + 3.w,
        trackRect.bottom + 3.h,
        topRight: Radius.circular(trackRect.height / 2 + 3.h),
        bottomRight: Radius.circular(trackRect.height / 2 + 3.h),
        topLeft: Radius.circular(trackRect.height / 2 + 3.h),
        bottomLeft: Radius.circular(trackRect.height / 2 + 3.h),
      ),
      rightTrackPaint,
    );

    // active rect
    canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left - trackRect.height / 2,
        trackRect.top,
        thumbCenter.dx + trackRect.height / 2,
        trackRect.bottom,
        topLeft: activeTrackRadius,
        bottomLeft: activeTrackRadius,
        bottomRight: trackRadius,
        topRight: trackRadius,
      ),
      leftTrackPaint,
    );
    /*canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left + 3.w,
        trackRect.top + 3.h,
        thumbCenter.dx - 3.w,
        trackRect.bottom - 3.h,
        topLeft: activeTrackRadius,
        bottomLeft: activeTrackRadius,
        bottomRight: trackRadius,
        topRight: trackRadius,
      ),
      leftTrackPaint,
    );*/

    // Paint thumbPaint = Paint()..color = Colors.white;
    // canvas.drawCircle(Offset(thumbCenter.dx - (trackRect.height / 2), thumbCenter.dy), trackRect.height / 2 - 6.h, thumbPaint);
  }
}
