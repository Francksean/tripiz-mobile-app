import 'package:flutter/material.dart';
import 'package:tripiz_app/common/constants/app_colors.dart';
import 'package:tripiz_app/common/constants/font_sizes.dart';
import 'package:tripiz_app/wallet/enum/transaction_type.dart';
import 'package:tripiz_app/wallet/models/user_expense.dart';
import 'package:tripiz_app/wallet/models/user_recharge.dart';
import 'package:tripiz_app/wallet/models/user_transaction.dart';

class TransactionUnitCard extends StatelessWidget {
  final UserTransaction transaction;
  const TransactionUnitCard({required this.transaction, super.key});

  @override
  Widget build(BuildContext context) {
    final isRecharge = transaction.transactionType == TransactionType.RECHARGE;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 15,
        children: [
          Icon(
            isRecharge ? Icons.autorenew : Icons.credit_card,
            color: isRecharge ? Colors.green : Colors.blue,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      isRecharge ? 'Recharge' : 'Dépense',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),

                    Text(
                      '${transaction.timestamp!.hour}:${transaction.timestamp!.minute}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(() {
                        if (transaction is UserRecharge) {
                          return 'Via ${(transaction as UserRecharge).rechargerNumber}';
                        } else if (transaction is UserExpense) {
                          final expense = transaction as UserExpense;
                          return '${expense.departure ?? '—'} → ${expense.arrival ?? '—'}';
                        } else {
                          return 'Transaction';
                        }
                      }(), overflow: TextOverflow.ellipsis),
                    ),
                    Text(
                      '${transaction.transactionType == TransactionType.RECHARGE ? '+' : '-'}${transaction.amount?.toStringAsFixed(0) ?? '0'} Fcfa',
                      style: TextStyle(
                        color:
                            transaction.transactionType ==
                                    TransactionType.RECHARGE
                                ? Colors.green
                                : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: FontSizes.lowerLarge,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
