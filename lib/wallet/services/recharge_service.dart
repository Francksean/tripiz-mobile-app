import 'package:dio/dio.dart';
import 'package:tripiz_app/common/dio/dio_client.dart';
import 'package:tripiz_app/wallet/models/recharge_request.dart';

class RechargeService {
  final DioClient dioClient = DioClient.instance;

  RechargeService();

  Future<Response> rechargeWallet(RechargeRequest request) async {
    try {
      final response = await dioClient.dio.post(
        '/transactions/recharge',
        data: request.toJson(),
      );
      return response;
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Erreur de recharge');
    }
  }
}
