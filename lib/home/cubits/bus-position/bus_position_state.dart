import 'package:tripiz_app/home/models/bus_position.dart';

abstract class BusPositionState {}

class BusPositionInitial extends BusPositionState {}

class BusPositionLoadSuccess extends BusPositionState {
  final List<BusPosition> buses;
  BusPositionLoadSuccess(this.buses);
}
