class GroupDetails {
  final String? id;
  final String? image;
  final String? title;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupDetails({
    this.id,
    this.image,
    this.title,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupDetails.fromJson(Map<String, dynamic> json) => GroupDetails(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
