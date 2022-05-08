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
    status = json['status'];
    desc = json['desc'];
    print(json);
    if (json['token'] != null)
      token = json['token'];
    else
      token = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['desc'] = desc;
    if (token != null)
      data['token'] = token;
    else
      data['token'] = "";
    return data;
  }
}
