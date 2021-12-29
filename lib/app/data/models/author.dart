import 'dart:convert';

class Author {
  const Author({
    this.id = '',
    this.name = '',
    this.email = '',
    this.profileImage = '',
    this.coverImage = '',
    this.authorId = '',
    this.penName = '',
  });

  final String id;
  final String name;
  final String email;
  final String profileImage;
  final String coverImage;
  final String authorId;
  final String penName;

  factory Author.fromRawJson(String str) => Author.fromJson(json.decode(str));

  factory Author.empty() => Author();

  String toRawJson() => json.encode(toJson());

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        profileImage: json["profileImage"],
        coverImage: json["coverImage"],
        authorId: json["id"],
        penName: json['pen_name'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "profileImage": profileImage,
        "coverImage": coverImage,
        "id": authorId,
        "pen_name": penName,
      };
}
