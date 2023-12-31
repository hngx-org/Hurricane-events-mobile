class EventNorm {
  String? creatorId;
  String? description;
  String? id;
  DateTime? startDate;
  String? title;

  EventNorm({
    this.creatorId,
    this.description,
    this.id,
    this.startDate,
    this.title,
  });

  factory EventNorm.fromJson(Map<String, dynamic> json) => EventNorm(
        creatorId: json["creator_id"],
        description: json["description"],
        id: json["id"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "creator_id": creatorId,
        "description": description,
        "id": id,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "title": title,
      };
}
