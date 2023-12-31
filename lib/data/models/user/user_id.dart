class UserId {
  final String? userId;

  UserId({
    this.userId,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
      };
}
