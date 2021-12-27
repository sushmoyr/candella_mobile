import 'package:candella/app/resources/routes/app_pages.dart';
import 'package:candella/app/resources/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(CandellaApp());
}

class CandellaApp extends StatelessWidget {
  const CandellaApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      title: 'Candella',
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
    );
  }
}
