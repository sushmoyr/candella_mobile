// To parse this JSON data, do
//
//     final genre = genreFromJson(jsonString);

import 'dart:convert';

class Genre {
  Genre({
    required this.id,
    required this.name,
    required this.category,
  });

  final String id;
  final String name;
  final String category;

  factory Genre.empty() => Genre(id: '', name: '', category: '');

  factory Genre.fromRawJson(String str) => Genre.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["_id"],
        name: json["name"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "category": category,
      };
  static fromList(json) => List<Genre>.from(json.map((x) => Genre.fromJson(x)));
}
