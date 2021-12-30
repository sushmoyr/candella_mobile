// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/constants/typedefs.dart';

class User {
  User({
    this.id,
    this.name = '',
    this.email,
    this.profileImage = StringRes.defaultProfileUrl,
    this.coverImage = StringRes.defaultCoverImage,
    this.gender = Gender.notSpecified,
    this.following = const <String>[],
    this.followers = const <String>[],
    this.savedPosts,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.bio,
    this.penName,
    this.phone,
    this.birthdate = '1/1/1901',
  });

  final String? id;
  final String name;
  final String? email;
  final String profileImage;
  final String coverImage;
  final String gender;
  final List<String> following;
  final List<String> followers;
  final List<String>? savedPosts;
  final String? createdAt;
  final String? updatedAt;
  final String? address;
  final String? bio;
  final String? penName;
  final String? phone;
  final String birthdate;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"] ?? '',
        email: json["email"],
        profileImage: json["profileImage"] ?? StringRes.defaultProfileUrl,
        coverImage: json["coverImage"] ?? StringRes.defaultCoverImage,
        gender: json["gender"] ?? Gender.notSpecified,
        following: json["following"] == null
            ? []
            : List<String>.from(json["following"].map((x) => x)),
        followers: json["followers"] == null
            ? []
            : List<String>.from(json["followers"].map((x) => x)),
        savedPosts: json["savedPosts"] == null
            ? null
            : List<String>.from(json["savedPosts"].map((x) => x)),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        address: json["address"] ?? StringRes.notAdded,
        bio: json["bio"] ?? '',
        penName: json["pen_name"] ?? '',
        phone: json["phone"] ?? StringRes.notAdded,
        birthdate: json["birthdate"] ?? '1/1/1901',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "profileImage": profileImage,
        "coverImage": coverImage,
        "gender": gender,
        "following": List<String>.from(following.map((x) => x)),
        "followers": List<String>.from(followers.map((x) => x)),
        "savedPosts": savedPosts == null
            ? null
            : List<String>.from(savedPosts!.map((x) => x)),
        "createdAt": createdAt == null ? null : createdAt!,
        "updatedAt": updatedAt == null ? null : updatedAt!,
        "address": address,
        "bio": bio,
        "pen_name": penName,
        "phone": phone,
        "birthdate": birthdate,
      };
}
