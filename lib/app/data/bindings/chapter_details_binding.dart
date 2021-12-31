import 'package:candella/app/data/controllers/chapter_details_controller.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class ChapterDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContentService());
    Get.lazyPut(
      () => ChapterController(
        Get.find<ContentService>(),
      ),
    );
  }
}
