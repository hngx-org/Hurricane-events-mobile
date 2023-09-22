class AddUser {
    final String? message;

    AddUser({
        this.message,
    });

    factory AddUser.fromJson(Map<String, dynamic> json) => AddUser(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
