import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/gauges.dart';
import '../widgets/playground_header.dart';

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
            rulerPosition: rulerPosition,
            reverse: reverse,
          ),
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  child: Container(
                    color: const Color(0xffF5F8FA),
                    padding: const EdgeInsets.all(8),
                    height: MediaQuery.of(context).size.height,
                    width: 700,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PlayGroundHeader(text: "Orientation"),
                        buildOrientationHandler(),
                        const Divider(),
                        const PlayGroundHeader(text: "Axis"),
                        inverseAxisHandler(),
                        const Divider(),
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

  Widget buildOrientationHandler() {
    final Map<GaugeOrientation, Widget> children = {
      GaugeOrientation.horizontal: const Text('Horizontal'),
      GaugeOrientation.vertical: const Text('Vertical'),
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CupertinoSlidingSegmentedControl<GaugeOrientation>(
        groupValue: orientation,
        children: children,
        onValueChanged: (GaugeOrientation? value) {
          setState(() {
            if (value != null) {
              orientation = value;
            }
          });
        },
      ),
    );
  }

  Widget inverseAxisHandler() {
    final Map<bool, Widget> children = {
      false: const Text('Normal axis', style: TextStyle(fontSize: 12)),
      true: const Text('Reverse axis', style: TextStyle(fontSize: 12)),
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CupertinoSlidingSegmentedControl<bool>(
        groupValue: reverse,
        children: children,
        onValueChanged: (bool? value) {
          setState(() {
            if (value != null) {
              reverse = value;
            }
          });
        },
      ),
    );
  }

  buildRulerPositionHandler() {
    if (orientation == GaugeOrientation.horizontal) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: const Text('Ruler Position'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 1),
            child: ButtonTheme(
              alignedDropdown: false,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  value: rulerPosition.toString(),
                  items: [
                    DropdownMenuItem<String>(
                      value: RulerPosition.bottom.toString(),
                      child: const Text('Bottom'),
                    ),
                    DropdownMenuItem<String>(
                      value: RulerPosition.center.toString(),
                      child: const Text('Center'),
                    ),
                    DropdownMenuItem<String>(
                      value: RulerPosition.top.toString(),
                      child: const Text('Top'),
                    ),
                  ],
                  onChanged: (String? value) {
                    setState(() {
                      handleRulerPositionChange(value);
                    });
                  },
                ),
              ),
            ),
          )
        ],
      );
    } else {
      return Row(
        children: [
          const Text('Ruler Position'),
          const Text(":"),
          Padding(
            padding: const EdgeInsets.only(left: 1),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                value: rulerPosition.toString(),
                items: [
                  DropdownMenuItem<String>(
                    value: RulerPosition.right.toString(),
                    child: const Text('right'),
                  ),
                  DropdownMenuItem<String>(
                    value: RulerPosition.center.toString(),
                    child: const Text('Center'),
                  ),
                  DropdownMenuItem<String>(
                    value: RulerPosition.left.toString(),
                    child: const Text('left'),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    handleRulerPositionChange(value);
                  });
                },
              ),
            ),
          )
        ],
      );
    }
  }

  void handleRulerPositionChange(String? value) {
    switch (value) {
      case 'RulerPosition.bottom':
        rulerPosition = RulerPosition.bottom;
        break;
      case 'RulerPosition.center':
        rulerPosition = RulerPosition.center;
        break;
      case 'RulerPosition.top':
        rulerPosition = RulerPosition.top;
        break;
      case 'RulerPosition.right':
        rulerPosition = RulerPosition.right;
        break;
      case 'RulerPosition.left':
        rulerPosition = RulerPosition.left;
        break;
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