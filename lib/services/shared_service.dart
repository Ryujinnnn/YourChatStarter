import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_chat_starter/models/login_request.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';
import 'package:your_chat_starter/services/api_service.dart';

import '../models/login_respond.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("login");
    return isKeyExist;
  }

  static Future<bool> isReLogIn() async {
    var isUserNameExist =
        await APICacheManager().isAPICacheKeyExist("username");
    return isUserNameExist;
  }

  static Future<LoginRequestModel> reLogIn() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("username");
    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("username");
      return LoginRequestModel.fromJson(json.decode(cacheData.syncData));
    }
    return LoginRequestModel(username: "", password: "");
  }

  static Future<LoginRespondModel> loginDetails() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("login");
    if (isKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login");
      return loginRespondJson(cacheData.syncData);
    } else
      return loginRespondJson("{}");
  }

  static Future<void> setLoginDetails(LoginRespondModel model) async {
    APICacheDBModel cacheDBModel =
        APICacheDBModel(key: "login", syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> setUserNameDetails(LoginRequestModel model) async {
    APICacheDBModel cacheDBModel =
        APICacheDBModel(key: "username", syncData: jsonEncode(model.toJson()));
    await APICacheManager().addCacheData(cacheDBModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APIService.logout();
    await APICacheManager().deleteCache("login");
    await APICacheManager().deleteCache("username");
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const ChatBotScreen()),
        (Route<dynamic> route) => false);
  }
}
