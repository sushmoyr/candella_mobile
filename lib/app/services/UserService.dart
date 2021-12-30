import 'package:candella/app/data/models/User.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:get/get.dart';

class UserService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoints.baseUrl;
  }

  Future<Response<User>> getUserFromToken(String token) {
    return get(
      EndPoints.info,
      headers: {
        "token": token,
      },
      decoder: (json) => User.fromJson(json),
    );
  }

  Future<Response<User>> getUserFromId(String id) async {
    String token = Prefs.getToken()!;
    printInfo(info: token);
    var data = await get(
      "${EndPoints.info}/$id",
      headers: {"token": token},
      decoder: (json) => User.fromJson(json),
    );
    data.printInfo();
    printInfo(info: data.body.toString());

    if (data.hasError) {
      return Future.error('error');
    }
    return data;
  }

  Future<Response<User>> updateAuthInfo(body) {
    var token = Prefs.getToken();
    return put(
      EndPoints.authUpdate,
      body,
      headers: {"token": token!},
      decoder: (json) => User.fromJson(json['body']),
    );
  }

  Future<Response<User>> updateUser(body) {
    var token = Prefs.getToken();
    return put(
      EndPoints.userUpdate,
      body,
      headers: {"token": token!},
      decoder: (json) => User.fromJson(body),
    );
  }
}
