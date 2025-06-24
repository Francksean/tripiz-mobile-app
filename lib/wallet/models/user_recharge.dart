// user_recharge.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:tripiz_app/wallet/enum/transaction_type.dart';
import 'package:tripiz_app/wallet/models/user_transaction.dart';

part 'user_recharge.g.dart';

@JsonSerializable()
class UserRecharge extends UserTransaction {
  String? rechargerNumber;

  UserRecharge({this.rechargerNumber, super.type, super.amount, super.date});

  factory UserRecharge.fromJson(Map<String, dynamic> json) =>
      _$UserRechargeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserRechargeToJson(this);

  UserRecharge copyWith({String? rechargerNumber}) {
    return UserRecharge(
      rechargerNumber: rechargerNumber ?? this.rechargerNumber,
      type: type,
      amount: amount,
      date: date,
    );
  }

  @override
  String toString() =>
      'Recharge: ${amount?.toStringAsFixed(2)}XAF via $rechargerNumber';
}
