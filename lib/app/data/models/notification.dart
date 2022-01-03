// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

class Notification {
  Notification({
    this.id = '',
    this.owner = '',
    this.message = '',
    this.type = '',
  });

  final String id;
  final String owner;
  final String message;
  final String type;

  factory Notification.fromRawJson(String str) =>
      Notification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["_id"],
        owner: json["owner"],
        message: json["message"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "owner": owner,
        "message": message,
        "type": type,
      };

  static List<Notification> fromList(json) => List<Notification>.from(
        json.map(
          (e) => Notification.fromJson(e),
        ),
      );
}
