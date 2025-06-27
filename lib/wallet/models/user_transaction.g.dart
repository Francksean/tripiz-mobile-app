// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransaction _$UserTransactionFromJson(Map<String, dynamic> json) =>
    UserTransaction(
      transactionType: $enumDecodeNullable(
          _$TransactionTypeEnumMap, json['transactionType']),
      amount: (json['amount'] as num?)?.toDouble(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$UserTransactionToJson(UserTransaction instance) =>
    <String, dynamic>{
      'transactionType': _$TransactionTypeEnumMap[instance.transactionType],
      'amount': instance.amount,
      'timestamp': instance.timestamp?.toIso8601String(),
    };

const _$TransactionTypeEnumMap = {
  TransactionType.SPENDING: 'SPENDING',
  TransactionType.RECHARGE: 'RECHARGE',
};
