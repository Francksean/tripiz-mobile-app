part of 'recharge_cubit.dart';

abstract class RechargeState {}

class RechargeInitial extends RechargeState {}

class RechargeLoading extends RechargeState {}

class RechargeSuccess extends RechargeState {
  final dynamic response;
  RechargeSuccess(this.response);
}

class RechargeFailure extends RechargeState {
  final String error;
  RechargeFailure(this.error);
}
