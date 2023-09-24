// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  String? body;
  DateTime? createdAt;
  String? eventId;
  String? id;
  String? image;
  DateTime? updatedAt;
  User? user;
  String? userId;

  Comment({
    this.body,
    this.createdAt,
    this.eventId,
    this.id,
    this.image,
    this.updatedAt,
    this.user,
    this.userId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        body: json["body"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        eventId: json["event_id"],
        id: json["id"],
        image: json["image"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "created_at": createdAt?.toIso8601String(),
        "event_id": eventId,
        "id": id,
        "image": image,
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "user_id": userId,
      };
}

class User {
  String? avatar;
  String? name;

  User({
    this.avatar,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatar: json["avatar"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "name": name,
      };
}
