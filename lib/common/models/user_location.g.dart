// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLocation _$UserLocationFromJson(Map<String, dynamic> json) => UserLocation(
      city: json['city'] as String?,
      conuntry: json['conuntry'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      heading: (json['heading'] as num?)?.toDouble(),
      accuracy: (json['accuracy'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserLocationToJson(UserLocation instance) =>
    <String, dynamic>{
      'city': instance.city,
      'conuntry': instance.conuntry,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'heading': instance.heading,
      'accuracy': instance.accuracy,
    };
