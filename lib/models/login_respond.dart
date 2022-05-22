import 'dart:convert';

LoginRespondModel loginRespondJson(String str) =>
    LoginRespondModel.fromJson(json.decode(str));

class LoginRespondModel {
  late String status;
  late String desc;
  late String token;

  LoginRespondModel(
      {required this.status, required this.desc, required this.token});

  LoginRespondModel.fromJson(Map<String, dynamic> json) {
    if (json['status'] != null) {
      status = json['status'];
    } else {
      status = "";
    }
    if (json['desc'] != null) {
      desc = json['desc'];
    } else {
      desc = "";
    }
    if (json['token'] != null) {
      token = json['token'];
    } else {
      token = "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (status != null) {
      data['status'] = status;
    } else {
      data['status'] = "";
    }
    if (desc != null) {
      data['desc'] = desc;
    } else {
      data['desc'] = "";
    }
    if (token != null) {
      data['token'] = token;
    } else {
      data['token'] = "";
    }
    return data;
  }
}
