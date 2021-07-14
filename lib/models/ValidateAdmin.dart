class Validate {
  bool response;
  bool isAdmin;

  Validate({
    required this.response,
    required this.isAdmin,
  });

  Validate copyWith({
    required bool response,
    required bool isAdmin,
  }) =>
      Validate(
        response: this.response,
        isAdmin: this.isAdmin,
      );

  factory Validate.fromMap(Map<String, dynamic> json) => Validate(
        response: json["response"],
        isAdmin: json["isAdmin"],
      );

  Map<String, dynamic> toMap() => {
        "response": response,
        "isAdmin": isAdmin,
      };
}
