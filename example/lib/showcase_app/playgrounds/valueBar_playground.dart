import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geekyants_flutter_gauges/gauges.dart';
import '../widgets/playground_header.dart';

class ValueBarPlayGround extends StatefulWidget {
  const ValueBarPlayGround({super.key});

  @override
  State<ValueBarPlayGround> createState() => _ValueBarPlayGroundState();
}

class _ValueBarPlayGroundState extends State<ValueBarPlayGround> {
  // Configurations

  double value = 50;
  ValueBarPosition position = ValueBarPosition.center;
  double valueBarThickness = 4;
  double valueBarOffset = 0;
  double borderRadius = 0;
  bool reverse = false;
  LinearEdgeStyle edgeStyle = LinearEdgeStyle.bothCurve;
  GaugeOrientation orientation = GaugeOrientation.horizontal;

  final TextEditingController _thicknessController = TextEditingController();
  final TextEditingController _offsetController = TextEditingController();
  final TextEditingController _radiusController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _thicknessController.text = valueBarThickness.toString();
    _offsetController.text = valueBarOffset.toString();
    _radiusController.text = borderRadius.toString();
  }

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
            value: value,
            valueBarOffset: valueBarOffset,
            valueBarThickness: valueBarThickness,
            orientation: orientation,
            valueBarPosition: position,
            borderRadius: borderRadius,
            edgeStyle: edgeStyle,
            reverse: reverse),
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
                      const PlayGroundHeader(text: "Gauge Orientation"),
                      buildOrientationHandler(),
                      const Divider(),
                      const PlayGroundHeader(text: "Axis "),
                      inverseAxisHandler(),
                      const Divider(),
                      const PlayGroundHeader(text: "Value"),
                      buildValueHandler(),
                      const Divider(),
                      const PlayGroundHeader(text: "Position"),
                      buildValueBarPositionHandler(),
                      const Divider(),
                      const PlayGroundHeader(text: "ValueBar Properties"),
                      SizedBox(height: 20),
                      buildNumInput(
                        label: "Thickness",
                        numController: _thicknessController,
                        onValueChanged: (p0) {
                          setState(() {
                            valueBarThickness = p0;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      buildNumInput(
                        label: "Offset",
                        numController: _offsetController,
                        onValueChanged: (p1) {
                          setState(() {
                            valueBarOffset = p1;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      buildNumInput(
                        label: "Radius",
                        numController: _radiusController,
                        onValueChanged: (p2) {
                          setState(() {
                            borderRadius = p2;
                          });
                        },
                      ),
                      const Divider(),
                      buildEdgeStyleHandler(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ));
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

  buildValueBarPositionHandler() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 0),
          child:
              const Text('ValueBar Position', style: TextStyle(fontSize: 14)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 1),
          child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    value: position.toString(),
                    items: const [
                      DropdownMenuItem(
                        value: 'ValueBarPosition.center',
                        child: Text('center'),
                      ),
                      DropdownMenuItem(
                        value: 'ValueBarPosition.top',
                        child: Text('top'),
                      ),
                      DropdownMenuItem(
                        value: 'ValueBarPosition.bottom',
                        child: Text('bottom'),
                      ),
                      DropdownMenuItem(
                        value: 'ValueBarPosition.left',
                        child: Text('left'),
                      ),
                      DropdownMenuItem(
                        value: 'ValueBarPosition.right',
                        child: Text('right'),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        handlePositionChange(value);
                      });
                    }),
              )),
        )
      ],
    );
  }

  void handlePositionChange(String? value) {
    if (orientation == GaugeOrientation.horizontal &&
        (position == ValueBarPosition.left ||
            position == ValueBarPosition.right)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          padding: EdgeInsets.all(8),
          content: Text(
            '⚠️ Invalid Pointer Position',
          ),
          backgroundColor: Colors.red,
          showCloseIcon: true,
        ),
      );
    }
    if (value != null) {
      if (value == 'ValueBarPosition.center') {
        position = ValueBarPosition.center;
      }
      if (value == 'ValueBarPosition.top') {
        position = ValueBarPosition.top;
      }
      if (value == 'ValueBarPosition.bottom') {
        position = ValueBarPosition.bottom;
      }
      if (value == 'ValueBarPosition.left') {
        position = ValueBarPosition.left;
      }
      if (value == 'ValueBarPosition.right') {
        position = ValueBarPosition.right;
      }
    }
  }

  buildValueHandler() {
    return Slider(
        min: 0,
        max: 100,
        value: value,
        onChanged: (double value) {
          setState(() {
            this.value = value;
          });
        });
  }

  buildNumInput({
    required TextEditingController numController,
    required Function(double) onValueChanged,
    required String label,
  }) {
    return Row(
      children: <Widget>[
        Expanded(child: Text(label)),
        Expanded(
          flex: 1,
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            controller: numController,
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  double newValue = double.parse(value.toString());
                  onValueChanged(newValue);
                });
              }
            },
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        Container(
          height: 38.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                    ),
                  ),
                ),
                child: InkWell(
                  child: const Icon(
                    Icons.arrow_drop_up,
                    size: 18.0,
                  ),
                  onTap: () {
                    double currentValue = double.parse(numController.text);
                    setState(() {
                      currentValue++;
                      onValueChanged(currentValue);
                      numController.text =
                          (currentValue).toString(); // incrementing value
                    });
                  },
                ),
              ),
              InkWell(
                child: const Icon(
                  Icons.arrow_drop_down,
                  size: 18.0,
                ),
                onTap: () {
                  double currentValue = double.parse(numController.text);
                  if (currentValue > 0) {
                    setState(() {
                      currentValue--;
                      onValueChanged(currentValue);
                      numController.text =
                          (currentValue).toString(); // decrementing value
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

// Handle Rounded Edge Style
  buildEdgeStyleHandler() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 0),
          child: const Text('Edge Style', style: TextStyle(fontSize: 14)),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 1),
          child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    value: edgeStyle.toString(),
                    items: const [
                      DropdownMenuItem(
                        value: 'LinearEdgeStyle.startCurve',
                        child: Text('Start Curve'),
                      ),
                      DropdownMenuItem(
                        value: 'LinearEdgeStyle.endCurve',
                        child: Text('End Curve'),
                      ),
                      DropdownMenuItem(
                        value: 'LinearEdgeStyle.bothCurve',
                        child: Text('Both Curve'),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        handleEdgeStyleChange(value);
                      });
                    }),
              )),
        )
      ],
    );
  }

  void handleEdgeStyleChange(String? value) {
    if (value != null) {
      if (value == 'LinearEdgeStyle.startCurve') {
        edgeStyle = LinearEdgeStyle.startCurve;
      }
      if (value == 'LinearEdgeStyle.endCurve') {
        edgeStyle = LinearEdgeStyle.endCurve;
      }
      if (value == 'LinearEdgeStyle.bothCurve') {
        edgeStyle = LinearEdgeStyle.bothCurve;
      }
    }
  }
}

class LinearGaugeView extends StatelessWidget {
  const LinearGaugeView({
    super.key,
    required this.value,
    required this.valueBarOffset,
    required this.valueBarThickness,
    required this.borderRadius,
    required this.valueBarPosition,
    required this.orientation,
    required this.reverse,
    required this.edgeStyle,
  });

  final double value;
  final double valueBarOffset;
  final double valueBarThickness;
  final double borderRadius;
  final ValueBarPosition valueBarPosition;
  final GaugeOrientation orientation;
  final LinearEdgeStyle edgeStyle;
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
            valueBar: [
              ValueBar(
                  value: value,
                  color: Colors.red,
                  offset: valueBarOffset,
                  valueBarThickness: valueBarThickness,
                  position: valueBarPosition,
                  edgeStyle: edgeStyle,
                  borderRadius: borderRadius),
            ],
            gaugeOrientation: orientation,
            rulers: RulerStyle(
              labelOffset: 10,
              inverseRulers: reverse,
              rulerPosition: orientation == GaugeOrientation.horizontal
                  ? RulerPosition.bottom
                  : RulerPosition.right,
            ),
          ),
        ),
      ),
    );
  }
}