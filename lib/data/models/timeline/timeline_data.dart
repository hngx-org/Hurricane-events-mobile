import 'dart:convert';

class TimelineData {
  final String title;
  final String eventType;
  final DateTime startTime;
  final DateTime endTime;
  final String location;

  TimelineData({
    required this.title,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.eventType,
  });

  factory TimelineData.fromRawJson(String str) =>
      TimelineData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TimelineData.fromJson(Map<String, dynamic> json) => TimelineData(
    title: json["title"],
    location: json["location"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    eventType: json["eventType"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "location": location,
    "startTime": startTime,
    "endTime": endTime,
    "eventType": eventType
  };
}