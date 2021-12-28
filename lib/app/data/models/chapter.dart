import 'dart:convert';

import 'package:candella/app/resources/constants/typedefs.dart';

import 'author.dart';

abstract class ChapterBody {
  Map<String, dynamic> toJson();
}

class Chapter {
  final Author author;
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
    Category category = Category.fromJson(json['category']);

    if (category == Category.photography) {
      body = PhotographyChapterBody.fromJson(json['body']);
    } else if (category == Category.comic) {
      body = ComicChapterBody.fromJson(json['body']);
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

  Map<String, dynamic> toJson() {
    return {
      "author": author.toJson(),
      "category": category,
      "chapterName": chapterName,
      "contentId": contentId,
      "body": body.toJson(),
    };
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

class ComicChapterBody implements ChapterBody {
  final List<String> pages;

  const ComicChapterBody({required this.pages});

  factory ComicChapterBody.fromJson(Map<String, dynamic> json) =>
      ComicChapterBody(pages: json['pages']);

  @override
  Map<String, dynamic> toJson() => {"pages": pages};
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

  @override
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
  final String data;

  factory DefaultChapterBody.fromJson(Map<String, dynamic> json) =>
      DefaultChapterBody(json['data']);

  DefaultChapterBody(this.data);

  @override
  Map<String, dynamic> toJson() => {"data": data};
}
