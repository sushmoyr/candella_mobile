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

  Future<Response<User>> getUserFromId(String id) {
    return get(
      "${EndPoints.info}/$id",
      decoder: (json) => User.fromJson(json),
    );
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
