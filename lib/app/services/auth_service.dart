import 'package:candella/app/data/models/auth_response.dart';
import 'package:candella/app/data/models/success_base.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:get/get.dart';

class AuthService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoints.baseUrl;
  }
}
