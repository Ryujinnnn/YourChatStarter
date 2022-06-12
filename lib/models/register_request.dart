class RegisterRequestModel {
  late String username;
  late String password;
  late String confirmPassword;
  late String email;

  RegisterRequestModel(
      {required this.username,
      required this.password,
      required this.confirmPassword,
      required this.email});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (username != "") data['username'] = username;
    if (password != "") data['password'] = password;
    if (confirmPassword != "") data['confirm_password'] = confirmPassword;
    if (email != "") data['email'] = email;
    return data;
  }
}
