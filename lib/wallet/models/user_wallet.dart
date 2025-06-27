// user_wallet.dart
import 'package:json_annotation/json_annotation.dart';
import 'package:tripiz_app/wallet/models/user_transaction.dart';

part 'user_wallet.g.dart';

@JsonSerializable()
class UserWallet {
  double? balance;
  List<UserTransaction>? transactions;

  UserWallet({this.balance, this.transactions});

  factory UserWallet.fromJson(Map<String, dynamic> json) =>
      _$UserWalletFromJson(json);

  Map<String, dynamic> toJson() => _$UserWalletToJson(this);

  UserWallet copyWith({double? balance, List<UserTransaction>? transactions}) {
    return UserWallet(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
    );
  }
}
