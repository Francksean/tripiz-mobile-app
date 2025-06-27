// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recharge_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RechargeRequest _$RechargeRequestFromJson(Map<String, dynamic> json) =>
    RechargeRequest(
      walletId: json['walletId'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      phone: json['phone'] as String?,
      channel: json['channel'] as String?,
    );

Map<String, dynamic> _$RechargeRequestToJson(RechargeRequest instance) =>
    <String, dynamic>{
      'walletId': instance.walletId,
      'amount': instance.amount,
      'phone': instance.phone,
      'channel': instance.channel,
    };
