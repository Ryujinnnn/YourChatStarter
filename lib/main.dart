import 'dart:io';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:your_chat_starter/models/login_request.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';
import 'package:your_chat_starter/screens/sign_in/login_screen.dart';
import 'package:your_chat_starter/screens/welcome_screen.dart';
import 'package:your_chat_starter/services/api_service.dart';
import 'package:your_chat_starter/services/shared_service.dart';
import 'package:your_chat_starter/theme.dart';

bool isLogin = false;
late String externalUserId;

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

Map<String, WidgetBuilder> route = {
  "/chatbot": (context) => const ChatBotScreen(),
  "/login": (context) => const LoginScreen()
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: WelcomeScreen(),
    );
  }
}
