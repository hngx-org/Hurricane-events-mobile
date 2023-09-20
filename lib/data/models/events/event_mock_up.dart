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
        "comments": comments,
      };
}

class Comment {
  Comment({
    this.comment,
  });

  String? comment;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() => {
        "comment": comment,
      };
}
