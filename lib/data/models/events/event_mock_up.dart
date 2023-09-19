import 'package:flutter/material.dart';

class EventsMockUp {
  EventsMockUp({
    this.name,
    this.group,
    this.startDate,
    this.endDate,
    this.location,
    this.startDateStartTime,
    this.startDateEndTime,
    this.endDateStartTime,
    this.endDateEndTime,
  });

  String? name;
  String? group;
  DateTime? startDate;
  TimeOfDay? startDateStartTime;
  TimeOfDay? startDateEndTime;
  TimeOfDay? endDateStartTime;
  TimeOfDay? endDateEndTime;
  DateTime? endDate;
  String? location;

  factory EventsMockUp.fromJson(Map<String, dynamic> json) {
    return EventsMockUp(
      name: json['name'],
      group: json["group"],
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      location: json["location"],
      startDateStartTime: TimeOfDay.fromDateTime(json["startDate"]),
      startDateEndTime: TimeOfDay.fromDateTime(json["startDate"]),
      endDateStartTime: TimeOfDay.fromDateTime(json["endDate"]),
      endDateEndTime: TimeOfDay.fromDateTime(json["endDate"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "group": group,
        "startDate": startDate?.toIso8601String(),
        "endDate": endDate?.toIso8601String(),
        "location": location,
        "startDateStartTime": startDateStartTime,
        "startDateEndTime": startDateEndTime,
        "endDateStartTime": endDateStartTime,
        "endDateEndTime": endDateEndTime,
      };
}
