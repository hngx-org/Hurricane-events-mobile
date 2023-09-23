class CreateComment {
  String? body;
  String? userId;
  String? image;

  CreateComment({
    this.body,
    this.userId,
    this.image,
  });

  factory CreateComment.fromJson(Map<String, dynamic> json) => CreateComment(
        body: json["body"],
        userId: json["user_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "body": body,
        "user_id": userId,
        "image": image,
      };
}
