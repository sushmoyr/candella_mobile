import 'package:candella/app/data/bindings/auth_binding.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/ui/screens/auth_page.dart';
import 'package:get/get.dart';

class AppPages {
  static const initialRoute = Routes.auth;

  static final routes = [
    GetPage(
      name: Routes.auth,
      page: () => AuthPage(),
      binding: AuthBinding(),
    ),
  ];
}
