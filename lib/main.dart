import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_chat_starter/models/login_request.dart';
import 'package:your_chat_starter/screens/account/theme_screen.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';
import 'package:your_chat_starter/screens/sign_in/login_screen.dart';
import 'package:your_chat_starter/screens/welcome_screen.dart';
import 'package:your_chat_starter/services/api_service.dart';
import 'package:your_chat_starter/services/shared_service.dart';
import 'package:your_chat_starter/theme.dart';

bool isLogin = false;
late String externalUserId;
ThemeGroup? savedTheme;

late Color kPrimaryColor;
late Color kSecondaryColor;
Color kBackgroundColor = Colors.black;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await SharedService.isLoggedIn();
  if (isLoggedIn) {
    isLoggedIn = true;
    bool isReLogIn = await SharedService.isReLogIn();
    if (isReLogIn) {
      LoginRequestModel model = await SharedService.reLogIn();
      APIService.login(model);
    }
  }
  loadThemeData();
  theming();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("c4f18d2d-08d5-450d-9865-3fe344cfb813");

  final status = await OneSignal.shared.getDeviceState();
  if (status != null) {
    externalUserId = status.userId!;
  }

  if (Platform.isIOS) {
    // iOS-specific code
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  runApp(const MyApp());
}

void loadThemeData() async {
  final prefs = await SharedPreferences.getInstance();
  String? localSaved = prefs.getString('themeValue');
  savedTheme = ThemeGroup.values.firstWhere((e) => e.toString() == localSaved);
}

void theming() {
  switch (savedTheme) {
    case ThemeGroup.green:
      kPrimaryColor = const Color(0xFF00BF6D);
      kSecondaryColor = const Color.fromARGB(223, 0, 114, 0);
      break;
    case ThemeGroup.cherry:
      kPrimaryColor = const Color(0xFFC6246D);
      kSecondaryColor = const Color(0xFF89123A);
      break;
    case ThemeGroup.sunshine:
      kPrimaryColor = Colors.amber;
      kSecondaryColor = const Color(0xFFFE9901);
      break;
    case ThemeGroup.ocean:
      kPrimaryColor = const Color.fromARGB(255, 45, 175, 250);
      kSecondaryColor = const Color.fromARGB(255, 1, 102, 254);
      break;
    default:
      {
        kPrimaryColor = const Color(0xFF00BF6D);
        kSecondaryColor = Color.fromARGB(223, 0, 114, 0);
      }
      break;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    loadThemeData();
    theming();
    return MaterialApp(
      title: 'Your Chat Starter',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: WelcomeScreen(),
    );
  }
}
