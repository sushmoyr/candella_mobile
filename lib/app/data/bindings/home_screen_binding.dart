import 'package:candella/app/data/controllers/home_screen_controller.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContentService>(() => ContentService());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
