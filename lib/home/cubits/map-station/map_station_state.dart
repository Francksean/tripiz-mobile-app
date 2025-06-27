import 'package:equatable/equatable.dart';
import 'package:tripiz_app/home/models/station_position.dart';

abstract class MapStationState extends Equatable {
  final List<StationPosition> stations;

  const MapStationState(this.stations);

  @override
  List<Object> get props => [stations];
}

class MapStationInitial extends MapStationState {
  const MapStationInitial() : super(const []);
}

class MapStationLoading extends MapStationState {
  const MapStationLoading(super.stations);
}

class MapStationLoaded extends MapStationState {
  const MapStationLoaded(super.stations);
}

class MapStationError extends MapStationState {
  final String message;

  const MapStationError(this.message, super.stations);

  @override
  List<Object> get props => [message, ...super.props];
}
