// user_transaction.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:tripiz_app/wallet/enum/transaction_type.dart';

part 'user_transaction.g.dart';

@JsonSerializable()
class UserTransaction {
  TransactionType? transactionType;
  double? amount;
  DateTime? timestamp;

  UserTransaction({this.transactionType, this.amount, this.timestamp});

  factory UserTransaction.fromJson(Map<String, dynamic> json) =>
      _$UserTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$UserTransactionToJson(this);
}
