import 'dart:convert';

class MessageRequestModel {
  late String post;
  late Context context;
  late Map<String, dynamic> contextString;
  late bool isLocal;

  MessageRequestModel(
      {required this.post, required this.contextString, required this.isLocal});

  MessageRequestModel.fromJson(Map<String, dynamic> json) {
    post = json['post'];
    context = json['context'];
    isLocal = json['is_local'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post'] = post;
    data['context'] = contextString;
    data['is_local'] = isLocal;
    return data;
  }
}

class Context {
  late List<String> suggestionList;
  Context({required this.suggestionList});

  Context.fromJson(Map<String, dynamic> json) {
    suggestionList = json['suggestion_list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suggestion_list'] = suggestionList;
    return data;
  }
}