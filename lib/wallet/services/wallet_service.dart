import 'package:tripiz_app/common/dio/dio_client.dart';
import 'package:tripiz_app/wallet/models/user_wallet.dart';

class WalletService {
  final dioClient = DioClient.instance;

  Future<UserWallet> getWallet(String userId) async {
    final response = await dioClient.dio.get("/wallet/me?userId=$userId");
    if (response.statusCode == 200) {
      dynamic datas = response.data;
      UserWallet userWallet = UserWallet.fromJson(datas);
      return userWallet;
    } else {
      throw Exception("Erreur lors du chargement du solder");
    }
  }
}
