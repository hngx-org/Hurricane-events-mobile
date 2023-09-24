class CreateEvent {
  String? eventId;
  String? message;

  CreateEvent({
    this.eventId,
    this.message,
  });

  factory CreateEvent.fromJson(Map<String, dynamic> json) => CreateEvent(
        eventId: json["event_id"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "event_id": eventId,
        "message": message,
      };
}
