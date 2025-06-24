// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransaction _$UserTransactionFromJson(Map<String, dynamic> json) =>
    UserTransaction(
      type: $enumDecodeNullable(_$TransactionTypeEnumMap, json['type']),
      amount: (json['amount'] as num?)?.toDouble(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$UserTransactionToJson(UserTransaction instance) =>
    <String, dynamic>{
      'type': _$TransactionTypeEnumMap[instance.type],
      'amount': instance.amount,
      'date': instance.date?.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.depense: 'depense',
  TransactionType.recharge: 'recharge',
};
