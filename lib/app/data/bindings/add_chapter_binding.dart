import 'package:candella/app/data/controllers/add_chapter_controller.dart';
import 'package:candella/app/services/chapter_service.dart';
import 'package:candella/app/services/file_service.dart';
import 'package:get/get.dart';

class AddChapterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChapterService());
    Get.lazyPut(() => FileService());
    Get.lazyPut(() => AddChapterController(Get.find<ChapterService>()));
  }
}
