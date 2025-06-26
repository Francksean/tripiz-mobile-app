import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripiz_app/common/services/map_station_service.dart';
import 'package:tripiz_app/home/cubits/map-station/map_station_state.dart';

class MapStationCubit extends Cubit<MapStationState> {
  final MapStationService stationService = MapStationService();

  MapStationCubit() : super(MapStationInitial());

  Future<void> fetchStationsInBounds(List<double> bounds) async {
    try {
      emit(MapStationLoading());

      final stations = await stationService.getStationsInBounds(bounds);

      emit(MapStationLoaded(stations));
    } catch (e) {
      emit(MapStationError(e.toString()));
    }
  }
}
