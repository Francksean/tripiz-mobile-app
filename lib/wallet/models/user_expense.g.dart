// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserExpense _$UserExpenseFromJson(Map<String, dynamic> json) => UserExpense(
      departure: json['departure'] as String?,
      arrival: json['arrival'] as String?,
      transactionType: $enumDecodeNullable(
          _$TransactionTypeEnumMap, json['transactionType']),
      amount: (json['amount'] as num?)?.toDouble(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$UserExpenseToJson(UserExpense instance) =>
    <String, dynamic>{
      'transactionType': _$TransactionTypeEnumMap[instance.transactionType],
      'amount': instance.amount,
      'timestamp': instance.timestamp?.toIso8601String(),
      'departure': instance.departure,
      'arrival': instance.arrival,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.SPENDING: 'SPENDING',
  TransactionType.RECHARGE: 'RECHARGE',
};
