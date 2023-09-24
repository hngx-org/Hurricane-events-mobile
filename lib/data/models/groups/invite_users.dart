class InviteUsers {
  List<String>? addedUsers;
  List<dynamic>? invalidUsers;
  String? message;

  InviteUsers({
    this.addedUsers,
    this.invalidUsers,
    this.message,
  });

  factory InviteUsers.fromJson(Map<String, dynamic> json) => InviteUsers(
        addedUsers: json["added_users"] == null ? [] : List<String>.from(json["added_users"]!.map((x) => x)),
        invalidUsers: json["invalid_users"] == null ? [] : List<dynamic>.from(json["invalid_users"]!.map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "added_users": addedUsers == null ? [] : List<dynamic>.from(addedUsers!.map((x) => x)),
        "invalid_users": invalidUsers == null ? [] : List<dynamic>.from(invalidUsers!.map((x) => x)),
        "message": message,
      };
}
