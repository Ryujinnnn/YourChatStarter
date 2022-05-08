import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';

import '../models/login_respond.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isKeyExist = await APICacheManager().isAPICacheKeyExist("login");
    return isKeyExist;
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

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login");
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}