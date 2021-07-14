class CategoryModel {
  int id;
  String created;
  String modified;
  String name;

  CategoryModel({
    required this.id,
    required this.created,
    required this.modified,
    required this.name,
  });

  CategoryModel copyWith({
    required int id,
    required String created,
    required String modified,
    required String name,
  }) =>
      CategoryModel(
        id: this.id,
        created: this.created,
        modified: this.modified,
        name: this.name,
      );

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        created: json["created"],
        modified: json["modified"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "created": created,
        "modified": modified,
        "name": name,
      };
}
