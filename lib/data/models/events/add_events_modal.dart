import 'package:intl/intl.dart';

class AddEventsRequest {
  String? title;
  String? description;
  String? location;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? startTime;
  DateTime? endTime;
  String? creatorId;
  String? thumbnail;

  AddEventsRequest({
    this.title,
    this.description,
    this.location,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.creatorId,
    this.thumbnail,
  });

  factory AddEventsRequest.fromJson(Map<String, dynamic> json) => AddEventsRequest(
        title: json["title"],
        description: json["description"],
        location: json["location"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
        endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        creatorId: json["creator_id"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "location": location,
        "start_date": DateFormat("yyyy-MM-dd").format(startDate!),
        "end_date": DateFormat("yyyy-MM-dd").format(endDate ?? startDate!),
        "start_time": startTime?.toIso8601String().split("T")[1],
        "end_time": endTime?.toIso8601String().split("T")[1],
        "creator_id": creatorId,
        "thumbnail": thumbnail,
      };
}
