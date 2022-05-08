class EditProfileRequestModel {
  late String username;
  late String email;
  late String birthday;
  late String displayName;

  EditProfileRequestModel(
      {required this.username,
      required this.email,
      required this.birthday,
      required this.displayName});

  EditProfileRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    birthday = json['birthday'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['birthday'] = birthday;
    data['display_name'] = displayName;
    return data;
  }
}
