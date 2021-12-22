// To parse this JSON data, do
//
//     final contentResponse = contentResponseFromJson(jsonString);

import 'dart:convert';

class ContentRequest {
  ContentRequest({
    required this.title,
    required this.description,
    required this.genre,
    required this.category,
    this.alternateNames,
    this.tags,
    this.coverImage,
  });

  final String title;
  final String description;
  final List<String> genre;
  final String category;
  final List<String>? alternateNames;
  final List<String>? tags;
  final String? coverImage;

  factory ContentRequest.fromRawJson(String str) =>
      ContentRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContentRequest.fromJson(Map<String, dynamic> json) => ContentRequest(
        title: json["title"],
        description: json["description"],
        genre: List<String>.from(json["genre"].map((x) => x)),
        category: json["category"],
        alternateNames: List<String>.from(json["alternateNames"].map((x) => x)),
        tags: List<String>.from(json["tags"].map((x) => x)),
        coverImage: json["coverImage"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> body = {
      "title": title,
      "description": description,
      "genre": List<dynamic>.from(genre.map((x) => x)),
      "category": category,
    };

    if (alternateNames != null) {
      body["alternateNames"] =
          List<dynamic>.from(alternateNames!.map((x) => x));
    }

    if (tags != null) {
      body['tags'] = List<dynamic>.from(tags!.map((x) => x));
    }

    if (coverImage != null) {
      body['coverImage'] = coverImage;
    }

    return body;
  }
}
