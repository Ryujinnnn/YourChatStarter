import 'package:flutter/material.dart';
import 'package:your_chat_starter/components/primary_button.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatBotScreen(),
                  ),
                ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
