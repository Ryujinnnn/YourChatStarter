import 'dart:convert';

RegisterRespondModel registerRespondModel(String str) =>
    RegisterRespondModel.fromJson(json.decode(str));

class RegisterRespondModel {
  late String status;
  late String desc;

  RegisterRespondModel({required this.status, required this.desc});

  RegisterRespondModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['desc'] = desc;
    return data;
  }
}
