import 'package:candella/app/data/controllers/notification_controller.dart';
import 'package:candella/app/services/notification_service.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationService());
    Get.lazyPut(
      () => NotificationController(
        Get.find(),
      ),
    );
  }
}
