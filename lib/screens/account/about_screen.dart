// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:your_chat_starter/screens/account/font_screen.dart';
import 'package:your_chat_starter/screens/account/info_screen.dart';
import 'package:your_chat_starter/screens/account/password_screen.dart';
import 'package:your_chat_starter/screens/account/theme_screen.dart';
import 'package:your_chat_starter/screens/account/voice_screen.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';

import '../../components/custom_page_route.dart';
import '../../constants.dart';
import '../../main.dart';

import '../../models/profile_respond.dart';
import '../../services/api_service.dart';
import '../../services/shared_service.dart';
import '../upgrade_screen.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  //UserRespondModel user;
  late ProfileRespondModel profile;
  bool circular = true;
  String username = "";
  String status = "";
  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  void fetchData() async {
    if (isLogin = true) {
      var response = await APIService.getProfile();
      setState(() {
        profile = response;
        if (profile.user != null) {
          username = response.user.username;
          status = response.user.status;
        }
        circular = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[kPrimaryColor, kSecondaryColor],
              ),
            ),
          ),
          title: Container(
            child: Text("Về chúng tôi"),
          ),
        ),
        body: _profileUI(context));
  }

  Widget _profileUI(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 146,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: kContentColorDarkTheme.withOpacity(0.1),
                        child: Icon(
                          Icons.question_mark_outlined,
                          color: kPrimaryColor,
                          size: 20,
                        ),
                        padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      ),
                    ),
                    SizedBox(height: 5),
                    Column(
                      children: [
                        Text(
                          "Ryujinnnn",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Nhà phát triển ứng dụng di động",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Container(
                      height: 100,
                      width: 100,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: kContentColorDarkTheme.withOpacity(0.1),
                        child: Icon(
                          Icons.question_mark_outlined,
                          color: kPrimaryColor,
                          size: 20,
                        ),
                        padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      ),
                    ),
                    SizedBox(height: 5),
                    Column(
                      children: [
                        Text(
                          "NeroYuki",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Nhà phát triển chatbot",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
