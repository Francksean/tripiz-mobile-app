import 'package:dio/dio.dart';
import 'package:tripiz_app/common/models/user_location.dart';
import 'package:location/location.dart';

class UserLocationRepository {
  final Dio dio = Dio();
  final Location location = Location();

  Future<UserLocation> getLocationInfos() async {
    print('Starting location retrieval...');
    try {
      // Vérifier les permissions et activer le service
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw Exception('Le service de localisation est désactivé');
        }
      }

      PermissionStatus permissionStatus = await location.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await location.requestPermission();
        if (permissionStatus != PermissionStatus.granted) {
          throw Exception('Les permissions de localisation sont refusées');
        }
      }

      // Obtenir la localisation
      print('Getting location data...');
      final LocationData locationData = await location.getLocation();
      print(
        'Location obtained: ${locationData.latitude}, ${locationData.longitude}',
      );

      // Vérifier si des coordonnées valides ont été obtenues
      if (locationData.latitude == null || locationData.longitude == null) {
        throw Exception('Coordonnées de localisation invalides');
      }

      // Construction de l'URL pour la requête de géocodage inverse
      final String url =
          "https://nominatim.openstreetmap.org/reverse?format=json&lat=${locationData.latitude}&lon=${locationData.longitude}";

      print('Fetching address information...');
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'User-Agent':
                'TripizApp/1.0', // OpenStreetMap requiert un User-Agent
          },
        ),
      );

      if (response.statusCode == 200) {
        print("Address information received");
        final data = response.data;

        // Récupération plus flexible des données d'adresse
        String city = "Inconnu";
        if (data["address"]["city"] != null) {
          city = data["address"]["city"];
        } else if (data["address"]["town"] != null) {
          city = data["address"]["town"];
        } else if (data["address"]["village"] != null) {
          city = data["address"]["village"];
        }

        return UserLocation(
          city: city,
          conuntry: data["address"]["country"] ?? "Inconnu",
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
        );
      } else {
        throw Exception(
          "Erreur lors de la récupération des données de localisation: ${response.statusCode}",
        );
      }
    } catch (e) {
      print("Erreur de localisation: $e");
      throw Exception("Échec de la récupération de la localisation : $e");
    }
  }
}
