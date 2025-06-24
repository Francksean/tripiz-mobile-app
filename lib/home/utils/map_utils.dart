import 'dart:math';

import 'package:latlong2/latlong.dart';

class MapUtils {
  /// pour calculer les coordonnées de des coins du carré autour du user
  static List<LatLng> getSquareCorners(LatLng center, double distanceInKm) {
    // Calculer le déplacement en latitude et longitude
    // Note: Cette méthode est approximative et fonctionne mieux près de l'équateur
    // Pour plus de précision, utilisez la formule haversine
    final double latDelta =
        (distanceInKm / 111.2); // 1 degré = environ 111.2 km

    // Ajustement pour la longitude basé sur la latitude
    final double lngDelta =
        distanceInKm / (111.2 * cos(center.latitude * pi / 180));

    return [
      LatLng(center.latitude + latDelta,
          center.longitude - lngDelta), // Nord-Ouest
      LatLng(
          center.latitude + latDelta, center.longitude + lngDelta), // Nord-Est
      LatLng(
          center.latitude - latDelta, center.longitude + lngDelta), // Sud-Est
      LatLng(
          center.latitude - latDelta, center.longitude - lngDelta), // Sud-Ouest
    ];
  }
}
