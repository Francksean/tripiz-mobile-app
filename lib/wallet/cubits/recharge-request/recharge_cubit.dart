import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tripiz_app/wallet/models/recharge_request.dart';
import 'package:tripiz_app/wallet/services/recharge_service.dart';

part 'recharge_state.dart';

class RechargeCubit extends Cubit<RechargeState> {
  final RechargeService rechargeService = RechargeService();

  RechargeCubit() : super(RechargeInitial());

  void performRecharge(RechargeRequest request) async {
    emit(RechargeLoading());
    try {
      final response = await rechargeService.rechargeWallet(request);
      emit(RechargeSuccess(response.data));
    } catch (e) {
      emit(RechargeFailure(e.toString()));
    }
  }
}
