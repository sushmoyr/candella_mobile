import 'package:candella/app/data/bindings/auth_binding.dart';
import 'package:candella/app/data/bindings/create_content_binding.dart';
import 'package:candella/app/data/bindings/extras_binding.dart';
import 'package:candella/app/data/bindings/home_screen_binding.dart';
import 'package:candella/app/data/bindings/main_screen_binding.dart';
import 'package:candella/app/data/bindings/profile_screen_binding.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:candella/app/ui/screens/add_chapter.dart';
import 'package:candella/app/ui/screens/auth_page.dart';
import 'package:candella/app/ui/screens/create_content_screen.dart';
import 'package:candella/app/ui/screens/edit_profile_screen.dart';
import 'package:candella/app/ui/screens/extras_screen.dart';
import 'package:candella/app/ui/screens/genre_selector.dart';
import 'package:candella/app/ui/screens/main/home_screen.dart';
import 'package:candella/app/ui/screens/main/main_screen.dart';
import 'package:candella/app/ui/screens/profile_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppPages {
  static String initialRoute = _getInitialRoute();

  static final routes = [
    GetPage(
      name: Routes.auth,
      page: () => AuthPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.main,
      page: () => MainScreen(),
      binding: MainScreenBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: Routes.createContent,
      page: () => CreateContentScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.decelerate,
      binding: CreateContentBinding(),
    ),
    GetPage(
      name: Routes.profile,
      page: () => ProfileScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.decelerate,
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: Routes.editProfile,
      page: () => EditProfile(),
      transition: Transition.rightToLeft,
      curve: Curves.decelerate,
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: Routes.extras,
      page: () => ExtrasScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.decelerate,
      binding: ExtrasBinding(),
    ),
    GetPage(
      name: Routes.selectGenre,
      page: () => GenreSelector(),
      transition: Transition.downToUp,
      curve: Curves.decelerate,
    ),
    GetPage(
      name: Routes.addChapter,
      page: () => AddChapterScreen(),
      transition: Transition.rightToLeft,
      curve: Curves.decelerate,
    )
  ];

  static String _getInitialRoute() {
    final token = Prefs.getToken();
    if (token != null) {
      return Routes.main;
    }
    return Routes.auth;
  }
}
