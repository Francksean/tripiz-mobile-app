// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserExpense _$UserExpenseFromJson(Map<String, dynamic> json) => UserExpense(
      departure: json['departure'] as String?,
      arrival: json['arrival'] as String?,
      type: $enumDecodeNullable(_$TransactionTypeEnumMap, json['type']),
      amount: (json['amount'] as num?)?.toDouble(),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$UserExpenseToJson(UserExpense instance) =>
    <String, dynamic>{
      'type': _$TransactionTypeEnumMap[instance.type],
      'amount': instance.amount,
      'date': instance.date?.toIso8601String(),
      'departure': instance.departure,
      'arrival': instance.arrival,
    };

const _$TransactionTypeEnumMap = {
  TransactionType.depense: 'depense',
  TransactionType.recharge: 'recharge',
};
