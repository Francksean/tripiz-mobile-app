// itinerary_state.dart
part of 'itinerary_cubit.dart';

abstract class ItineraryState {}

class ItineraryInitial extends ItineraryState {}

class ItineraryLoading extends ItineraryState {}

class ItineraryLoaded extends ItineraryState {
  final List<ItineraryFromStation> itineraries;

  ItineraryLoaded(this.itineraries);
}

class ItinerarySelected extends ItineraryState {
  final List<ItineraryFromStation> itineraries;
  final ItineraryFromStation selectedItinerary;

  ItinerarySelected(this.itineraries, {required this.selectedItinerary});
}

class ItineraryError extends ItineraryState {
  final String message;

  ItineraryError(this.message);
}
