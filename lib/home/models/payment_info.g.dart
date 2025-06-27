// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentInfo _$PaymentInfoFromJson(Map<String, dynamic> json) => PaymentInfo(
      tripId: json['tripId'] as String,
      walletId: json['walletId'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$PaymentInfoToJson(PaymentInfo instance) =>
    <String, dynamic>{
      'tripId': instance.tripId,
      'walletId': instance.walletId,
      'amount': instance.amount,
    };
