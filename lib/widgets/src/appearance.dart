import 'package:flutter/material.dart';

typedef String PercentageModifier(double percentage);

class CircularSliderAppearance {
  static const double _defaultSize = 150.0;
  static const double _defaultStartAngle = 150.0;
  static const double _defaultAngleRange = 240.0;

  static const Color _defaultTrackColor = Color.fromRGBO(220, 190, 251, 1.0);

  static const List<Color> _defaultBarColors = [
    Color.fromRGBO(30, 0, 59, 1.0),
    Color.fromRGBO(236, 0, 138, 1.0),
    Color.fromRGBO(98, 133, 218, 1.0),
  ];

  static const double _defaultGradientStartAngle = 0.0;
  static const double _defaultGradientEndAngle = 180.0;
  static const double _defaultTrackGradientStartAngle = 0.0;
  static const double _defaultTrackGradientEndAngle = 180.0;
  static const bool _defaultHideShadow = false;
  static const Color _defaultShadowColor = Color.fromRGBO(44, 87, 192, 1.0);
  static const double _defaultShadowMaxOpacity = 0.2;
  static const Color _defaultDotColor = Colors.white;

  final double size;
  final double startAngle;
  final double angleRange;
  final int spinnerDuration;
  final CustomSliderWidths? customWidths;
  final CustomSliderColors? customColors;

  double? get _customTrackWidth => customWidths?.trackWidth;

  double? get _customProgressBarWidth => customWidths?.progressBarWidth;

  double? get _customShadowWidth => customWidths?.shadowWidth;

  double? get _customHandlerSize => customWidths?.handlerSize;

  double get trackWidth => _customTrackWidth ?? progressBarWidth / 4.0;

  double get progressBarWidth => _customProgressBarWidth ?? size / 10.0;

  double get handlerSize => _customHandlerSize ?? progressBarWidth / 5.0;

  double get shadowWidth => _customShadowWidth ?? progressBarWidth * 1.4;

  Color? get _customTrackColor => customColors?.trackColor;

  List<Color>? get _customProgressBarColors {
    if (customColors != null) {
      if (customColors!.progressBarColors != null) {
        return customColors!.progressBarColors;
      } else if (customColors!.progressBarColor != null) {
        return [customColors!.progressBarColor!, customColors!.progressBarColor!];
      }
    }
    return null;
  }

  List<Color>? get _customTrackColors {
    return customColors?.trackColors;
  }

  double? get _gradientStartAngle => customColors?.gradientStartAngle;

  double? get _gradientEndAngle => customColors?.gradientEndAngle;

  double? get _trackGradientStartAngle => customColors?.trackGradientStartAngle;

  double? get _trackGradientEndAngle => customColors?.trackGradientEndAngle;

  Color? get _customShadowColor => customColors?.shadowColor;

  double? get _customShadowMaxOpacity => customColors?.shadowMaxOpacity;

  double? get _customShadowStep => customColors?.shadowStep;

  Color? get _customDotColor => customColors?.dotColor;

  bool? get _hideShadow => customColors?.hideShadow;

  Color get trackColor => _customTrackColor ?? _defaultTrackColor;

  List<Color>? get trackColors => _customTrackColors;

  List<Color> get progressBarColors => _customProgressBarColors ?? _defaultBarColors;

  double get gradientStartAngle => _gradientStartAngle ?? _defaultGradientStartAngle;

  double get gradientStopAngle => _gradientEndAngle ?? _defaultGradientEndAngle;

  double get trackGradientStartAngle => _trackGradientStartAngle ?? _defaultTrackGradientStartAngle;

  double get trackGradientStopAngle => _trackGradientEndAngle ?? _defaultTrackGradientEndAngle;

  bool get hideShadow => _hideShadow ?? _defaultHideShadow;

  Color get shadowColor => _customShadowColor ?? _defaultShadowColor;

  double get shadowMaxOpacity => _customShadowMaxOpacity ?? _defaultShadowMaxOpacity;

  double? get shadowStep => _customShadowStep;

  Color get dotColor => _customDotColor ?? _defaultDotColor;


  const CircularSliderAppearance({
    this.customWidths,
    this.customColors,
    this.size = _defaultSize,
    this.startAngle = _defaultStartAngle,
    this.angleRange = _defaultAngleRange,
    this.spinnerDuration = 1500,
  });
}

class CustomSliderWidths {
  final double? trackWidth;
  final double? progressBarWidth;
  final double? handlerSize;
  final double? shadowWidth;

  CustomSliderWidths({this.trackWidth, this.progressBarWidth, this.handlerSize, this.shadowWidth});
}

class CustomSliderColors {
  final Color? trackColor;
  final Color? progressBarColor;
  final List<Color>? progressBarColors;
  final double? gradientStartAngle;
  final double? gradientEndAngle;
  final List<Color>? trackColors;
  final double? trackGradientStartAngle;
  final double? trackGradientEndAngle;
  final bool? hideShadow;
  final Color? shadowColor;
  final double? shadowMaxOpacity;
  final double? shadowStep;
  final Color? dotColor;

  CustomSliderColors({
    this.trackColor,
    this.progressBarColor,
    this.progressBarColors,
    this.gradientStartAngle,
    this.gradientEndAngle,
    this.trackColors,
    this.trackGradientStartAngle,
    this.trackGradientEndAngle,
    this.hideShadow,
    this.shadowColor,
    this.shadowMaxOpacity,
    this.shadowStep,
    this.dotColor,
  });
}