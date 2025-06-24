import 'package:tripiz_app/common/dio/dio_client.dart';
import 'package:tripiz_app/wallet/enum/transaction_type.dart';
import 'package:tripiz_app/wallet/models/user_expense.dart';
import 'package:tripiz_app/wallet/models/user_recharge.dart';
import 'package:tripiz_app/wallet/models/user_wallet.dart';

class WalletService {
  final dioClient = DioClient.instance;

  Future<UserWallet> getWallet() async {
    // TODO : implémenter la fonction de requête à l'api
    // HACK : données hardcoded pour le moment
    UserWallet fakeWallet = UserWallet(
      balance: 125,
      transactions: [
        // Recharges
        UserRecharge(
          rechargerNumber: '+33612345678',
          amount: 3000.0,
          date: DateTime.now().subtract(Duration(days: 2)),
          type: TransactionType.recharge,
        ),
        UserRecharge(
          rechargerNumber: '+33612345678',
          amount: 3000.0,
          date: DateTime.now(),
          type: TransactionType.recharge,
        ),
        UserRecharge(
          rechargerNumber: '+33687654321',
          amount: 2000.0,
          date: DateTime.now().subtract(Duration(days: 4)),
          type: TransactionType.recharge,
        ),

        // Dépenses
        UserExpense(
          departure: 'Paris',
          arrival: 'Lyon',
          amount: 500,
          date: DateTime.now(),
          type: TransactionType.depense,
        ),
        UserExpense(
          departure: 'Ndokoti',
          arrival: 'Akwa',
          amount: 500,
          date: DateTime.now(),
          type: TransactionType.depense,
        ),
        UserExpense(
          departure: 'Yassa',
          arrival: 'Ndokoti',
          amount: 200,
          date: DateTime.now().subtract(Duration(days: 1)),
          type: TransactionType.depense,
        ),
        UserExpense(
          departure: 'Ndokoti',
          arrival: 'Yassa',
          amount: 200,
          date: DateTime.now().subtract(Duration(days: 1)),
          type: TransactionType.depense,
        ),
        UserExpense(
          departure: 'Yassa',
          arrival: 'Akwa',
          amount: 400,
          date: DateTime.now().subtract(Duration(days: 3)),
          type: TransactionType.depense,
        ),
        UserExpense(
          departure: 'Akwa',
          arrival: 'Bonamoussadi',
          amount: 200,
          date: DateTime.now().subtract(Duration(days: 5)),
          type: TransactionType.depense,
        ),
      ],
    );
    return fakeWallet;
  }
}
