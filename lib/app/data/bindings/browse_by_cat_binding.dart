import 'package:candella/app/data/controllers/BrowseScreenController.dart';
import 'package:candella/app/data/controllers/browse_by_cat_controller.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class BrowseByCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContentService());
    Get.lazyPut(() => BrowseByCatController(contentService: Get.find()));
    Get.lazyPut(
      () => BrowseScreenController(
        Get.find<ContentService>(),
      ),
    );
  }
}
