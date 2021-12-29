// To parse this JSON data, do
//
//     final content = contentFromJson(jsonString);

import 'dart:convert';

import 'package:candella/app/resources/constants/typedefs.dart';

import 'author.dart';
import 'genre.dart';

class Content {
  Content({
    this.id = '',
    this.author = const Author(),
    this.title = '',
    this.alternateNames = const <String>[],
    this.description = '',
    this.coverImage = '',
    this.category = Category.story,
    this.genre = const <Genre>[],
    this.chapters = const <ChapterX>[],
    this.averageRating = 0.0,
    this.tags = const <String>[],
    this.views = 0,
    this.totalReviews = 0,
    this.createdAt = '',
    this.updatedAt = '',
  });

  final String id;
  final Author author;
  final String title;
  final List<String> alternateNames;
  final String description;
  final String coverImage;
  final Category category;
  final List<Genre> genre;
  final List<ChapterX> chapters;
  final double averageRating;
  final List<String> tags;
  final int views;
  final int totalReviews;
  final String createdAt;
  final String updatedAt;

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["_id"],
        author: Author.fromJson(json["author"]),
        title: json["title"],
        alternateNames: List<String>.from(json["alternateNames"].map((x) => x)),
        description: json["description"],
        coverImage: json["coverImage"],
        category: Category.fromJson(json["category"]),
        genre: List<Genre>.from(json["genre"].map((x) => Genre.fromJson(x))),
        chapters: List<ChapterX>.from(
            json["chapters"].map((x) => ChapterX.fromJson(x))),
        averageRating: json["averageRating"].toDouble(),
        tags: List<String>.from(json["tags"].map((x) => x)),
        views: json["views"],
        totalReviews: json["totalReviews"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "author": author.toJson(),
        "title": title,
        "alternateNames": List<dynamic>.from(alternateNames.map((x) => x)),
        "description": description,
        "coverImage": coverImage,
        "category": category.toJson(),
        "genre": List<dynamic>.from(genre.map((x) => x.toJson())),
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
        "averageRating": averageRating,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "views": views,
        "totalReviews": totalReviews,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class ChapterX {
  ChapterX({
    required this.id,
    required this.chapterName,
  });

  final String id;
  final String chapterName;

  factory ChapterX.fromRawJson(String str) =>
      ChapterX.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChapterX.fromJson(Map<String, dynamic> json) => ChapterX(
        id: json["_id"],
        chapterName: json["chapterName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chapterName": chapterName,
      };
}

/*class Review {
  Review({
    this.id,
    this.author,
    this.contentId,
    this.text,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String author;
  final String contentId;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["_id"],
    author: json["author"],
    contentId: json["contentId"],
    text: json["text"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "author": author,
    "contentId": contentId,
    "text": text,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}*/
