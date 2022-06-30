import 'dart:convert';

SaveChangeRespondModel saveChangeRespondJson(String str) =>
    SaveChangeRespondModel.fromJson(json.decode(str));

class SaveChangeRespondModel {
  late String status;
  late String desc;

  SaveChangeRespondModel({required this.status, required this.desc});

  SaveChangeRespondModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    desc = (json['desc']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.desc != null) {
      data['desc'] = this.desc;
    }
    return data;
  }
}
