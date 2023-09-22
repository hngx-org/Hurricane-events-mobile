class GroupDetails {
    final String? id;
    final String? image;
    final String? title;

    GroupDetails({
        this.id,
        this.image,
        this.title,
    });

    factory GroupDetails.fromJson(Map<String, dynamic> json) => GroupDetails(
        id: json["id"],
        image: json["image"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
    };
}
