import 'package:json_annotation/json_annotation.dart';

part 'recharge_request.g.dart';

@JsonSerializable()
class RechargeRequest {
  final String? walletId;
  final double? amount;
  final String? phone;
  final String? channel;

  RechargeRequest({
    required this.walletId,
    required this.amount,
    required this.phone,
    required this.channel,
  });

  factory RechargeRequest.fromJson(Map<String, dynamic> json) =>
      _$RechargeRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RechargeRequestToJson(this);
}
