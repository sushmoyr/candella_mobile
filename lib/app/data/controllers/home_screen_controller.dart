import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final String name = 'Home';
  late PageController featurePageController;

  @override
  void onInit() {
    featurePageController = PageController(initialPage: 0);
    super.onInit();
  }
}
