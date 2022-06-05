// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
import 'upgrade_screen.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  //UserRespondModel user;
  late ProfileRespondModel profile;
  bool circular = true;
  final projectURL = "https://github.com/Ryujinnnn/YourChatStarter";
  final longURL = "https://github.com/Ryujinnnn";
  final dangURL = "https://github.com/NeroYuki";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RawMaterialButton(
                      onPressed: () {
                        _launchURL(projectURL);
                      },
                      child: Image.asset(
                        Theme.of(context).scaffoldBackgroundColor ==
                                Colors.black87
                            ? "assets/images/logo.png"
                            : "assets/images/logo_light.png",
                        height: 146,
                        width: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: RawMaterialButton(
                        onPressed: () {
                          _launchURL(longURL);
                        },
                        elevation: 2.0,
                        fillColor: kContentColorDarkTheme.withOpacity(0.1),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            "assets/images/56832365.jpg",
                          ),
                        ),
                        shape: const CircleBorder(),
                      ),
                    ),
                    SizedBox(height: 5),
                    Column(
                      children: [
                        Text(
                          "Be Hai Long",
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Nhà phát triển ứng dụng di động",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: RawMaterialButton(
                        onPressed: () {
                          _launchURL(dangURL);
                        },
                        elevation: 2.0,
                        fillColor: kContentColorDarkTheme.withOpacity(0.1),
                        child: const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            "assets/images/24820831.png",
                          ),
                        ),
                        shape: const CircleBorder(),
                      ),
                    ),
                    SizedBox(height: 5),
                    Column(
                      children: [
                        Text(
                          "Nguyen Ngoc Dang",
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

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
