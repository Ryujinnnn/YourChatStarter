import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_chat_starter/components/custom_page_route.dart';
import 'package:your_chat_starter/components/primary_button.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Image.asset(
                Theme.of(context).scaffoldBackgroundColor == Colors.black87
                    ? "assets/images/logo.png"
                    : "assets/images/logo_light.png",
                height: 146,
              ),
              const Spacer(),
              PrimaryButton(
                  text: "Bắt đầu",
                  press: () => (Navigator.of(context).push(CustomPageRoute(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ChatBotScreen(),
                      direction: AxisDirection.down)))),
              const SizedBox(height: kDefaultPadding * 1.5),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
