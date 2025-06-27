import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'bus_position.g.dart';

@JsonSerializable()
class BusPosition {
  final String busId;
  final double latitude;
  final double longitude;

  BusPosition({
    required this.busId,
    required this.latitude,
    required this.longitude,
  });

  BusPosition copyWith({String? id, double? latitude, double? longitude}) {
    return BusPosition(
      busId: id ?? busId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  // Méthode fromJson générée par json_serializable
  factory BusPosition.fromJson(Map<String, dynamic> json) =>
      _$BusPositionFromJson(json);

  // Méthode toJson générée par json_serializable
  Map<String, dynamic> toJson() => _$BusPositionToJson(this);
}
