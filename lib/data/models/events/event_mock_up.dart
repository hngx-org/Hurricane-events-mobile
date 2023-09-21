import 'package:flutter/material.dart';

class EventsMockUp {
  EventsMockUp({
    this.name,
    this.groupName,
    this.startDate,
    this.endDate,
    this.location,
    this.startDateStartTime,
    this.startDateEndTime,
    this.endDateStartTime,
    this.endDateEndTime,
    this.comments,
    this.isRsvpd,
  });

  String? name;
  String? groupName;
  DateTime? startDate;
  TimeOfDay? startDateStartTime;
  TimeOfDay? startDateEndTime;
  TimeOfDay? endDateStartTime;
  TimeOfDay? endDateEndTime;
  DateTime? endDate;
  String? location;
  bool? isRsvpd;
  List<Comment>? comments;

  factory EventsMockUp.fromJson(Map<String, dynamic> json) {
    return EventsMockUp(
      name: json['name'],
      groupName: json["group"],
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      location: json["location"],
      startDateStartTime: TimeOfDay.fromDateTime(json["startDate"]),
      startDateEndTime: TimeOfDay.fromDateTime(json["startDate"]),
      endDateStartTime: TimeOfDay.fromDateTime(json["endDate"]),
      endDateEndTime: TimeOfDay.fromDateTime(json["endDate"]),
      isRsvpd: json["isRsvpd"],
      comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "group": groupName,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "location": location,
        "startDateStartTime": startDateStartTime,
        "startDateEndTime": startDateEndTime,
        "endDateStartTime": endDateStartTime,
        "endDateEndTime": endDateEndTime,
        "isRsvpd": isRsvpd,
        "comments": comments,
      };
}

class Comment {
  Comment({
    this.comment,
    this.createdAt,
    this.image,
    this.hasImage,
    this.userImage,
    this.userName,
  });

  String? comment;
  String? userName;
  DateTime? createdAt;
  bool? hasImage;
  String? image;
  String? userImage;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment: json['comment'],
      userName: json['userName'],
      hasImage: json['hasImage'],
      image: json['image'],
      userImage: json['comment'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "userName": userName,
        "hasImage": hasImage,
        "image": image,
        "userImage": userImage,
        "createdAt": createdAt?.toIso8601String(),
      };
}
