import 'package:flutter/material.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text('Linear Gauge Showcase'),
        elevation: 3,
        backgroundColor: Colors.white,
        actions: [],
      ),
    );
  }
}
