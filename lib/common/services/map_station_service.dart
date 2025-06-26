import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:tripiz_app/common/dio/dio_client.dart';
import 'package:tripiz_app/home/models/station_position.dart';

class MapStationService {
  final DioClient dioClient = DioClient.instance;

  MapStationService();

  Future<List<StationPosition>> getStationsInBounds(List<double> bounds) async {
    try {
      if (bounds.length != 4) throw "Requires exactly 4 bounds points";

      final response = await dioClient.dio.get(
        '/stations',
        // TODO : finaliser l'envoi des données
      );

      return (response.data as List)
          .map((stationJson) => StationPosition.fromJson(stationJson))
          .toList();
    } on DioException catch (e) {
      log('API Error: ${e.response?.data ?? e.message}');
      throw "Failed to load stations: ${e.response?.data?['error'] ?? e.message}";
    } catch (e) {
      log('Unexpected error: $e');
      throw "An unexpected error occurred";
    }
  }
}
