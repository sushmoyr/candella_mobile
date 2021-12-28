// To parse this JSON data, do
//
//     final content = contentFromJson(jsonString);

import 'dart:convert';

import 'package:candella/app/data/models/chapter.dart';
import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/constants/typedefs.dart';

import 'author.dart';

class Content {
  Content({
    this.id = '',
    this.author = const Author(),
    this.title = '',
    this.alternateNames = const <String>[],
    this.description = '',
    this.coverImage = StringRes.defaultCoverImage,
    this.category = Category.story,
    this.genre = const <Category>[],
    this.chapters = const <Chapter>[],
    this.averageRating = 0,
    this.reviews = const <String>[],
    this.tags = const <String>[],
    this.views = 0,
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
  final List<Category> genre;
  final List<Chapter> chapters;
  final int averageRating;
  final List<String> reviews;
  final List<String> tags;
  final int views;
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
        genre:
            List<Category>.from(json["genre"].map((x) => Category.fromJson(x))),
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
        averageRating: json["averageRating"],
        reviews: List<String>.from(json["reviews"].map((x) => x)),
        tags: List<String>.from(json["tags"].map((x) => x)),
        views: json["views"],
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
        "chapters": List<Chapter>.from(chapters.map((x) => x.toJson())),
        "averageRating": averageRating,
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "views": views,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };

  static fromList(json) =>
      List<Content>.from(json.map((x) => Content.fromJson(x)));
}
