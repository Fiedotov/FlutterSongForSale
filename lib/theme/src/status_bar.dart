import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
Future<void> showStatusBar() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
}

/// This function will hide status bar
Future<void> hideStatusBar() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

/// Set orientation to portrait
void setOrientationPortrait() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
}
/// Set orientation to landscape
void setOrientationLandscape() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

class BottomBarPainter extends CustomPainter {
  final Color color;

  BottomBarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    Path path = Path();
    path.lineTo(0, size.height);
    path.cubicTo(
        0, size.height, size.width, size.height, size.width, size.height);
    path.cubicTo(size.width * 0.94, size.height, size.width * 0.83,
        size.height * 0.65, size.width * 0.72, size.height * 0.31);
    path.cubicTo(size.width * 0.67, size.height * 0.12, size.width * 0.59,
        size.height * 0.01, size.width * 0.51, 0);
    path.cubicTo(
        size.width * 0.51, 0, size.width * 0.51, 0, size.width * 0.51, 0);
    path.cubicTo(size.width * 0.42, -0.01, size.width * 0.34,
        size.height * 0.11, size.width * 0.27, size.height * 0.31);
    path.cubicTo(size.width * 0.17, size.height * 0.65, size.width * 0.06,
        size.height, 0, size.height);
    path.cubicTo(0, size.height, 0, size.height, 0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}