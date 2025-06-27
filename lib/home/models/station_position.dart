import 'package:json_annotation/json_annotation.dart';

part 'station_position.g.dart';

@JsonSerializable()
class StationPosition {
  final String? stationId;
  final String? stationName;
  final double? latitude;
  final double? longitude;

  StationPosition({
    required this.stationId,
    required this.stationName,
    required this.latitude,
    required this.longitude,
  });

  // Méthode copyWith
  StationPosition copyWith({
    String? id,
    String? name,
    double? latitude,
    double? longitude,
  }) {
    return StationPosition(
      stationId: id ?? stationId,
      stationName: name ?? stationName,
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
