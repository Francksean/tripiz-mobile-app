import 'package:json_annotation/json_annotation.dart';

part 'station_position.g.dart';

@JsonSerializable()
class StationPosition {
  final int? id;
  final String? name;
  final double? latitude;
  final double? longitude;

  StationPosition({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  // Méthode copyWith
  StationPosition copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
  }) {
    return StationPosition(
      id: id ?? this.id,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  // Méthode fromJson générée par json_serializable
  factory StationPosition.fromJson(Map<String, dynamic> json) =>
      _$StationPositionFromJson(json);

  // Méthode toJson générée par json_serializable
  Map<String, dynamic> toJson() => _$StationPositionToJson(this);
}
