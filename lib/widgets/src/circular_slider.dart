library circular_slider;

import 'package:Effexxion/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'slider_animations.dart';
import 'utils.dart';
import 'appearance.dart';
import 'dart:math' as math;

part 'curve_painter.dart';

part 'custom_gesture_recognizer.dart';

typedef void OnChange(double value);

class SleekCircularSlider extends StatefulWidget {
  final double initialValue;
  final double min;
  final double max;
  final CircularSliderAppearance appearance;
  final OnChange? onChange;
  static const defaultAppearance = CircularSliderAppearance();

  double get angle {
    return valueToAngle(initialValue, min, max, appearance.angleRange);
  }

  const SleekCircularSlider({
    Key? key,
    this.initialValue = 50,
    this.min = 0,
    this.max = 100,
    this.appearance = defaultAppearance,
    this.onChange,
  })  : assert(min <= max),
        assert(initialValue >= min && initialValue <= max),
        super(key: key);

  @override
  State<SleekCircularSlider> createState() => _SleekCircularSliderState();
}

class _SleekCircularSliderState extends State<SleekCircularSlider> with SingleTickerProviderStateMixin {
  bool _isHandlerSelected = false;
  bool _animationInProgress = false;
  _CurvePainter? _painter;
  double? _oldWidgetAngle;
  double? _currentAngle;
  late double _startAngle;
  late double _angleRange;
  double? _selectedAngle;
  ValueChangedAnimationManager? _animationManager;
  late int _appearanceHashCode;

  bool get _interactionEnabled => widget.onChange != null;

  @override
  void initState() {
    super.initState();
    _startAngle = widget.appearance.startAngle;
    _angleRange = widget.appearance.angleRange;
    _appearanceHashCode = widget.appearance.hashCode;
  }

  @override
  void didUpdateWidget(SleekCircularSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    /// _setupPainter excution when _painter is null or appearance has changed.
    if (_painter == null || _appearanceHashCode != widget.appearance.hashCode) {
      _appearanceHashCode = widget.appearance.hashCode;
      _setupPainter();
    }
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        _CustomPanGestureRecognizer: GestureRecognizerFactoryWithHandlers<_CustomPanGestureRecognizer>(
              () => _CustomPanGestureRecognizer(
            onPanDown: _onPanDown,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
          ),
              (_CustomPanGestureRecognizer instance) {},
        ),
      },
      child: SizedBox(
        height: bezierHeight * 3,
        width: widget.appearance.size,
        child: Column(
          children: [
            SizedBox(
              height: bezierHeight,
              width: widget.appearance.size,
              child: Container(
                constraints: const BoxConstraints.expand(),
                color: Colors.transparent,
              ),
            ),



            // ADD C CODE




            SizedBox(
              height: bezierHeight,
              width: widget.appearance.size,
              child: Container(
                constraints: const BoxConstraints.expand(),
                color: Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationManager?.dispose();
    super.dispose();
  }

  void _setupPainter() {
    var defaultAngle = _currentAngle ?? widget.angle;
    if (_oldWidgetAngle != null) {
      if (_oldWidgetAngle != widget.angle) {
        _selectedAngle = null;
        if(_animationManager == null) {
          defaultAngle = widget.angle;
        }
      }
    }

    _currentAngle = calculateAngle(
      startAngle: _startAngle,
      angleRange: _angleRange,
      selectedAngle: _selectedAngle,
      defaultAngle: defaultAngle,
    );

    _painter = _CurvePainter(
      startAngle: _startAngle,
      angleRange: _angleRange,
      angle: _currentAngle! < 0.5 ? 0.5 : _currentAngle!,
    );
    _oldWidgetAngle = widget.angle;
  }

  void _updateOnChange() {
    if (widget.onChange != null && !_animationInProgress) {
      final value = angleToValue(_currentAngle!, widget.min, widget.max, _angleRange);
      widget.onChange!(value);
    }
  }

  Widget _buildRotatingPainter({required Size size}) {
    return _buildPainter(size: size);
  }

  Widget _buildPainter({required Size size}) {
    return CustomPaint(painter: _painter, child: SizedBox(width: size.width, height: size.height));
  }

  void _onPanUpdate(Offset details) {
    if (!_isHandlerSelected) {
      return;
    }
    if (_painter?.center == null) {
      return;
    }
    _handlePan(details, false);
  }

  void _onPanEnd(Offset details) {
    _handlePan(details, true);
    _isHandlerSelected = false;
  }

  void _handlePan(Offset details, bool isPanEnd) {
    if (_painter?.center == null) {
      return;
    }
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var position = renderBox.globalToLocal(details);
    final double touchWidth = bezierHeight * 10;
    if (isPointAlongCircle(position, _painter!.center!, _painter!.radius, touchWidth)) {
      _selectedAngle = coordinatesToRadians(_painter!.center!, position);
      // setup painter with new angle values and update onChange
      _setupPainter();
      _updateOnChange();
      setState(() {});
    }
  }

  bool _onPanDown(Offset details) {
    if (_painter == null || _interactionEnabled == false) {
      return false;
    }
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var position = renderBox.globalToLocal(details);

    final angleWithinRange = isAngleWithinRange(
      startAngle: _startAngle,
      angleRange: _angleRange,
      touchAngle: coordinatesToRadians(_painter!.center!, position),
      previousAngle: _currentAngle,
    );
    if (!angleWithinRange) {
      return false;
    }

    final double touchWidth = bezierHeight * 10;

    if (isPointAlongCircle(position, _painter!.center!, _painter!.radius, touchWidth)) {
      _isHandlerSelected = true;
      _onPanUpdate(details);
    } else {
      _isHandlerSelected = false;
    }

    return _isHandlerSelected;
  }
}
