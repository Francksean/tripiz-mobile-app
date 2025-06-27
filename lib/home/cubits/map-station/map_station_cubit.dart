import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripiz_app/common/services/map_station_service.dart';
import 'package:tripiz_app/home/cubits/map-station/map_station_state.dart';
import 'package:tripiz_app/home/models/station_position.dart';

class MapStationCubit extends Cubit<MapStationState> {
  final MapStationService stationService = MapStationService();

  // Cache local pour toutes les stations déjà chargées
  final Map<String, StationPosition> _stationCache = {};

  MapStationCubit() : super(MapStationInitial());

  Future<void> fetchStationsInBounds(List<double> bounds) async {
    try {
      // Émet l'état de chargement avec les données existantes
      emit(MapStationLoading(_stationCache.values.toList()));

      // Charge les nouvelles stations depuis l'API
      final newStations = await stationService.getStationsInBounds(bounds);

      // Met à jour le cache
      for (final station in newStations) {
        _stationCache[station.stationId!] = station;
      }

      // Émet l'état chargé avec toutes les stations (cache + nouvelles)
      emit(MapStationLoaded(_stationCache.values.toList()));
    } catch (e) {
      // En cas d'erreur, conserve les stations existantes
      emit(MapStationError(e.toString(), _stationCache.values.toList()));
    }
  }
}
