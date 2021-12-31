import 'package:candella/app/data/controllers/content_details_controller.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class ContentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContentService());
    Get.lazyPut(
      () => ContentDetailsController(
        Get.find<ContentService>(),
      ),
    );
  }
}
