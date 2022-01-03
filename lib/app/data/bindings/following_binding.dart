import 'package:candella/app/data/controllers/following_controller.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:get/get.dart';

class FollowingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserService());
    Get.lazyPut(
      () => FollowingController(
        Get.find(),
      ),
    );
  }
}
