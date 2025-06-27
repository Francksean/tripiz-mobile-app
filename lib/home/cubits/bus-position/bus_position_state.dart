// lib/home/cubits/bus-position/bus_position_state.dart
import 'package:tripiz_app/home/models/bus_position.dart';

abstract class BusPositionState {}

class BusPositionInitial extends BusPositionState {}

class BusPositionLoadSuccess extends BusPositionState {
  final List<BusPosition> buses;
  BusPositionLoadSuccess(this.buses);
}

class BusPositionError extends BusPositionState {
  final String message;
  BusPositionError(this.message);
}
