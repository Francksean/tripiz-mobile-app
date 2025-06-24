import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:tripiz_app/common/components/custom_input_field.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/cubits/location/location_cubit.dart';
import 'package:tripiz_app/common/cubits/location/location_state.dart';
import 'package:tripiz_app/home/components/user_position_marker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(seconds: 1, milliseconds: 500),
    curve: Curves.easeInOut,
    cancelPreviousAnimations: true,
  );

  late LatLngBounds _visibleBounds;

  final double _defaultZoom = 13.0;
  final double _markerZoom = 16.0;

  @override
  void initState() {
    super.initState();
    // Initialiser les bounds par défaut
    _visibleBounds = LatLngBounds(
      const LatLng(-90, -180), // Coin sud-ouest
      const LatLng(90, 180), // Coin nord-est
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is LocationLoadedState) {
          final initialLongitude = state.location.longitude!;
          final initialLatitude = state.location.latitude!;
          final userPosition = LatLng(initialLatitude, initialLongitude);

          final heading = state.location.heading ?? 0.0;

          return Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              FlutterMap(
                mapController: _animatedMapController.mapController,
                options: MapOptions(
                  initialZoom: _defaultZoom,
                  minZoom: 3,
                  initialCenter: LatLng(initialLatitude, initialLongitude),
                  // Surveiller les mouvements de la carte
                  onMapEvent: (MapEvent event) {
                    if (event is MapEventMoveEnd) {
                      _updateVisibleBounds();
                    }
                  },
                ),
                children: [
                  openStreetMapTileLayer,

                  MarkerLayer(
                    markers: [
                      Marker(
                        point: userPosition,
                        width: 40,
                        height: 40,
                        child: UserPositionMarker(heading: heading),
                      ),
                      // TODO : mettre en place le BlocBuilder pour les stations et les bus qui seront charger
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // CustomInputField(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(
                            Icons.notifications_none,
                            size: 24,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return FlutterMap(
          options: MapOptions(),
          children: [openStreetMapTileLayer],
        );
      },
    );
  }

  void _animateToMarker(LatLng markerPosition) {
    _animatedMapController.centerOnPoint(
      markerPosition,
      zoom: _markerZoom,
      customId: 'marker_animation',
    );
  }

  void _updateVisibleBounds() {
    try {
      _visibleBounds =
          _animatedMapController.mapController.camera.visibleBounds;

      final minLat = _visibleBounds.south;
      final minLng = _visibleBounds.west;
      final maxLat = _visibleBounds.north;
      final maxLng = _visibleBounds.east;
      // TODO : load les stations avec la nouvelle aire visible
      _loadStationsInVisibleArea(minLat, minLng, maxLat, maxLng);
    } catch (e) {
      print('Erreur lors de la mise à jour des bounds: $e');
    }
  }

  void _loadStationsInVisibleArea(
    double minLat,
    double minLng,
    double maxLat,
    double maxLng,
  ) {
    List<LatLng> corners = [
      LatLng(minLat, minLng), // Coin sud-ouest
      LatLng(maxLat, maxLng), // Coin nord-est
    ];

    // TODO : Utiliser la fonction du cubit pour load les stations
  }

  @override
  void dispose() {
    // S'assurer de disposer correctement du controller
    _animatedMapController.dispose();
    super.dispose();
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
  urlTemplate: 'https://b.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
);
