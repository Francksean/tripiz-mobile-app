// wallet_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripiz_app/wallet/enum/transaction_type.dart';
import 'package:tripiz_app/wallet/models/user_transaction.dart';
import 'package:tripiz_app/wallet/models/user_wallet.dart';
import 'package:tripiz_app/wallet/services/wallet_service.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final WalletService _walletService = WalletService();

  WalletCubit() : super(WalletInitial());

  Future<void> loadWallet() async {
    emit(WalletLoading());
    try {
      final wallet = await _walletService.getWallet();
      final grouped = _groupTransactionsByDate(wallet.transactions!);
      emit(WalletLoaded(wallet, grouped));
    } catch (e) {
      emit(WalletError('Failed to load wallet: ${e.toString()}'));
    }
  }

  // FIXME : la fonction pour trier ne fonctionne pas
  void sortTransactionsByType(TransactionType? type) {
    final currentState = state;
    if (currentState is WalletLoaded) {
      final transactions = currentState.wallet.transactions!;

      // Appliquer le tri
      final sortedTransactions =
          type != null
              ? _sortTransactionsByType(transactions, type)
              : transactions;

      final grouped = _groupTransactionsByDate(sortedTransactions);
      emit(WalletLoaded(currentState.wallet, grouped));
    }
  }

  List<UserTransaction> _sortTransactionsByType(
    List<UserTransaction> transactions,
    TransactionType type,
  ) {
    return transactions.where((t) => t.type == type).toList()
      ..addAll(transactions.where((t) => t.type != type).toList());
  }

  Map<DateTime, List<UserTransaction>> _groupTransactionsByDate(
    List<UserTransaction> transactions,
  ) {
    final Map<DateTime, List<UserTransaction>> grouped = {};

    for (final transaction in transactions) {
      final date = DateTime(
        transaction.date!.year,
        transaction.date!.month,
        transaction.date!.day,
      );

      if (grouped.containsKey(date)) {
        grouped[date]!.add(transaction);
      } else {
        grouped[date] = [transaction];
      }
    }

    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return Map.fromEntries(
      sortedKeys.map((key) => MapEntry(key, grouped[key]!)),
    );
  }
}
