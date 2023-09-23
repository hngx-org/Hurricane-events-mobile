import 'dart:convert';

import 'package:hurricane_events/data/models/events/events_full_model.dart';

class EventInterestResponse {
  final List<EventFull> events;
  final String user;

  EventInterestResponse({
    required this.events,
    required this.user,
  });

  factory EventInterestResponse.fromRawJson(String str) =>
      EventInterestResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EventInterestResponse.fromJson(Map<String, dynamic> json) =>
      EventInterestResponse(
        events: List<EventFull>.from(
            json["events"].map((x) => EventFull.fromJson(x))),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
        "user": user,
      };
}
