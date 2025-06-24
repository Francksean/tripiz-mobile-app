// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserWallet _$UserWalletFromJson(Map<String, dynamic> json) => UserWallet(
      balance: (json['balance'] as num?)?.toInt(),
      transactions: (json['transactions'] as List<dynamic>?)
          ?.map((e) => UserTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserWalletToJson(UserWallet instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'transactions': instance.transactions,
    };
