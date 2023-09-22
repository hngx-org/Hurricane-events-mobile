class AddEventResp {
  String? message;

  AddEventResp({
    this.message,
  });

  factory AddEventResp.fromJson(Map<String, dynamic> json) => AddEventResp(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
