// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_from_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItineraryFromStation _$ItineraryFromStationFromJson(
        Map<String, dynamic> json) =>
    ItineraryFromStation(
      itineraryId: json['itineraryId'] as String?,
      routeName: json['routeName'] as String?,
      direction: json['direction'] as String?,
      itineraryName: json['itineraryName'] as String?,
      estimatedDuration: (json['estimatedDuration'] as num?)?.toInt(),
      departureStation: json['departureStation'] as String?,
      arrivalStation: json['arrivalStation'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ItineraryFromStationToJson(
        ItineraryFromStation instance) =>
    <String, dynamic>{
      'itineraryId': instance.itineraryId,
      'routeName': instance.routeName,
      'direction': instance.direction,
      'itineraryName': instance.itineraryName,
      'estimatedDuration': instance.estimatedDuration,
      'departureStation': instance.departureStation,
      'arrivalStation': instance.arrivalStation,
      'distance': instance.distance,
    };
