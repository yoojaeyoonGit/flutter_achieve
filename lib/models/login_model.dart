class LoginModel {
  final String name;
  final String email;
  final String password;
  final String affiliation;

  LoginModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        email = json["email"],
        password = json["password"],
        affiliation = json["affiliation"];
}
