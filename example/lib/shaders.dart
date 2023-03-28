import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/gauges.dart';

void main() {
  runApp(const MaterialApp(
    home: MyShaders(),
  ));
}

class MyShaders extends StatefulWidget {
  const MyShaders({super.key});

  @override
  State<MyShaders> createState() => _MyShadersState();
}

class _MyShadersState extends State<MyShaders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearGauge(
                gaugeOrientation: GaugeOrientation.vertical,
                valueBar: [
                  ValueBar(value: 5, color: Colors.red, valueBarThickness: 5)
                ],
                showLinearGaugeContainer: true,
                linearGaugeBoxDecoration:
                    LinearGaugeBoxDecoration(thickness: 5),
                start: 0,
                steps: 1,
                end: 10,
                rulers: const RulerStyle(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  rulerPosition: RulerPosition.right,
                  labelOffset: 10,
                )),
          ),
        ));
  }
}
