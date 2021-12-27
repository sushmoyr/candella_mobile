import 'dart:convert';

import 'package:candella/app/resources/constants/typedefs.dart';

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
