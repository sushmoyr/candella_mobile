// To parse this JSON data, do
//
//     final review = reviewFromJson(jsonString);

import 'dart:convert';

import 'author.dart';

class Review {
  Review({
    this.id = '',
    this.author = const Author(),
    this.contentId = '',
    this.text = '',
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final Author author;
  final String contentId;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["_id"],
        author: Author.fromJson(json["author"]),
        contentId: json["contentId"],
        text: json["text"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "author": author.toJson(),
        "contentId": contentId,
        "text": text,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  static fromList(json) => List<Review>.from(
        json.map(
          (x) => Review.fromJson(x),
        ),
      );
}
