class UserModel {
  int id;
  String email;
  String firstName;
  String lastName;
  String photo;
  String gender;
  Null about;
  String created;
  String modified;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.photo,
    required this.gender,
    required this.about,
    required this.created,
    required this.modified,
  });

  UserModel copyWith({
    required int id,
    required String email,
    required String firstName,
    required String lastName,
    required String photo,
    required String gender,
    required Null about,
    required String created,
    required String modified,
  }) =>
      UserModel(
        id: this.id,
        email: this.email,
        firstName: this.firstName,
        lastName: this.lastName,
        photo: this.photo,
        gender: this.gender,
        about: this.about,
        created: this.created,
        modified: this.modified,
      );

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        photo: json["photo"],
        gender: json["gender"],
        about: json['about'],
        created: json["created"],
        modified: json["modified"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "photo": photo,
        "gender": gender,
        "about": about,
        "created": created,
        "modified": modified,
      };
}
