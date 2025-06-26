// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BusPosition _$BusPositionFromJson(Map<String, dynamic> json) => BusPosition(
      id: json['id'] as String?,
      position: json['position'] == null
          ? null
          : LatLng.fromJson(json['position'] as Map<String, dynamic>),
      heading: (json['heading'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BusPositionToJson(BusPosition instance) =>
    <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'heading': instance.heading,
    };
