import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';

final scprovider = StreamProvider<StepCount>((ref) async* {
  final Stream<StepCount>? _stepCountStream = await Pedometer.stepCountStream;
  if (_stepCountStream != null) {
    await for (final sc in _stepCountStream) {yield sc;}}
});

final statusprovider = StreamProvider<PedestrianStatus>((ref) async* {
  final Stream<PedestrianStatus>? _statusStream = await Pedometer.pedestrianStatusStream;
  if (_statusStream != null) {
    await for (final sc in _statusStream) {yield sc;}}
});