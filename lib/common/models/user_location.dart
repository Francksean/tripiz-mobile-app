import 'package:json_annotation/json_annotation.dart';

part "user_location.g.dart";

@JsonSerializable()
class UserLocation {
  String? city;
  String? conuntry;
  double? latitude;
  double? longitude;
  double? heading;
  double? accuracy;

  UserLocation({
    required this.city,
    required this.conuntry,
    required this.latitude,
    required this.longitude,
    this.heading,
    this.accuracy,
  });

  UserLocation copyWith({
    String? city,
    String? conuntry,
    double? latitude,
    double? longitude,
    double? heading,
    double? accuracy,
  }) {
    return UserLocation(
      city: city ?? this.city,
      conuntry: conuntry ?? this.conuntry,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      heading: heading ?? this.heading,
      accuracy: accuracy ?? this.accuracy,
    );
  }

  /// Factory method pour générer une instance de `UserLocation` depuis un JSON.
  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);

  /// Méthode pour convertir une instance de `UserLocation` en JSON.
  Map<String, dynamic> toJson() => _$UserLocationToJson(this);
}
