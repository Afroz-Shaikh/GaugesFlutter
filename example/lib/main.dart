import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleGauge(),
    ),
  );
}

class SimpleGauge extends StatelessWidget {
  const SimpleGauge({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RadialGauge(
        track: RadialTrack(start: 0, end: 100),
      ),
    );
  }
}

class MyGaugeExample extends StatefulWidget {
  const MyGaugeExample({Key? key}) : super(key: key);

  @override
  State<MyGaugeExample> createState() => _MyGaugeExampleState();
}

class _MyGaugeExampleState extends State<MyGaugeExample> {
  double speed = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 5), (timer) {
      setState(() {
        // Simulate internet speed test
        if (timer.tick < 1000) {
          speed = 10.0 + (timer.tick / 50); // Speed gradually increases
        } else {
          // Flicker near 80
          if (timer.tick % 5 == 0) {
            // Randomly update the speed every 5 ticks
            speed = 80.0 -
                (Random().nextDouble() *
                    0); // Random flickering between 80 and slightly higher values
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer!.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          color: const Color(0xff141526),
          // #141526

          child: RadialGauge(
            track: RadialTrack(
              trackStyle: TrackStyle(primaryRulersHeight: 10),
              gradient: LinearGradient(
                  colors: [Color(0xff09BBFD), Color(0xFF7BFF75)]),
              start: 0,
              thickness: 36,
              // startAngle: 0,
              // endAngle: 360,
              end: 100,
            ),
            needlePointer: NeedlePointer(
              color: Color(0xff141526),
              value: speed.clamp(0, 100),
              // value: 10,
              needleWidth: 30,
              needleHeight: 300,
              tailRadius: 29,
              // needleHeight: 90,
            ),
          ),
        ),
      ),
    );
  }
}
