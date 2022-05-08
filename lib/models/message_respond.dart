import 'dart:convert';

import 'message_request_model.dart';

MessageRespondModel messageRespondModel(String str) {
  return MessageRespondModel.fromJson(json.decode(str));
}

class MessageRespondModel {
  late String response;
  late Map<String, dynamic> contextString;
  late Context context;
  late Action action;

  MessageRespondModel({required this.response});

  MessageRespondModel.fromJson(Map<String, dynamic> json) {
    response = json['response'];
    contextString = (json['context']);
    context =
        (json['context'] != null ? Context.fromJson(json['context']) : null)!;
    action = (json['action'] != null
        ? Action.fromJson(json['action'])
        : Action(action: "", data: Data(message: "", time: "", type: "")));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['response'] = response;
    data['context'] = contextString;
    data['action'] = action;
    return data;
  }
}

class Action {
  late String action;
  late Data data;

  Action({required this.action, required this.data});

  Action.fromJson(Map<String, dynamic> json) {
    action = (json['action'] ?? "")!;
    data = (json['data'] != null
        ? Data.fromJson(json['data'])
        : Data(message: "", time: "", type: ""));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] = action;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  late String message;
  late String time;
  late String type;

  Data({required this.message, required this.time, required this.type});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? "";
    time = json['time'] ?? "";
    type = json['type'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['time'] = time;
    data['type'] = type;
    return data;
  }
}
