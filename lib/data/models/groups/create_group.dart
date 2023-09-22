class CreateGroup {
    final String? id;
    final String? title;

    CreateGroup({
        this.id,
        this.title,
    });

    factory CreateGroup.fromJson(Map<String, dynamic> json) => CreateGroup(
        id: json["id"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
    };
}
