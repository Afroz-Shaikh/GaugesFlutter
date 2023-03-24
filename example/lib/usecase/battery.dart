import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/gauges.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Battery(),
    ),
  );
}

class Battery extends StatelessWidget {
  const Battery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            color: Colors.blue,
            height: 40,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: LinearGauge(
                  linearGaugeBoxDecoration: const LinearGaugeBoxDecoration(
                      backgroundColor: Colors.red),
                  gaugeOrientation: GaugeOrientation.horizontal,
                  start: 0,
                  end: 100,
                  pointers: const [
                    Pointer(
                        value: 25,
                        width: 20,
                        shape: PointerShape.circle,
                        pointerPosition: PointerPosition.top)
                  ],
                  rulers: const RulerStyle(
                    rulersOffset: 11,
                    rulerPosition: RulerPosition.bottom,
                    showSecondaryRulers: false,
                    primaryRulerColor: Colors.white,
                    showLabel: true,
                    primaryRulersWidth: 4,
                    primaryRulersHeight: 30,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomPathPainter extends CustomPainter {
  _CustomPathPainter(
      {required this.color,
      required this.waterLevel,
      required this.maximumPoint});
  final Color color;
  final double waterLevel;
  final double maximumPoint;

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = _buildTumblerPath(size.width, size.height);
    final double factor = size.height / maximumPoint;
    final double height = 2 * factor * waterLevel;
    final Paint strokePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final Paint paint = Paint()..color = color;
    canvas.drawPath(path, strokePaint);
    final Rect clipper = Rect.fromCenter(
        center: Offset(size.width / 2, size.height),
        height: height,
        width: size.width);
    canvas.clipRect(clipper);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CustomPathPainter oldDelegate) => true;
}

Path _buildTumblerPath(double width, double height) {
  return Path()
    ..lineTo(width, 0)
    ..lineTo(width * 0.75, height - 15)
    ..quadraticBezierTo(width * 0.74, height, width * 0.67, height)
    ..lineTo(width * 0.33, height)
    ..quadraticBezierTo(width * 0.26, height, width * 0.25, height - 15)
    ..close();
}
