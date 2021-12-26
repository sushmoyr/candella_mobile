import 'package:candella/app/data/controllers/profile_screen_controller.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:candella/app/services/file_service.dart';
import 'package:get/get.dart';

class ProfileScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FileService());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => ProfileScreenController(Get.find<UserService>()));
  }
}
