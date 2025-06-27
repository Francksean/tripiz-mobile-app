import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:tripiz_app/common/components/custom_bottom_sheet.dart';

import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/cubits/location/location_cubit.dart';
import 'package:tripiz_app/common/cubits/location/location_state.dart';
import 'package:tripiz_app/home/components/qr_code_generate_button.dart';
import 'package:tripiz_app/home/components/itinerary_card.dart';
import 'package:tripiz_app/home/components/station_details_bottom_sheet.dart';
import 'package:tripiz_app/home/cubits/bus-position/bus_position_cubit.dart';
import 'package:tripiz_app/home/cubits/bus-position/bus_position_state.dart';
import 'package:tripiz_app/home/cubits/map-station/map_station_cubit.dart';
import 'package:tripiz_app/home/cubits/map-station/map_station_state.dart';
import 'package:tripiz_app/home/components/user_position_marker.dart';
import 'package:tripiz_app/home/models/payment_info.dart';

/// Écran principal : affiche la carte et superpose
/// les différentes couches (tuile, stations, bus, utilisateur).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // --- Map controller animé
  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
    curve: Curves.easeInOut,
    cancelPreviousAnimations: true,
  );

  /// Limites visibles de la carte (mis à jour après chaque déplacement).
  late LatLngBounds _visibleBounds;

  static const double _defaultZoom = 13.0;
  static const double _markerZoom = 16.0;

  @override
  void initState() {
    super.initState();

    // Au démarrage on pré‑charge les stations d'une fenêtre très large.
    context.read<MapStationCubit>().fetchStationsInBounds(<double>[
      -90,
      90,
      -180,
      180,
    ]);
  }

  // ----------------------------- BUILD ----------------------------- //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, locState) {
        // On attend d'avoir la localisation utilisateur pour centrer la carte.
        if (locState is! LocationLoadedState) {
          return const Center(child: CircularProgressIndicator());
        }

        final LatLng userPos = LatLng(
          locState.location.latitude!,
          locState.location.longitude!,
        );
        final double heading = locState.location.heading ?? 0.0;

        return Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            FlutterMap(
              mapController: _animatedMapController.mapController,
              options: MapOptions(
                initialCenter: userPos,
                initialZoom: _defaultZoom,
                minZoom: 3,
                onMapEvent: (event) {
                  if (event is MapEventMoveEnd) _updateVisibleBounds();
                },
              ),
              children: [
                _tileLayer(), // 1. Tuiles OSM
                _stationLayer(), // 2. Stations
                _busLayer(), // 3. Bus en temps réel
                _userLayer(userPos, heading), // 4. Position utilisateur
              ],
            ),

            // --- Bandeau d'icônes au‑dessus de la carte
            Positioned(
              top: 50,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  /* notifications */
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none,
                    size: 24,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // --------------------------- LAYERS --------------------------- //

  /// Couches de tuiles OSM.
  TileLayer _tileLayer() => TileLayer(
    urlTemplate: 'https://b.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  );

  /// Couches des stations – obtenues depuis le MapStationCubit.
  Widget _stationLayer() {
    return BlocBuilder<MapStationCubit, MapStationState>(
      builder: (context, state) {
        if (state is! MapStationLoaded || state.MapStations.isEmpty) {
          return const MarkerLayer(markers: []);
        }

        final markers =
            state.MapStations.map(
              (station) => Marker(
                point: LatLng(station.latitude!, station.longitude!),
                width: 40,
                height: 40,
                child: GestureDetector(
                  onTap: () {
                    // Animation vers la station
                    _animateToMarker(
                      LatLng(station.latitude!, station.longitude!),
                    );

                    // Affichage de la bottom sheet avec les détails de la station
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return CustomBottomSheet(
                          heightRatio: 0.6,
                          child: StationDetailsBottomSheet(station: station),
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.store_mall_directory,
                    size: 32,
                    color: AppColors.red,
                  ),
                ),
              ),
            ).toList();

        return MarkerLayer(markers: markers);
      },
    );
  }

  /// Couches des bus – mises à jour en temps réel via WebSocket.
  Widget _busLayer() {
    return BlocBuilder<BusPositionCubit, BusPositionState>(
      builder: (_, state) {
        if (state is! BusPositionLoadSuccess || state.buses.isEmpty) {
          return const MarkerLayer(markers: []);
        }

        final markers = state.buses.map(
          (bus) => Marker(
            point: LatLng(bus.latitude, bus.longitude),
            width: 40,
            height: 40,
            rotate: true,
            child: const Icon(
              Icons.directions_bus,
              size: 30,
              color: AppColors.primary,
            ),
          ),
        );

        return MarkerLayer(markers: markers.toList());
      },
    );
  }

  /// Couches de la position utilisateur.
  MarkerLayer _userLayer(LatLng pos, double heading) {
    return MarkerLayer(
      markers: [
        Marker(
          point: pos,
          width: 40,
          height: 40,
          child: UserPositionMarker(heading: heading),
        ),
      ],
    );
  }

  // ----------------------- Helpers ----------------------- //

  /// Anime la caméra pour centrer sur un marqueur donné.
  void _animateToMarker(LatLng markerPosition) =>
      _animatedMapController.centerOnPoint(
        markerPosition,
        zoom: _markerZoom,
        customId: 'marker_animation',
      );

  /// Met à jour les bornes visibles et recharge les stations.
  void _updateVisibleBounds() {
    try {
      _visibleBounds =
          _animatedMapController.mapController.camera.visibleBounds;

      _loadStationsInVisibleArea(
        _visibleBounds.south,
        _visibleBounds.west,
        _visibleBounds.north,
        _visibleBounds.east,
      );
    } catch (e) {
      debugPrint('Erreur lors de la mise à jour des bounds: $e');
    }
  }

  /// Recharge les stations dans la fenêtre visible.
  void _loadStationsInVisibleArea(
    double minLat,
    double minLng,
    double maxLat,
    double maxLng,
  ) {
    context.read<MapStationCubit>().fetchStationsInBounds([
      minLat,
      minLng,
      maxLat,
      maxLng,
    ]);
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }
}
