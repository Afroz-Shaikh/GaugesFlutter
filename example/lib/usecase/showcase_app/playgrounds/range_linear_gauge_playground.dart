import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geekyants_flutter_gauges/gauges.dart';

import '../../../usecase/showcase_app/data.dart';

class RangeLinearGaugePlayGround extends StatefulWidget {
  const RangeLinearGaugePlayGround({super.key});

  @override
  State<RangeLinearGaugePlayGround> createState() =>
      _RangeLinearGaugePlayGroundState();
}

class _RangeLinearGaugePlayGroundState
    extends State<RangeLinearGaugePlayGround> {
  // Configurations

  RulerPosition rulerPosition = RulerPosition.bottom;
  bool reverse = false;
  GaugeOrientation orientation = GaugeOrientation.horizontal;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Flex(
        direction: screenWidth > 600 ? Axis.horizontal : Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LinearGaugeView(
            orientation: orientation,
            rulerPosition: RulerPosition.center,
            reverse: reverse,
          ),
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  child: Container(
                    color: backgroundColor,
                    padding: const EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height,
                    width: 700,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text('Gauge Orientation'),
                        buildOrientationHandler(),
                        const Divider(),
                        const Text('Inverse axis'),
                        inverseAxisHandler(),
                        const Text("Ruler position"),
                        buildRulerPositionHandler(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buildOrientationHandler() {
    return Row(
      children: [
        Radio<GaugeOrientation>(
          value: GaugeOrientation.horizontal,
          groupValue: orientation,
          onChanged: (GaugeOrientation? value) {
            setState(() {
              orientation = value!;
            });
          },
        ),
        const Text('Horizontal'),
        Radio<GaugeOrientation>(
          value: GaugeOrientation.vertical,
          groupValue: orientation,
          onChanged: (GaugeOrientation? value) {
            setState(() {
              orientation = value!;
            });
          },
        ),
        const Text('Vertical'),
      ],
    );
  }

  Widget inverseAxisHandler() {
    return GestureDetector(
      onTap: () {
        setState(() {
          reverse = !reverse;
        });
      },
      child: Row(
        children: <Widget>[
          Checkbox(
              activeColor: Colors.red,
              value: reverse,
              splashRadius: 15,
              onChanged: (bool? value) {
                setState(() {
                  if (value != null) {
                    reverse = value;
                  }
                });
              }),
          const Text('Inverse axis', style: TextStyle(fontSize: 14))
        ],
      ),
    );
  }

  buildRulerPositionHandler() {
    if (orientation == GaugeOrientation.horizontal) {
      return Row(children: [
        Radio<RulerPosition>(
          value: RulerPosition.bottom,
          groupValue: rulerPosition,
          onChanged: (RulerPosition? value) {
            setState(() {
              rulerPosition = value!;
            });
          },
        ),
        const Text('Bottom'),
        //
        Radio<RulerPosition>(
          value: RulerPosition.top,
          groupValue: rulerPosition,
          onChanged: (RulerPosition? value) {
            setState(() {
              rulerPosition = value!;
            });
          },
        ),
        const Text('Top'),
      ]);
    } else {
      return Row(
        children: [
          Radio<RulerPosition>(
            value: RulerPosition.left,
            groupValue: rulerPosition,
            onChanged: (RulerPosition? value) {
              setState(() {
                rulerPosition = value!;
              });
            },
          ),
          const Text('Bottom'),
          //
          Radio<RulerPosition>(
            value: RulerPosition.right,
            groupValue: rulerPosition,
            onChanged: (RulerPosition? value) {
              setState(() {
                rulerPosition = value!;
              });
            },
          ),
          const Text('Top'),
        ],
      );
    }
  }
}

class LinearGaugeView extends StatelessWidget {
  const LinearGaugeView({
    super.key,
    required this.orientation,
    required this.reverse,
    required this.rulerPosition,
  });

  final GaugeOrientation orientation;
  final RulerPosition rulerPosition;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Container(
        margin: const EdgeInsets.only(left: 30),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: LinearGauge(
            rangeLinearGauge: [
              RangeLinearGauge(color: Colors.red, start: 0, end: 30),
              RangeLinearGauge(color: Colors.green, start: 30, end: 75),
              RangeLinearGauge(color: Colors.blue, start: 75, end: 100),
            ],
            gaugeOrientation: orientation,
            rulers: RulerStyle(
              inverseRulers: reverse,
              rulerPosition: rulerPosition,
            ),
          ),
        ),
      ),
    );
  }
}
