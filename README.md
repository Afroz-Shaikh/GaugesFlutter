<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

<img src="https://github.com/Afroz-Shaikh/GaugesFlutter/blob/readme.md/example/screens/banner.png" alt="accessibility text"> 

# Gauges

A gauge, in science and engineering, is a device used to make measurements or in order to display certain dimensional information. A wide variety of tools exist which serve such functions, ranging from simple pieces of material against which sizes can be measured to complex pieces of machinery.Here in Flutter you can use this package to plot a machinery information effortlessly.

## Table of contents

- [Getting Started](#getting-started)
- [Linear Gauge Featues](#customization)
  - [Orientation](#gauge-orientation)
  - [Ruler Style](#rulerstyle)
  - [Pointer](#pointer)
  - [Value Bar](#valuebar)
  - [Range Linear Gauge](#rangelineargauge)
- [Demo Application](#demo-applicatopn)
- [Credits](#credits)

## Getting started

Run this command

```
$flutter pub add geekyants_flutter_gauges
```

This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):

```dart
dependencies:
  geekyants_flutter_gauges: ^0.0.5
```

## Usage

Import it inside your main.dart

```dart
import 'package:geekyants_flutter_gauges/gauges.dart';

```

Use it as below

```dart
class _MyGaugeExampleState extends State<MyGaugeExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LinearGauge(
          rulers: const RulerStyle(
            rulerPosition: RulerPosition.bottom,
          ),
        ),
      ),
    );
  }
}
```

## Customization

### **Gauge Orientation** :

  The linearGauge can be oriented vertically or horizontally. The orientation can be set using the **`Gaugeorientation`** property in the Linear Gauge. The possible values for the orientation property are:

  - `GaugeOrientaion.horizontal`: The gauge will be oriented horizontally, with the minimum value on the left and the maximum value on the right.
  - `GaugeOrientaion.vertical`: The gauge will be oriented vertically, with the minimum value at the bottom and the maximum value at the top.
<img src="https://github.com/Afroz-Shaikh/GaugesFlutter/blob/readme.md/example/screens/orientation.gif" alt="accessibility text"> 

### **RulerStyle** :
 The **RulerStyle** class allows you to customize the appearance of the ruler used in the **LinearGauge**. With properties such as `RulerPosition`, `showLabel`, `inverseRuler`, and many more, you can customize the ruler in various ways to suit your needs.
<img src="https://github.com/Afroz-Shaikh/GaugesFlutter/blob/readme.md/example/screens/rulerposition.png" alt="accessibility text"> 

### **Pointer**:
  The Pointer is used to indicate a specific value on the gauge. The gauge can have multiple pointers with various shapes and values
<img src="https://github.com/Afroz-Shaikh/GaugesFlutter/blob/readme.md/example/screens/pointershape.png" alt="accessibility text"> 

### **ValueBar**
  The `ValueBar` in the LinearGauge is the component that displays the actual value of the gauge. It has properties such as `color`, `offset`, and `thickness` that can be customized to fit your needs.
<img src="https://github.com/Afroz-Shaikh/GaugesFlutter/blob/readme.md/example/screens/valuebar.png" alt="accessibility text"> 

### **RangeLinearGauge**
  The `RangeLinearGauge` class enables you to customize the ruler appearance in the `LinearGauge`. You can display multiple ranges by providing a list of `RangeLinearGauge` values, and customize the color, start, and end values to match your requirements.
<img src="https://github.com/Afroz-Shaikh/GaugesFlutter/blob/readme.md/example/screens/rangelineargauge.png" alt="accessibility text"> 

## Demo Application
To fully explore the capabilities of our Linear Gauge, we recommend checking out our Demo Application which consists of Use Cases and Playgrounds for Linear Gauge
[DEMO APPLICATION](https://gauges-showcase.vercel.app/#/)

## Credits

This package was created by [@GeekyAnts](https://github.com/GeekyAnts).

## License

This package is available under the MIT license.
