part of circular_slider;

class _CurvePainter extends CustomPainter {
  final double angle;
  final double startAngle;
  final double angleRange;

  Offset? handler;
  Offset? center;
  late double radius;
  Color progressBarColor = const Color(0xFF090E12);
  Color activeColor = const Color(0xFF023CAD);

  _CurvePainter({this.angle = 30, required this.startAngle, required this.angleRange});

  @override
  void paint(Canvas canvas, Size size) {
    double trackWidth = 3.sp;
    double dotSize = bezierHeight * 1.5;
    radius = (math.pow(size.height, 2) + math.pow(size.width / 2.03, 2)) / (2 * size.height);
    center = Offset(size.width / 2, radius);
    Paint trackPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackWidth
      ..color = progressBarColor;

    drawCircularArc(
      canvas: canvas,
      paint: trackPaint,
      ignoreAngle: true,
    );

    drawShadow(canvas: canvas, trackWidth: trackWidth, shadowWidth: trackWidth * 7);

    final currentAngle = angle;

    final progressBarPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackWidth - 1.sp
      ..color = activeColor;

    drawCircularArc(canvas: canvas, paint: progressBarPaint);

    // --- dot done-----------------------
    Offset dotHandler = degreesToCoordinates(
      center!,
      -math.pi / 2 + startAngle + currentAngle + 1.5,
      radius - bezierHeight / 1.5,
    );
    Path dotOval = Path()..addOval(Rect.fromCircle(center: Offset(dotHandler.dx, dotHandler.dy + 5), radius: dotSize / 2));
    canvas.drawShadow(dotOval, const Color(0xFF221111), 3, true);
    paintImage(
      canvas: canvas,
      rect: Rect.fromCenter(
        center: dotHandler,
        width: dotSize,
        height: dotSize,
      ),
      image: image,
    );

    // --- dot done end-------------------
  }

  drawCircularArc({
    required Canvas canvas,
    required Paint paint,
    bool ignoreAngle = false,
  }) {
    final double angleValue = ignoreAngle ? 0 : (angleRange - angle);
    final range = angleRange;
    final currentAngle = -angleValue;
    canvas.drawArc(
      Rect.fromCircle(center: center!, radius: radius - bezierHeight / 1.5),
      degreeToRadians(startAngle),
      degreeToRadians(range + currentAngle),
      false,
      paint,
    );
  }

  drawShadow({required Canvas canvas, required double trackWidth, required double shadowWidth}) {
    final shadowStep = math.max(1, (shadowWidth - trackWidth) ~/ 10);
    final maxOpacity = math.min(1.0, 0.12);
    final repetitions = math.max(1, ((shadowWidth - trackWidth) ~/ shadowStep));
    final opacityStep = maxOpacity / repetitions;
    final shadowPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    for (int i = 1; i <= repetitions; i++) {
      shadowPaint.strokeWidth = trackWidth + i * shadowStep;
      shadowPaint.color = activeColor.withOpacity(maxOpacity - (opacityStep * (i - 0.5)));
      drawCircularArc(canvas: canvas, paint: shadowPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
