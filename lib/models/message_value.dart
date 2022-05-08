import 'package:flutter/cupertino.dart';
import 'package:your_chat_starter/models/message_respond.dart' as res;

import 'message_request_model.dart';

class MessageValueHolder {
  String response;
  late Map<String, dynamic> context;
  bool isBot;
  late Container map;
  MessageValueHolder(
      {required this.response, required this.context, required this.isBot});
}
