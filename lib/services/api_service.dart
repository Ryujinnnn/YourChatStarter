import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:your_chat_starter/main.dart';
import 'package:your_chat_starter/models/register_respond.dart';
import 'package:your_chat_starter/models/subscribe_push_request.dart';
import 'package:your_chat_starter/services/shared_service.dart';

import '../config.dart';
import '../models/blog.dart';
import '../models/change_password.dart';
import '../models/detail_blog_request.dart';
import '../models/detail_blog_respond.dart';
import '../models/edit_request.dart';
import '../models/login_request.dart';
import '../models/login_respond.dart';
import '../models/message_request_model.dart';
import '../models/message_respond.dart';
import '../models/profile_respond.dart';
import '../models/register_request.dart';
import '../models/setting_request.dart';
import '../models/setting_respond.dart';
import 'shared_service.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model) async {
    var url = Uri.parse(Config.apiURL + Config.loginAPI);
    var response = await client.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginRespondJson(response.body));
      await SharedService.setUserNameDetails(model);
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> subscribe(SubscribePushRequestModel model) async {
    var url = Uri.parse(Config.apiURL + Config.subscribePushAPI);
    var loginDetails = await SharedService.loginDetails();
    var response = await client.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'x-access-token': loginDetails.token,
        },
        body: jsonEncode(model.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> logout() async {
    var loginDetails = await SharedService.loginDetails();
    var url = Uri.parse(Config.apiURL + Config.logOutAPI);
    var response = await client.get(url, headers: <String, String>{
      'x-access-token': loginDetails.token,
    });
    // ignore: unnecessary_null_comparison
    if (response != null) {
      return true;
    }
    return false;
  }

  static Future<RegisterRespondModel> register(
      RegisterRequestModel model) async {
    var url = Uri.parse(Config.apiURL + Config.registerAPI);
    var response = await client.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model));
    // ignore: unnecessary_null_comparison
    var body = json.decode(response.body);
    RegisterRespondModel registerRespondModel =
        RegisterRespondModel(status: body['status'], desc: body['desc']);
    return registerRespondModel;
  }

  static Future<MessageRespondModel> sendMessage(
      MessageRequestModel model) async {
    var url = Uri.parse(Config.apiURL + Config.sendMessage);
    var loginDetails = await SharedService.loginDetails();
    var response;
    if (loginDetails.token != "") {
      response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-access-token': loginDetails.token,
            'subscriber-id': externalUserId
          },
          body: jsonEncode(model));
    } else {
      response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(model));
    }
    return messageRespondModel(response.body);
  }

  static Future<bool> saveSetting(SettingRequestModel model) async {
    var url = Uri.parse(Config.apiURL + Config.saveSetting);
    var loginDetails = await SharedService.loginDetails();
    var response;
    if (loginDetails.token != "") {
      response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-access-token': loginDetails.token,
          },
          body: jsonEncode(model));
    } else {
      response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(model));
    }
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<SettingRespondModel> getSetting() async {
    var url = Uri.parse(Config.apiURL + Config.getSetting);
    var loginDetails = await SharedService.loginDetails();
    var response = await client.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-access-token': loginDetails.token,
      },
    );
    return settingRespondModel(response.body);
  }

  static Future<ProfileRespondModel> getProfile() async {
    var url = Uri.parse(Config.apiURL + Config.profileAPI);
    var loginDetails = await SharedService.loginDetails();
    var response = await client.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-access-token': loginDetails.token,
      },
    );
    return profileRespondModel(response.body);
  }

  static Future<bool> saveProfile(EditProfileRequestModel model) async {
    var url = Uri.parse(Config.apiURL + Config.saveProfile);
    var loginDetails = await SharedService.loginDetails();
    var response;
    if (loginDetails.token != "") {
      response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-access-token': loginDetails.token,
          },
          body: jsonEncode(model));
    } else {
      response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(model));
    }
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<BlogRespondModel> getBlog() async {
    var url = Uri.parse(Config.apiURL + Config.blogAPI);
    var response = await client.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    return blogRespondJson(response.body);
  }

  static Future<DetailBlogRespondModel> getDetailsBlog(
      DetailBlogRequestModel model) async {
    var url = Uri.parse(Config.apiURL + Config.detailBlogAPI);
    var response = await client.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(model.toJson()));

    return detailBlogRespondJson(response.body);
  }

  static Future<DetailBlogRespondModel> changePassword(
      ChangePasswordRequestModel model) async {
    var url = Uri.parse(Config.apiURL + Config.changePasswordAPI);
    var loginDetails = await SharedService.loginDetails();
    var response;
    if (loginDetails.token != "") {
      response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
            'x-access-token': loginDetails.token,
          },
          body: jsonEncode(model));
    } else {
      response = await client.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(model));
    }

    return detailBlogRespondJson(response.body);
  }
}
