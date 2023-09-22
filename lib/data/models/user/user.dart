class AppUser {
  final String avatar;
  final String email;
  final String id;
  final String name;

  AppUser({
    required this.avatar,
    required this.email,
    required this.id,
    required this.name,
  });

  AppUser copyWith({
    String? avatar,
    String? email,
    String? id,
    String? name,
  }) =>
      AppUser(
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        avatar: json["avatar"],
        email: json["email"],
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "avatar": avatar,
        "email": email,
        "id": id,
        "name": name,
      };
}
