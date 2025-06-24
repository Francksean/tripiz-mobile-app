import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:tripiz_app/common/cubits/location/location_state.dart';
import 'package:tripiz_app/common/models/user_location.dart';
import 'package:tripiz_app/common/services/user_location_service.dart';

class LocationCubit extends Cubit<LocationState> {
  StreamSubscription? _locationSubscription;
  StreamSubscription? _compassSubscription;

  LocationCubit() : super(LocationInitialState());

  final UserLocationRepository _userLocationRepository =
      UserLocationRepository();

  Future<void> fetchLocation() async {
    emit(LocationLoadingState());
    try {
      final userPosition = await _userLocationRepository.getLocationInfos();
      emit(LocationLoadedState(location: userPosition));

      // Démarrer le suivi automatiquement après avoir récupéré la position
      startTracking();
    } catch (e) {
      emit(LocationErrorState(message: e.toString()));
    }
  }

  void startTracking() {
    // Arrêter le suivi précédent s'il existe
    _compassSubscription?.cancel();

    // Suivi de la boussole
    _compassSubscription = FlutterCompass.events?.listen((compassEvent) {
      if (state is LocationLoadedState) {
        final currentState = state as LocationLoadedState;

        // Créer un nouvel état avec le heading mis à jour
        final newState = currentState.copyWith(heading: compassEvent.heading);

        emit(newState);
      }
    });

    // Gestion des erreurs de la boussole
    _compassSubscription?.onError((error) {
      print('Erreur boussole: $error');
    });
  }

  void stopTracking() {
    _locationSubscription?.cancel();
    _compassSubscription?.cancel();
    _locationSubscription = null;
    _compassSubscription = null;
  }

  @override
  Future<void> close() {
    stopTracking();
    return super.close();
  }
}
