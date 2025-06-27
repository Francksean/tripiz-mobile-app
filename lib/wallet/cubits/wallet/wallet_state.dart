// wallet_state.dart
part of 'wallet_cubit.dart';

abstract class WalletState {
  final TransactionType? activeSortType;
  const WalletState({this.activeSortType});
}

class WalletInitial extends WalletState {
  const WalletInitial() : super(activeSortType: null);
}

class WalletLoading extends WalletState {
  const WalletLoading() : super(activeSortType: null);
}

class WalletLoaded extends WalletState {
  final UserWallet wallet;
  final Map<DateTime, List<UserTransaction>> groupedTransactions;

  const WalletLoaded(
    this.wallet,
    this.groupedTransactions, {
    super.activeSortType,
  });
}

class WalletError extends WalletState {
  final String message;
  const WalletError(this.message) : super(activeSortType: null);
}
