import 'package:equatable/equatable.dart';
import 'package:tripiz_app/home/models/station_position.dart';

abstract class MapStationState extends Equatable {
  const MapStationState();

  @override
  List<Object> get props => [];
}

class MapStationInitial extends MapStationState {}

class MapStationLoading extends MapStationState {}

class MapStationLoaded extends MapStationState {
  final List<StationPosition> MapStations;

  const MapStationLoaded(this.MapStations);

  @override
  List<Object> get props => [MapStations];
}

class MapStationError extends MapStationState {
  final String message;

  const MapStationError(this.message);

  @override
  List<Object> get props => [message];
}
