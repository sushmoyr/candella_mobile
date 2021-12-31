import 'package:candella/app/data/controllers/browse_by_cat_controller.dart';
import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrowseByCategory extends GetView<BrowseByCatController> {
  BrowseByCategory({Key? key}) : super(key: key);

  final Category _category = Get.arguments;

  @override
  Widget build(BuildContext context) {
    controller.currentCategory = _category;
    controller.initData();
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(controller.currentCategory.name),
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => RenderList(data: controller.contentData.value),
            ),
            Obx(
              () => Text(controller.message.value),
            ),
            TextButton(
              onPressed: () {
                controller.loadMore();
              },
              child: Text('Load More...'),
            ),
          ],
        ),
      ),
    );
  }
}

class RenderList extends StatelessWidget {
  final List<Content> data;

  const RenderList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printInfo(info: 'Render List of size ${data.length}');
    return ListView(
      shrinkWrap: true,
      children: List.from(
        data.map(
          (e) => Text(e.title),
        ),
      ),
    );
  }
}
