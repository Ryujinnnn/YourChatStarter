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
    data['username'] = username;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    data['email'] = email;
    return data;
  }
}
