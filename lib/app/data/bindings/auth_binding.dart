import 'package:candella/app/data/controllers/auth_controller.dart';
import 'package:candella/app/services/auth_service.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<AuthController>(() => AuthController(Get.find()));
  }
}
