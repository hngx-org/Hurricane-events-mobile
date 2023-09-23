class EventFull {
  String? creatorId;
  String? description;
  DateTime? endDate;
  String? endTime;
  String? id;
  String? location;
  DateTime? startDate;
  String? startTime;
  String? thumbnail;
  String? title;

  EventFull({
    this.creatorId,
    this.description,
    this.endDate,
    this.endTime,
    this.id,
    this.location,
    this.startDate,
    this.startTime,
    this.thumbnail,
    this.title,
  });

  factory EventFull.fromJson(Map<String, dynamic> json) => EventFull(
        creatorId: json["creator_id"],
        description: json["description"],
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        endTime: json["end_time"],
        id: json["id"],
        location: json["location"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        startTime: json["start_time"],
        thumbnail: json["thumbnail"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "creator_id": creatorId,
        "description": description,
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "end_time": endTime,
        "id": id,
        "location": location,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "thumbnail": thumbnail,
        "title": title,
      };
}
