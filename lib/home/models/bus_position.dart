import 'package:json_annotation/json_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'bus_position.g.dart';

@JsonSerializable()
class BusPosition {
  final String? id;
  final LatLng? position;
  final double? heading;

  BusPosition({
    required this.id,
    required this.position,
    required this.heading,
  });

  BusPosition copyWith({
    String? id,
    LatLng? position,
    double? heading,
    DateTime? lastUpdate,
  }) {
    return BusPosition(
      id: id ?? this.id,
      position: position ?? this.position,
      heading: heading ?? this.heading,
    );
  }

  // Méthode fromJson générée par json_serializable
  factory BusPosition.fromJson(Map<String, dynamic> json) =>
      _$BusPositionFromJson(json);

  // Méthode toJson générée par json_serializable
  Map<String, dynamic> toJson() => _$BusPositionToJson(this);
}
