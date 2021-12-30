import 'package:candella/app/data/controllers/visitor_controller.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:get/get.dart';

class VisitorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserService());
    Get.lazyPut(
      () => VisitorController(
        Get.find<UserService>(),
      ),
    );
  }
}
