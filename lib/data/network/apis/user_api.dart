import 'package:injectable/injectable.dart';
import 'package:wiber_mobile/data/dio_client.dart';

@lazySingleton
class UserApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  UserApi(this._dioClient);

  Future<String> getUserNickname() async {
    try {
      var res = "위버";
      return res;
    } catch (error) {
      print(
        error.toString(),
      );
      rethrow;
    }
  }
}
