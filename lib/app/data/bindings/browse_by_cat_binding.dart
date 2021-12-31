import 'package:candella/app/data/controllers/BrowseScreenController.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class BrowseByCategoryBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => ContentService());
    Get.lazyPut(
      () => BrowseScreenController(
        Get.find<ContentService>(),
      ),
    );
  }
}
