import 'dart:convert';

import 'package:example/showcase_app/model/menu_item.dart';
import 'package:example/showcase_app/playgrounds/linear_gauge_playground.dart';
import 'package:example/showcase_app/playgrounds/pointer_playground.dart';
import 'package:example/showcase_app/playgrounds/range_linear_gauge_playground.dart';
import 'package:example/showcase_app/playgrounds/ruler_playground.dart';
import 'package:example/useCase/speedometer.dart';
import 'package:example/usecase/battery.dart';
import 'package:example/usecase/blood_sugar_test.dart';
import 'package:example/usecase/daily_tasks.dart';
import 'package:example/usecase/disk_space.dart';
import 'package:example/usecase/server_utilization.dart';

import 'package:example/usecase/temperature_meter.dart';
import 'package:example/usecase/timeline_controller.dart';
import 'package:flutter/material.dart';

import '../../useCase/height_indicator.dart';
import '../../useCase/progress_bar.dart';
import '../../usecase/vaccination_graph.dart';
import '../../usecase/water_level.dart';
import '../useCase/separator.dart';
import 'playgrounds/valueBar_playground.dart';

// Color backgroundColor = const Color(0xffeef2f7);
// Color backgroundColor = const Color(0xffECEDF0);
Color backgroundColor = Colors.white;

List<LinearGaugeUseCase> menuItems = [
  LinearGaugeUseCase(
    title: "Speedometer",
    widget: const Speedometer(),
    index: 0,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Height Indicator",
    widget: const HeightIndicator(),
    index: 1,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Progress Bar",
    widget: const MyProgressBar(),
    index: 2,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Separator",
    widget: const Separator(),
    index: 3,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Vaccination Graph",
    widget: const MyVaccinationGraph(),
    index: 4,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Server Utilization",
    widget: const MyServerUtilizationExample(),
    index: 5,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Temperature Gauge",
    widget: const TemperatureMeter(),
    index: 6,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Blood Sugar Level",
    widget: const BloodSugarTest(),
    index: 7,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Disk Usage",
    widget: const DiskSpace(),
    index: 8,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Weekly Overview",
    widget: const WeeklyOverview(),
    index: 9,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Test 01",
    widget: const Battery(),
    type: "UseCase",
    index: 10,
  ),
  LinearGaugeUseCase(
    title: "Water Level",
    widget: const WaterLevel(),
    index: 11,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "Timeline",
    widget: const TimelineController(),
    index: 12,
    type: "UseCase",
  ),
  LinearGaugeUseCase(
    title: "API",
    widget: const LinearGaugePlayGround(),
    type: "API",
    index: 12,
  ),
  LinearGaugeUseCase(
    title: "Pointer API",
    widget: const PointerPlayGround(),
    type: "API",
    index: 13,
  ),
  LinearGaugeUseCase(
    title: "ValueBar API",
    widget: const ValueBarPlayGround(),
    type: "API",
    index: 14,
  ),
  LinearGaugeUseCase(
    title: "RangeLinearGauge API",
    widget: const RangeLinearGaugePlayGround(),
    type: "API",
    index: 15,
  ),
  LinearGaugeUseCase(
    title: "Ruler API",
    widget: const RulerPlayGround(),
    type: "API",
    index: 16,
  ),
];
