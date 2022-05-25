class RegistrationModel {
  int? id;
  String? email;
  String? password;
  String? conformPassword;

  RegistrationModel(this.id, this.email, this.password, this.conformPassword);

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    email = json["email"];
    password = json["password"];
    conformPassword = json["conformPassword"];
  }
}
