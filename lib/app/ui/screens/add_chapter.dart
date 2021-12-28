import 'dart:io';

import 'package:candella/app/data/controllers/add_chapter_controller.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/ui/screens/error_page.dart';
import 'package:candella/app/ui/widgets/loader.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:candella/app/ui/widgets/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:ionicons/ionicons.dart';

class AddChapterScreen extends GetView<AddChapterController> {
  AddChapterScreen({Key? key}) : super(key: key);
  final String contentCategory = Get.arguments['category'];
  final String contentId = Get.arguments['contentId'];

  @override
  Widget build(BuildContext context) {
    printInfo(info: contentCategory);
    Category category = getCategoryById(contentCategory);
    List<Widget> editor;
    if (category == Category.photography) {
      editor = _getPhotographyChapter();
      controller.mode = ChapterMode.photography;
    } else if (category == Category.comic) {
      editor = _getComicChapter();
      controller.mode = ChapterMode.comic;
    } else {
      editor = _getDefaultChapter();
      controller.mode = ChapterMode.other;
    }

    printInfo(info: controller.mode.name);

    return Scaffold(
      body: SafeArea(
          child: Obx(
        () => Loader(
          isLoading: controller.loading.value,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TitleOnlyAppbar(
                  title: 'Add content to your ${category.name}',
                  trailing: Icon(Ionicons.close_outline),
                  onTap: () {
                    Get.back();
                  },
                ),
                ..._getCommonWidgets(),
                ...editor,
                Align(
                  alignment: Alignment.centerRight,
                  child: AppIconButton(
                    buttonSize: 48,
                    mode: IconButtonMode.rounded,
                    iconData: Ionicons.add,
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                    onTap: _uploadImage,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppIconButton(
                    mode: IconButtonMode.rounded,
                    iconData: Ionicons.arrow_forward,
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                    onTap: _uploadChapter,
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  List<Widget> _getDefaultChapter() {
    return [
      SizedBox(height: 16),
      Expanded(
        child: TextFormField(
          scrollPhysics: BouncingScrollPhysics(),
          controller: controller.defaultChapterContent,
          expands: true,
          minLines: null,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Start writing here...',
          ),
        ),
      ),
    ];
  }

  List<Widget> _getComicChapter() {
    return [
      Expanded(
        child: ComicImageInput(
          links: controller.comicInputs,
          onClose: (link) {
            controller.comicInputs.removeWhere((element) => element == link);
            printInfo(info: controller.comicInputs.length.toString());
          },
        ),
      ),
    ];
  }

  List<Widget> _getPhotographyChapter() {
    return [
      TextFormField(
        controller: controller.photoChapterDescription,
        decoration: InputDecoration(
          labelText: 'Description',
        ),
      ),
      Expanded(
        child: PhotoContentList(
            links: controller.imageInputs,
            onClose: (v) {
              controller.imageInputs.removeWhere((element) => element == v);
            }),
      ),
    ];
  }

  void _uploadImage() async {
    var picker = await ImagesPicker.pick(
      count: 10,
    );

    if (picker != null) {
      controller.addImagesPath(
        picker.map((e) => e.path).toList(),
      );
    }
  }

  List<Widget> _getCommonWidgets() {
    return [
      TextFormField(
        controller: controller.chapterTitle,
        decoration: InputDecoration(
          labelText: 'Chapter Title',
        ),
        validator: (v) {
          if (v == null || v.isEmpty) {
            return '*Required Field';
          }
          return null;
        },
      ),
    ];
  }

  void _uploadChapter() async {
    controller.loading(true);
    var result = await controller.addChapter(contentCategory, contentId);
    printInfo(info: result.message);
    controller.loading(false);
    if (result.status) {
      Get.offAllNamed(Routes.main);
    } else {
      Get.to(() => ErrorScreen());
    }
  }
}

class ComicImageInput extends StatelessWidget {
  final List<String> links;
  final Function(String) onClose;

  const ComicImageInput({Key? key, required this.links, required this.onClose})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ...links.map(
              (element) =>
                  _ComicImageInputItem(imageUrl: element, onTap: onClose),
            ),
          ],
        ));
  }
}

class _ComicImageInputItem extends StatelessWidget {
  final String imageUrl;
  final Function(String) onTap;

  const _ComicImageInputItem(
      {Key? key, required this.imageUrl, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(File(imageUrl)),
        Align(
          alignment: Alignment.topRight,
          child: AppIconButton(
            onTap: () {
              onTap(imageUrl);
            },
            iconData: Ionicons.trash_bin_outline,
            elevation: 8,
          ),
        ),
      ],
    );
  }
}

class PhotoContentList extends StatelessWidget {
  const PhotoContentList({
    Key? key,
    required this.links,
    required this.onClose,
  }) : super(key: key);
  final List<ImageContentInputController> links;
  final Function(ImageContentInputController) onClose;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ...links.map(
            (e) => PhotoContentCard(
              controller: e,
              onTap: onClose,
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoContentCard extends StatelessWidget {
  const PhotoContentCard(
      {Key? key, required this.controller, required this.onTap})
      : super(key: key);
  final ImageContentInputController controller;
  final Function(ImageContentInputController) onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
            child: Column(
              children: [
                Image.file(File(controller.imageUrl)),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: controller.caption,
                    decoration: InputDecoration(
                      labelText: 'Caption',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: AppIconButton(
            onTap: () {
              onTap(controller);
            },
            iconData: Ionicons.trash_bin_outline,
            elevation: 8,
          ),
        ),
      ],
    );
  }
}
