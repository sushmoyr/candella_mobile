import 'package:candella/app/data/controllers/add_chapter_controller.dart';
import 'package:get/get.dart';

class AddChapterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddChapterController());
  }
}
