// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_recharge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRecharge _$UserRechargeFromJson(Map<String, dynamic> json) => UserRecharge(
      rechargerNumber: json['rechargerNumber'] as String?,
      transactionType: $enumDecodeNullable(
          _$TransactionTypeEnumMap, json['transactionType']),
      amount: (json['amount'] as num?)?.toDouble(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$UserRechargeToJson(UserRecharge instance) =>
    <String, dynamic>{
      'transactionType': _$TransactionTypeEnumMap[instance.transactionType],
      'amount': instance.amount,
      'timestamp': instance.timestamp?.toIso8601String(),
      'rechargerNumber': instance.rechargerNumber,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.SPENDING: 'SPENDING',
  TransactionType.RECHARGE: 'RECHARGE',
};
