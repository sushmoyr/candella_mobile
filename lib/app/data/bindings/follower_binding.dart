import 'package:candella/app/data/controllers/follower_controller.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:get/get.dart';

class FollowerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserService());
    Get.lazyPut(
      () => FollowerController(
        Get.find(),
      ),
    );
  }
}
