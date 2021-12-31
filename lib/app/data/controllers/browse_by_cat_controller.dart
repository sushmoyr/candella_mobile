import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class BrowseByCatController extends GetxController {
  final ContentService contentService;
  final Category currentCategory;

  BrowseByCatController({
    required this.contentService,
    required this.currentCategory,
  });

  @override
  void onInit() {
    currentCategory.toJson().toString().printInfo();
    super.onInit();
  }
}
