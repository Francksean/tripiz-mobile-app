import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'payment_info.g.dart';

@JsonSerializable()
class PaymentInfo {
  final String tripId;
  final String walletId;
  final double amount;

  PaymentInfo({
    required this.tripId,
    required this.walletId,
    required this.amount,
  });

  String toJsonString() {
    return jsonEncode(toJson());
  }

  // Méthode fromJson générée par json_serializable
  factory PaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoFromJson(json);

  // Méthode toJson générée par json_serializable
  Map<String, dynamic> toJson() => _$PaymentInfoToJson(this);
}
