import 'dart:convert';

class GroupMockUp {
  final String? title;
  final int? numOfPeople;
  final int? numOfEvent;

  GroupMockUp({
    this.title,
    this.numOfPeople,
    this.numOfEvent,
  });

  factory GroupMockUp.fromRawJson(String str) =>
      GroupMockUp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GroupMockUp.fromJson(Map<String, dynamic> json) => GroupMockUp(
        title: json["title"],
        numOfPeople: json["numOfPeople"],
        numOfEvent: json["numOfEvent"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "numOfPeople": numOfPeople,
        "numOfEvent": numOfEvent,
      };
}
