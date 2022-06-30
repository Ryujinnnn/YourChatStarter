import 'dart:convert';

ProfileRespondModel profileRespondModel(String str) =>
    ProfileRespondModel.fromJson(json.decode(str));

class ProfileRespondModel {
  late String status;
  late String desc;
  late User user;

  ProfileRespondModel(
      {required this.status, required this.desc, required this.user});

  ProfileRespondModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    desc = json['desc'];
    user = (json['user'] != null ? new User.fromJson(json['user']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['desc'] = desc;
    if (user != null) {
      data['user'] = user.toJson();
    }
    return data;
  }
}

class User {
  late String username;
  late String email;
  late String paidValidUntil;
  late String status;
  String displayName = "";
  String birthday = "";

  User(
      {required this.username,
      required this.email,
      required this.paidValidUntil,
      required this.status,
      required this.displayName,
      required this.birthday});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    paidValidUntil = json['paid_valid_until'];
    status = json['status'];
    if (json['display_name'] != null) displayName = json['display_name'];
    if (json['birthday'] != null) birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['paid_valid_until'] = paidValidUntil;
    data['status'] = status;
    data['display_name'] = displayName;
    data['birthday'] = birthday;
    return data;
  }
}
