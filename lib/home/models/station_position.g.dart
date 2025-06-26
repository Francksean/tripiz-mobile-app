// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationPosition _$StationPositionFromJson(Map<String, dynamic> json) =>
    StationPosition(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StationPositionToJson(StationPosition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
