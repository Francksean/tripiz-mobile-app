// itinerary_from_station.dart
import 'package:json_annotation/json_annotation.dart';

part 'itinerary_from_station.g.dart';

@JsonSerializable()
class ItineraryFromStation {
  final String? itineraryId;
  final String? routeName;
  final String? direction;
  final String? itineraryName;
  final int? estimatedDuration;
  final String? departureStation;
  final String? arrivalStation;
  final double? distance;

  ItineraryFromStation({
    required this.itineraryId,
    required this.routeName,
    this.direction,
    required this.itineraryName,
    required this.estimatedDuration,
    required this.departureStation,
    required this.arrivalStation,
    required this.distance,
  });

  factory ItineraryFromStation.fromJson(Map<String, dynamic> json) =>
      _$ItineraryFromStationFromJson(json);

  Map<String, dynamic> toJson() => _$ItineraryFromStationToJson(this);
}
