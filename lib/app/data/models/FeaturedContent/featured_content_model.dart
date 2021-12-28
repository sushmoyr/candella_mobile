// To parse this JSON data, do
//
//     final featuredContent = featuredContentFromJson(jsonString);

import 'dart:convert';

import '../author.dart';

class FeaturedContent {
  FeaturedContent({
    this.id = '',
    this.author = const Author(),
    this.title = '',
    this.description = '',
    this.coverImage = '',
    this.category = const CategoryF(name: '', id: ''),
    this.genre = const <CategoryF>[],
    this.chapters = const <_ChapterF>[],
    this.averageRating = 0.0,
    this.tags = const <String>[],
    this.views = 0,
    this.createdAt = '',
    this.updatedAt = '',
    this.totalChapters = 0,
  });

  final String id;
  final Author author;
  final String title;
  final String description;
  final String coverImage;
  final CategoryF category;
  final List<CategoryF> genre;
  final List<_ChapterF> chapters;
  final double averageRating;
  final List<String> tags;
  final int views;
  final int totalChapters;
  final String createdAt;
  final String updatedAt;

  factory FeaturedContent.fromRawJson(String str) =>
      FeaturedContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeaturedContent.fromJson(Map<String, dynamic> json) =>
      FeaturedContent(
        id: json["_id"],
        author: Author.fromJson(json["author"]),
        title: json["title"],
        description: json["description"],
        coverImage: json["coverImage"],
        category: CategoryF.fromJson(json["category"]),
        genre: List<CategoryF>.from(
            json["genre"].map((x) => CategoryF.fromJson(x))),
        chapters: List<_ChapterF>.from(
            json["chapters"].map((x) => _ChapterF.fromJson(x))),
        averageRating: double.parse(json["averageRating"].toString()),
        tags: List<String>.from(json["tags"].map((x) => x)),
        views: json["views"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        totalChapters: List<_ChapterF>.from(
            json["chapters"].map((x) => _ChapterF.fromJson(x))).length,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "author": author.toJson(),
        "title": title,
        "description": description,
        "coverImage": coverImage,
        "category": category.toJson(),
        "genre": List<dynamic>.from(genre.map((x) => x.toJson())),
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
        "averageRating": averageRating,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "views": views,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };

  static fromList(json) =>
      List<FeaturedContent>.from(json.map((x) => FeaturedContent.fromJson(x)));
}

class CategoryF {
  const CategoryF({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory CategoryF.fromRawJson(String str) =>
      CategoryF.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryF.fromJson(Map<String, dynamic> json) => CategoryF(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class _ChapterF {
  _ChapterF({
    required this.id,
  });

  final String id;

  factory _ChapterF.fromRawJson(String str) =>
      _ChapterF.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory _ChapterF.fromJson(Map<String, dynamic> json) => _ChapterF(
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
      };
}
