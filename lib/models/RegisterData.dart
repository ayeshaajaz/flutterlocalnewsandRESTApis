class RegisterData {
  final String fname;
  final String lname;
  final String email;
  final String gender;
  final String password;
  final String cPassword;

  RegisterData(
      {required this.gender,
      required this.fname,
      required this.lname,
      required this.email,
      required this.password,
      required this.cPassword});

  factory RegisterData.fromMap(Map<String, dynamic> map) {
    return RegisterData(
        fname: map['first_name'],
        lname: map['last_name'],
        email: map['email'],
        password: map['password'],
        cPassword: map['re_password'],
        gender: map['gender']);
  }
  RegisterData copyWith({
    required final String fname,
    required final String lname,
    required final String email,
    required final String gender,
    required final String password,
    required final String cPassword,
  }) {
    return RegisterData(
        gender: gender,
        fname: fname,
        lname: lname,
        email: email,
        password: password,
        cPassword: cPassword);
  }

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{
      'first_name': fname,
      'last_name': lname,
      'email': email,
      'password': password,
      're_password': cPassword,
      'gender': gender
    };
    return data;
  }

    Map<String, dynamic> toMapAllData() {
    final data = <String, dynamic>{
      'first_name': fname,
      'last_name': lname,
      'email': email,
      'password': password,
      're_password': cPassword,
      'gender': gender
    };
    return data;
  }
}
