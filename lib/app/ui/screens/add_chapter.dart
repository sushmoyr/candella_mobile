import 'dart:convert';
import 'dart:io';

import 'package:candella/app/data/controllers/add_chapter_controller.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:candella/app/ui/widgets/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class AddChapterScreen extends GetView<AddChapterController> {
  AddChapterScreen({Key? key}) : super(key: key);
  final contentCategory = Get.arguments['category'];
  final contentId = Get.arguments['contentId'];

  @override
  Widget build(BuildContext context) {
    printInfo(info: contentCategory);
    Category category = getCategoryById(contentCategory);
    return Scaffold(
      body: SafeArea(
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
              ..._getPhotographyChapter(),
              Align(
                  alignment: Alignment.centerRight,
                  child: AppIconButton(
                    mode: IconButtonMode.rounded,
                    iconData: Ionicons.arrow_forward,
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                    onTap: () {},
                  ))
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getDefaultChapter() {
    return [
      SizedBox(height: 16),
      Expanded(
        child: TextFormField(
          scrollPhysics: BouncingScrollPhysics(),
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

  List<Widget> _getPhotographyChapter() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Description',
        ),
      ),
      Expanded(
        child: ListView(
          children: [
            ...controller.imageInputs.map(
              (e) => _getPhotoInputWidget(e),
            ),
            OutlinedButton(
              onPressed: _uploadImage,
              child: Text('Add Image'),
            ),
          ],
        ),
      ),
    ];
  }

  void _uploadImage() {}

  Widget _getPhotoInputWidget(ImageContentInputController e) {
    return Card(
      child: Column(
        children: [
          Image.file(File(e.imageUrl)),
          TextFormField(
            controller: e.caption,
            decoration: InputDecoration(
              labelText: 'Caption',
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getCommonWidgets() {
    return [
      TextFormField(
        controller: controller.chapterTitle,
        decoration: InputDecoration(
          labelText: 'Chapter Title',
        ),
      ),
    ];
  }
}

abstract class ChapterBody {}

class Chapter {
  final String author;
  final String category;
  final String chapterName;
  final String contentId;
  final ChapterBody body;

  Chapter(
      {required this.author,
      required this.category,
      required this.chapterName,
      required this.contentId,
      required this.body});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    ChapterBody body;
    Category category = getCategoryById(json['category']);

    if (category == Category.photography) {
      body = PhotographyChapterBody.fromJson(json['body']);
    } else {
      body = DefaultChapterBody.fromJson(json['body']);
    }

    return Chapter(
      author: json['author'],
      category: json['category'],
      chapterName: json['chapterName'],
      contentId: json['contentId'],
      body: body,
    );
  }
}

class PhotoContent {
  String caption;
  String imageUrl;

  PhotoContent({this.caption = '', required this.imageUrl});

  factory PhotoContent.fromJson(Map<String, dynamic> json) => PhotoContent(
        imageUrl: json['imageUrl'],
        caption: json['caption'],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "caption": caption,
      };
}

class PhotographyChapterBody implements ChapterBody {
  final List<PhotoContent> images;
  final String description;

  PhotographyChapterBody({required this.images, required this.description});

  factory PhotographyChapterBody.fromJson(Map<String, dynamic> json) =>
      PhotographyChapterBody(
          images: List<PhotoContent>.from(
            json['images'].map(
              (x) => PhotographyChapterBody.fromJson(x),
            ),
          ),
          description: json['description']);

  factory PhotographyChapterBody.fromRawJson(String str) =>
      PhotographyChapterBody.fromJson(jsonDecode(str));

  Map<String, dynamic> toJson() => {
        "description": description,
        "images": List<dynamic>.from(
          images.map(
            (e) => e.toJson(),
          ),
        )
      };

  String toRawJson() => jsonEncode(toJson());
}

class DefaultChapterBody implements ChapterBody {
  factory DefaultChapterBody.fromJson(Map<String, dynamic> json) =>
      DefaultChapterBody();

  DefaultChapterBody();
}
