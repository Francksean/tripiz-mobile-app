import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tripiz_app/common/dio/dio_client.dart';
import 'package:tripiz_app/home/models/station_position.dart';

class MapStationService {
  final DioClient dioClient = DioClient.instance;

  MapStationService();

  Future<List<StationPosition>> getStationsInBounds(List<double> bounds) async {
    try {
      if (bounds.length != 4) throw "Requires exactly 4 bounds points";

      final response = await dioClient.dio.post(
        '/station/stations/within-square',
        data: {
          "minLat": bounds[0],
          "minLng": bounds[2],
          "maxLat": bounds[1],
          "maxLng": bounds[3],
        },
      );

      if (response.statusCode == 200) {
        print(response.data);
        return (response.data as List)
            .map((stationJson) => StationPosition.fromJson(stationJson))
            .toList();
      } else {
        throw Exception("erreur lors de la récupération des stations");
      }
    } on DioException catch (e) {
      log('API Error: ${e.message}');
      throw "Failed to load stations: ${e.response?.data?['error'] ?? e.message}";
    } catch (e) {
      log('Unexpected error: $e');
      throw "An unexpected error occurred";
    }
  }
}
