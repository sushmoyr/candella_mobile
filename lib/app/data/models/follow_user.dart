// To parse this JSON data, do
//
//     final followUser = followUserFromJson(jsonString);

import 'dart:convert';

class FollowUser {
  FollowUser({
    this.id = '',
    this.name = '',
    this.profileImage = '',
    this.penName = '',
  });

  final String id;
  final String name;
  final String profileImage;
  final String penName;

  factory FollowUser.fromRawJson(String str) =>
      FollowUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FollowUser.fromJson(Map<String, dynamic> json) => FollowUser(
        id: json["_id"],
        name: json["name"],
        profileImage: json["profileImage"],
        penName: json["pen_name"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profileImage": profileImage,
        "pen_name": penName,
      };

  static fromList(json) => List<FollowUser>.from(
        json.map(
          (e) => FollowUser.fromJson(e),
        ),
      );
}
