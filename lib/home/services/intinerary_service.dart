// itinerary_service.dart
import 'dart:convert';
import 'package:tripiz_app/common/dio/dio_client.dart';
import 'package:tripiz_app/home/models/itinerary_from_station.dart';

class ItineraryService {
  final DioClient _dioClient = DioClient.instance;

  ItineraryService();

  Future<List<ItineraryFromStation>> getItinerariesFromStation(
    String stationId,
  ) async {
    final response = await _dioClient.dio.get(
      "/itinerary/getStation/$stationId",
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      print("88888888888888888888888888888");
      return data.map((json) => ItineraryFromStation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load itineraries: ${response.statusCode}');
    }
  }
}
