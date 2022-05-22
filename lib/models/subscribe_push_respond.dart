import 'dart:convert';

SubscribePushRespondModel subPushRespondJson(String str) =>
    SubscribePushRespondModel.fromJson(json.decode(str));

class SubscribePushRespondModel {
  late String status;
  late String desc;
  late String id;

  SubscribePushRespondModel(
      {required this.status, required this.desc, required this.id});

  SubscribePushRespondModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    desc = json['desc'];
    if (json['token'] != null) {
      id = json['id'];
    } else {
      id = "";
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['desc'] = desc;
    if (id != null)
      data['id'] = id;
    else
      data['id'] = "";
    return data;
  }
}
