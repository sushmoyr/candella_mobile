import 'package:candella/app/data/controllers/main_screen_controller.dart';
import 'package:candella/app/ui/screens/extras_screen.dart';
import 'package:candella/app/ui/screens/main/browse_screen.dart';
import 'package:candella/app/ui/screens/main/home_screen.dart';
import 'package:candella/app/ui/screens/main/search_screen.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class MainScreen extends GetView<MainScreenController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          physics: ScrollPhysics(
            parent: NeverScrollableScrollPhysics(),
          ),
          children: [
            Get.find<HomeScreen>(),
            Get.find<BrowseScreen>(),
            Get.find<SearchScreen>(),
            Get.find<ExtrasScreen>(),
          ],
          controller: controller.pageController,
        ),
      ),
      bottomNavigationBar: Obx(() => FancyBottomNavigation(
            tabs: [
              TabData(
                iconData: Ionicons.home_outline,
                title: 'Home',
              ),
              TabData(
                iconData: Ionicons.planet_outline,
                title: 'Browse',
              ),
              TabData(
                iconData: Ionicons.search_outline,
                title: 'Search',
              ),
              TabData(
                iconData: Ionicons.menu_outline,
                title: 'Menu',
              ),
            ],
            onTabChangedListener: (index) {
              controller.currentIndex.value = index;
              controller.pageController.jumpToPage(index);
            },
            initialSelection: controller.currentIndex.value,
            key: controller.bottomNavigationKey,
          )),
    );
  }
}
