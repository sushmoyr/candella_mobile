import 'package:candella/app/data/controllers/browse_by_cat_controller.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrowseByCategory extends StatelessWidget {
  BrowseByCategory({Key? key}) : super(key: key);

  final Category _category = Get.arguments;
  final BrowseByCatController controller = BrowseByCatController(
    contentService: Get.find(),
    currentCategory: Get.arguments,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(_category.name),
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        body: SafeArea(
          child: Center(
            child: Text(controller.currentCategory.name),
          ),
        ));
  }
}
