// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_chat_starter/screens/account/about_screen.dart';
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

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
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
            child: Text("T??i kho???n"),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                SharedService.logout(context);
                Navigator.of(context).push(
                    MaterialPageRoute<bool>(builder: (BuildContext context) {
                  return const ChatBotScreen();
                }));
              },
            ),
          ],
        ),
        body: _profileUI(context));
  }

  Widget _profileUI(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/logo-mini.png"),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          status,
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Divider(
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CustomPageRoute(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        InfoScreen(),
                                direction: AxisDirection.down));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit_rounded,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Th??ng tin kh??ch h??ng",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CustomPageRoute(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        VoiceScreen(),
                                direction: AxisDirection.up));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications_rounded,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "??m thanh v?? th??ng b??o",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CustomPageRoute(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        ThemeScreen(),
                                direction: AxisDirection.up));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.image_rounded,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Giao di???n",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CustomPageRoute(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        FontScreen(),
                                direction: AxisDirection.up));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.font_download_rounded,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Ph??ng ch???",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CustomPageRoute(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        UpgradeActivity(),
                                direction: AxisDirection.up));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.upgrade_rounded,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "N??ng c???p d???ch v???",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CustomPageRoute(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        PasswordScreen(),
                                direction: AxisDirection.up));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock_rounded,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "Thi???t l???p b???o m???t",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CustomPageRoute(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        AboutScreen(),
                                direction: AxisDirection.up));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_rounded,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "V??? ch??ng t??i",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                      const SizedBox(height: 20),
                      Divider(
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                          onTap: () {
                            SharedService.logout(context);
                            Navigator.of(context).push(MaterialPageRoute<bool>(
                                builder: (BuildContext context) {
                              return const ChatBotScreen();
                            }));
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: kPrimaryColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Text(
                                "????ng xu???t",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
