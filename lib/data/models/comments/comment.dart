class Comment {
  String? body;
  String? eventId;
  String? id;
  dynamic image;
  String? userId;

  Comment({
    this.body,
    this.eventId,
    this.id,
    this.image,
    this.userId,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        body: json["body"],
        eventId: json["event_id"],
        id: json["id"],
        image: json["image"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "event_id": eventId,
        "id": id,
        "image": image,
        "user_id": userId,
      };
}
