// user_expense.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:tripiz_app/wallet/enum/transaction_type.dart';
import 'package:tripiz_app/wallet/models/user_transaction.dart';

part 'user_expense.g.dart';

@JsonSerializable()
class UserExpense extends UserTransaction {
  String? departure;
  String? arrival;

  UserExpense({
    this.departure,
    this.arrival,
    super.transactionType,
    super.amount,
    super.timestamp,
  });

  factory UserExpense.fromJson(Map<String, dynamic> json) =>
      _$UserExpenseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserExpenseToJson(this);

  UserExpense copyWith({String? departure, String? arrival}) {
    return UserExpense(
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival,
      transactionType: transactionType,
      amount: amount,
      timestamp: timestamp,
    );
  }

  @override
  String toString() =>
      'Trajet: $departure → $arrival (${amount?.toStringAsFixed(2)}XAF)';
}
