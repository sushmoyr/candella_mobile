import 'package:candella/app/data/models/success.dart';
import 'package:candella/app/data/models/interfaces/api_result.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:get/get.dart';

class AuthService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoints.baseUrl;
  }

  Future<Response<ApiResult>> login(body) {
    return post(EndPoints.login, body, decoder: (obj) => Success.fromJson(obj));
  }

  Future<Response<ApiResult>> register(body) {
    return post(EndPoints.create, body,
        decoder: (obj) => Success.fromJson(obj));
  }
}
