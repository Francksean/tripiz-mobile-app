// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_recharge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRecharge _$UserRechargeFromJson(Map<String, dynamic> json) => UserRecharge(
      rechargerNumber: json['rechargerNumber'] as String?,
      type: $enumDecodeNullable(_$TransactionTypeEnumMap, json['type']),
      amount: (json['amount'] as num?)?.toDouble(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$UserRechargeToJson(UserRecharge instance) =>
    <String, dynamic>{
      'type': _$TransactionTypeEnumMap[instance.type],
      'amount': instance.amount,
      'date': instance.date?.toIso8601String(),
      'rechargerNumber': instance.rechargerNumber,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.depense: 'depense',
  TransactionType.recharge: 'recharge',
};
