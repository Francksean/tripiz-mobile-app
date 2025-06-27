// itinerary_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripiz_app/home/models/itinerary_from_station.dart';
import 'package:tripiz_app/home/services/intinerary_service.dart';

part 'itinerary_state.dart';

class ItineraryCubit extends Cubit<ItineraryState> {
  final ItineraryService itineraryService = ItineraryService();

  ItineraryCubit() : super(ItineraryInitial());

  Future<void> loadItineraries(String stationId) async {
    emit(ItineraryLoading());
    try {
      final itineraries = await itineraryService.getItinerariesFromStation(
        stationId,
      );
      emit(ItineraryLoaded(itineraries));
    } catch (e) {
      emit(ItineraryError(e.toString()));
    }
  }

  void selectItinerary(ItineraryFromStation itinerary) {
    if (state is ItineraryLoaded) {
      emit(
        ItinerarySelected(
          (state as ItineraryLoaded).itineraries,
          selectedItinerary: itinerary,
        ),
      );
    }
  }
}
