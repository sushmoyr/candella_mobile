import 'package:candella/app/data/controllers/BrowseScreenController.dart';
import 'package:candella/app/data/controllers/home_screen_controller.dart';
import 'package:candella/app/data/controllers/main_screen_controller.dart';
import 'package:candella/app/data/controllers/profile_screen_controller.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:candella/app/ui/screens/main/browse_screen.dart';
import 'package:candella/app/ui/screens/main/home_screen.dart';
import 'package:get/get.dart';

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserService>(() => UserService());
    Get.lazyPut<ContentService>(() => ContentService());
    Get.lazyPut<HomeScreen>(() => HomeScreen());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut(() => BrowseScreen());
    Get.lazyPut(
      () => BrowseScreenController(
        Get.find<ContentService>(),
      ),
    );
    Get.lazyPut<ProfileScreenController>(
      () => ProfileScreenController(
        Get.find<UserService>(),
      ),
    );

    Get.lazyPut<MainScreenController>(() => MainScreenController());
  }
}
