import 'package:candella/app/data/controllers/create_content_controller.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:candella/app/services/file_service.dart';
import 'package:get/get.dart';

class CreateContentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentService>(() => ContentService());
    Get.lazyPut<FileService>(() => FileService());
    Get.lazyPut<CreateContentController>(
      () => CreateContentController(
        Get.find<ContentService>(),
        Get.find<FileService>(),
      ),
    );
  }
}
