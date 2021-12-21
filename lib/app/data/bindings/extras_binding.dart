import 'package:candella/app/data/controllers/extras_controller.dart';
import 'package:get/get.dart';

class ExtrasBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExtrasController());
  }
}
