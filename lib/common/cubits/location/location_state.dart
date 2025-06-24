import 'package:equatable/equatable.dart';
import 'package:tripiz_app/common/models/user_location.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  @override
  List<Object?> get props => [];
}

class LocationInitialState extends LocationState {}

class LocationErrorState extends LocationState {
  final String message;
  const LocationErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LocationLoadingState extends LocationState {}

class LocationLoadedState extends LocationState {
  final UserLocation location;

  const LocationLoadedState({required this.location});

  @override
  List<Object?> get props => [
    location.latitude,
    location.longitude,
    location.heading,
    location.accuracy,
    location.city,
    location.conuntry,
  ];

  // Méthode copyWith pour créer un nouvel état avec un heading mis à jour
  LocationLoadedState copyWith({UserLocation? location, double? heading}) {
    return LocationLoadedState(
      location: location ?? this.location.copyWith(heading: heading),
    );
  }
}
