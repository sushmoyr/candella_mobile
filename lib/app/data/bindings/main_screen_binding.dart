import 'package:candella/app/data/bindings/home_screen_binding.dart';
import 'package:candella/app/data/controllers/home_screen_controller.dart';
import 'package:candella/app/data/controllers/main_screen_controller.dart';
import 'package:candella/app/data/controllers/profile_screen_controller.dart';
import 'package:candella/app/services/UserService.dart';
import 'package:candella/app/ui/screens/main/home_screen.dart';
import 'package:get/get.dart';

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreen>(() => HomeScreen());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<UserService>(() => UserService());
    Get.lazyPut<ProfileScreenController>(
        () => ProfileScreenController(Get.find<UserService>()));

    Get.lazyPut<MainScreenController>(() => MainScreenController());
  }
}
