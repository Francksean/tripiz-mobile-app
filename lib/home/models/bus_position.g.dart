// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusPosition _$BusPositionFromJson(Map<String, dynamic> json) => BusPosition(
      busId: json['busId'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$BusPositionToJson(BusPosition instance) =>
    <String, dynamic>{
      'busId': instance.busId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
