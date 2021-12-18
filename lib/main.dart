import 'package:candella/app/resources/routes/app_pages.dart';
import 'package:candella/app/resources/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
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
