import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/constants/typedefs.dart';

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  User({
    this.id,
    this.name = '',
    this.email,
    this.profileImage = StringRes.defaultProfileUrl,
    this.coverImage = StringRes.defaultCoverImage,
    this.gender = Gender.notSpecified,
    this.following,
    this.followers,
    this.savedPosts,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.bio,
    this.penName,
    this.phone,
    this.birthdate = '1/1/1901',
    this.totalFollowers = 0,
    this.totalFollowing = 0,
  });

  final String? id;
  final String name;
  final String? email;
  final String profileImage;
  final String coverImage;
  final String gender;
  final List<Follower>? following;
  final List<Follower>? followers;
  final List<Follower>? savedPosts;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? address;
  final String? bio;
  final String? penName;
  final String? phone;
  final String birthdate;
  final int totalFollowers;
  final int totalFollowing;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        profileImage: json["profileImage"] ?? StringRes.defaultProfileUrl,
        coverImage: json["coverImage"] ?? StringRes.defaultCoverImage,
        gender: json["gender"] ?? Gender.notSpecified,
        following: json["following"] == null
            ? null
            : List<Follower>.from(
                json["following"].map((x) => Follower.fromJson(x))),
        followers: json["followers"] == null
            ? null
            : List<Follower>.from(
                json["followers"].map((x) => Follower.fromJson(x))),
        savedPosts: json["savedPosts"] == null
            ? null
            : List<Follower>.from(
                json["savedPosts"].map((x) => Follower.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        address: json["address"] ?? StringRes.notAdded,
        bio: json["bio"] ?? '',
        penName: json["pen_name"] ?? '',
        phone: json["phone"] ?? StringRes.notAdded,
        birthdate: json["birthdate"] ?? '1/1/1901',
        totalFollowers: json["totalFollowers"] ?? 0,
        totalFollowing: json["totalFollowing"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "profileImage": profileImage,
        "coverImage": coverImage,
        "gender": gender,
        "following": following == null
            ? null
            : List<dynamic>.from(following!.map((x) => x.toJson())),
        "followers": followers == null
            ? null
            : List<dynamic>.from(followers!.map((x) => x.toJson())),
        "savedPosts": savedPosts == null
            ? null
            : List<dynamic>.from(savedPosts!.map((x) => x.toJson())),
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "address": address,
        "bio": bio,
        "pen_name": penName,
        "phone": phone,
        "birthdate": birthdate,
        "totalFollowers": totalFollowers,
        "totalFollowing": totalFollowing,
      };
}

class Follower {
  Follower({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  factory Follower.fromRawJson(String str) =>
      Follower.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
      };
}
