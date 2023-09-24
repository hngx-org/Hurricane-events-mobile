class UserId {
  final String? userId;
  final String? authorizationToken;

  UserId({
    this.userId,
    this.authorizationToken,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        userId: json["user_id"],
        authorizationToken: json["Authorization_token"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "Authorization_token": authorizationToken,
      };
}
