import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:your_chat_starter/components/custom_page_route.dart';
import 'package:your_chat_starter/components/primary_button.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';
import 'package:your_chat_starter/main.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance!.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Spacer(flex: 2),
              Image.asset(
                "assets/images/logo.png",
                height: 146,
              ),
              Spacer(),
              PrimaryButton(
                  text: "Bắt đầu",
                  press: () => (Navigator.of(context).push(CustomPageRoute(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ChatBotScreen(),
                      direction: AxisDirection.down)))),
              SizedBox(height: kDefaultPadding * 1.5),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
