import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: const VerticalGauge(),
    ),
  );
}

class VerticalGauge extends StatelessWidget {
  const VerticalGauge({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LinearGauge(
          extendLinearGauge: 30,
          start: 10,
          end: 200,
          pointers: [
            Pointer(
                value: 50,
                showLabel: false,
                width: 20,
                height: 20,
                enableInteractivity: true,
                pointerAlignment: PointerAlignment.center,
                pointerPosition: PointerPosition.center,
                shape: PointerShape.diamond,
                color: Colors.amber,
                enableAnimation: true),
            Pointer(
                value: 40,
                showLabel: false,
                width: 20,
                height: 20,
                enableInteractivity: true,
                pointerAlignment: PointerAlignment.center,
                pointerPosition: PointerPosition.center,
                shape: PointerShape.diamond,
                color: Colors.amber,
                enableAnimation: true),
          ],
          gaugeOrientation: GaugeOrientation.horizontal,
          rulers: RulerStyle(
              rulerPosition: RulerPosition.bottom, inverseRulers: false),
        ),
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
  PointerShape shape = PointerShape.triangle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          LinearGauge(
              start: 200,
              end: 400,
              gaugeOrientation: GaugeOrientation.horizontal,
              enableGaugeAnimation: false,
              extendLinearGauge: 0,
              pointers: [
                Pointer(
                    value: 300,
                    showLabel: true,
                    enableInteractivity: true,
                    pointerAlignment: PointerAlignment.center,
                    pointerPosition: PointerPosition.top,
                    height: 45,
                    shape: PointerShape.triangle,
                    color: Colors.white,
                    enableAnimation: true),
                // Pointer(
                //     value: 200,
                //     showLabel: false,
                //     enableInteractivity: true,
                //     pointerAlignment: PointerAlignment.center,
                //     pointerPosition: PointerPosition.top,
                //     height: 45,
                //     width: shape == PointerShape.rectangle ? 4 : 30,
                //     shape: PointerShape.rectangle,
                //     color: Colors.white,
                //     enableAnimation: true),
              ],
              rulers: const RulerStyle(
                  inverseRulers: false,
                  rulerPosition: RulerPosition.bottom,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                  primaryRulerColor: Colors.blueGrey,
                  secondaryRulerColor: Colors.blueGrey)),
          buildPointerWidgetHandler()
        ],
      ),
    );
  }

  Widget buildPointerWidgetHandler() {
    return SizedBox(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 0),
            child: const Text('Pointer Shape',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
          Flexible(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile<PointerShape>(
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      activeColor: Colors.red,
                      title: const Text(
                        'Circle',
                        style: TextStyle(color: Colors.white),
                      ),
                      value: PointerShape.circle,
                      tileColor: Colors.blueGrey,
                      groupValue: shape,
                      onChanged: (PointerShape? value) {
                        setState(() {
                          handleShapeChange(value!);
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile<PointerShape>(
                      dense: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      activeColor: Colors.red,
                      tileColor: Colors.blueGrey,
                      title: const Text(
                        'Rectangle',
                        style: TextStyle(color: Colors.white),
                      ),
                      value: PointerShape.rectangle,
                      groupValue: shape,
                      onChanged: (PointerShape? value) {
                        setState(() {
                          handleShapeChange(value!);
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile<PointerShape>(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      activeColor: Colors.red,
                      tileColor: Colors.blueGrey,
                      title: const Text(
                        'Triangle',
                        style: TextStyle(color: Colors.white),
                      ),
                      value: PointerShape.triangle,
                      groupValue: shape,
                      onChanged: (PointerShape? value) {
                        setState(() {
                          handleShapeChange(value!);
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RadioListTile<PointerShape>(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      tileColor: Colors.blueGrey,
                      activeColor: Colors.red,
                      title: const Text(
                        'Diamond',
                        style: TextStyle(color: Colors.white),
                      ),
                      value: PointerShape.diamond,
                      groupValue: shape,
                      onChanged: (PointerShape? value) {
                        setState(() {
                          handleShapeChange(value!);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void handleShapeChange(PointerShape? value) {
    if (value != null) {
      if (value == PointerShape.circle) {
        shape = PointerShape.circle;
      }
      if (value == PointerShape.rectangle) {
        shape = PointerShape.rectangle;
      }
      if (value == PointerShape.triangle) {
        shape = PointerShape.triangle;
      }
      if (value == PointerShape.diamond) {
        shape = PointerShape.diamond;
      }
    }
  }
}
