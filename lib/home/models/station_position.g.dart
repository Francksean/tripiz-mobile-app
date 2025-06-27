// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationPosition _$StationPositionFromJson(Map<String, dynamic> json) =>
    StationPosition(
      stationId: json['stationId'] as String?,
      stationName: json['stationName'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StationPositionToJson(StationPosition instance) =>
    <String, dynamic>{
      'stationId': instance.stationId,
      'stationName': instance.stationName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
