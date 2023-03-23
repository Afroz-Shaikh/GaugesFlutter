import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geekyants_flutter_gauges/gauges.dart';

import '../../../usecase/showcase_app/data.dart';

class RulerPlayGround extends StatefulWidget {
  const RulerPlayGround({super.key});

  @override
  State<RulerPlayGround> createState() => _RulerPlayGroundState();
}

class _RulerPlayGroundState extends State<RulerPlayGround> {
  // Configurations

  RulerPosition rulerPosition = RulerPosition.center;
  bool reverse = false;
  GaugeOrientation orientation = GaugeOrientation.horizontal;
  double labelOffset = 0;
  double rulerOffset = 0;
  bool showLabel = true;
  bool showPrimaryRuler = true;
  bool showSecondaryRuler = true;
  double gaugeThickness = 4;

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
            labelOffset: labelOffset,
            reverse: reverse,
            showLabel: showLabel,
            rulerOffset: rulerOffset,
            showPrimaryRulers: showPrimaryRuler,
            showSecondaryRulers: showSecondaryRuler,
            gaugeThickness: gaugeThickness,
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
                        const Text('Show Label'),
                        showLabelHandler(),
                        const Text("Ruler position"),
                        buildRulerPositionHandler(),
                        const Text("Label offset"),
                        buildLabelOffsetHandler(),
                        const Text("Ruler offset"),
                        buildRulerOffsetHandler(),
                        const Text("Show/Hide Rulers"),
                        showPrimaryRulerHandler(),
                        showSecondaryRulerHandler(),
                        const Text("Gauge thickness"),
                        buildGaugeThicknessHandler(),
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
      return Row(
        children: [
          Container(
            child: const Text('Ruler Position'),
          ),
          const Text(":"),
          Padding(
            padding: const EdgeInsets.only(left: 1),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
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

  buildLabelOffsetHandler() {
    return Slider(
        min: 0,
        max: 100,
        value: labelOffset,
        onChanged: (double value) {
          setState(() {
            labelOffset = value;
          });
        });
  }

  buildRulerOffsetHandler() {
    return Slider(
        min: 0,
        max: 100,
        value: rulerOffset,
        onChanged: (double value) {
          setState(() {
            rulerOffset = value;
          });
        });
  }

  buildGaugeThicknessHandler() {
    return Slider(
        min: 0,
        max: 50,
        value: gaugeThickness,
        onChanged: (double value) {
          setState(() {
            gaugeThickness = value;
          });
        });
  }

  showLabelHandler() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showLabel = !showLabel;
        });
      },
      child: Row(
        children: <Widget>[
          Checkbox(
              activeColor: Colors.red,
              value: showLabel,
              splashRadius: 15,
              onChanged: (bool? value) {
                setState(() {
                  if (value != null) {
                    showLabel = value;
                  }
                });
              }),
          const Text('Show Label', style: TextStyle(fontSize: 14))
        ],
      ),
    );
  }

  showSecondaryRulerHandler() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showSecondaryRuler = !showSecondaryRuler;
        });
      },
      child: Row(
        children: <Widget>[
          Checkbox(
              activeColor: Colors.red,
              value: showSecondaryRuler,
              splashRadius: 15,
              onChanged: (bool? value) {
                setState(() {
                  if (value != null) {
                    showSecondaryRuler = value;
                  }
                });
              }),
          const Text('Show Secondary Ruler', style: TextStyle(fontSize: 14))
        ],
      ),
    );
  }

  showPrimaryRulerHandler() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showPrimaryRuler = !showPrimaryRuler;
        });
      },
      child: Row(
        children: <Widget>[
          Checkbox(
              activeColor: Colors.red,
              value: showPrimaryRuler,
              splashRadius: 15,
              onChanged: (bool? value) {
                setState(() {
                  if (value != null) {
                    showPrimaryRuler = value;
                  }
                });
              }),
          const Text('Show Primary Ruler', style: TextStyle(fontSize: 14))
        ],
      ),
    );
  }
}

class LinearGaugeView extends StatelessWidget {
  const LinearGaugeView({
    super.key,
    required this.orientation,
    required this.reverse,
    required this.rulerPosition,
    required this.showLabel,
    required this.labelOffset,
    required this.rulerOffset,
    required this.showPrimaryRulers,
    required this.showSecondaryRulers,
    required this.gaugeThickness,
  });

  final GaugeOrientation orientation;
  final RulerPosition rulerPosition;
  final double labelOffset;
  final double rulerOffset;
  final bool reverse;
  final bool showLabel;
  final bool showPrimaryRulers;
  final bool showSecondaryRulers;
  final double gaugeThickness;

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
            linearGaugeBoxDecoration:
                LinearGaugeBoxDecoration(thickness: gaugeThickness),
            gaugeOrientation: orientation,
            rulers: RulerStyle(
              rulersOffset: rulerOffset,
              showPrimaryRulers: showPrimaryRulers,
              showSecondaryRulers: showSecondaryRulers,
              showLabel: showLabel,
              labelOffset: labelOffset,
              inverseRulers: reverse,
              rulerPosition: rulerPosition,
            ),
          ),
        ),
      ),
    );
  }
}
