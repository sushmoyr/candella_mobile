import 'package:candella/app/data/controllers/create_content_controller.dart';
import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/ui/widgets/loader.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class GenreSelector extends GetView<CreateContentController> {
  const GenreSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Select Genre',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    AppIconButton(
                        onTap: () {
                          Get.back();
                        },
                        iconData: Ionicons.close_outline)
                  ],
                ),
                Expanded(
                  child: Loader(
                    isLoading: controller.loadingGenre.value,
                    child: (controller.genreData.isEmpty)
                        ? _showEmpty()
                        : _showGenreList(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _showEmpty() {
    return Center(
      child: Text('No genre found. Try Again!!'),
    );
  }

  Widget _showGenreList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: controller.genreData.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(
          controller.genreData[index].name,
        ),
        onTap: () {
          Genre tappedGenre = controller.genreData[index];
          print('Tapped ${tappedGenre.name}');
          if (!controller.addedGenres.contains(tappedGenre)) {
            controller.addedGenres.add(tappedGenre);
          }
          Get.back();
        },
      ),
    );
  }
}
