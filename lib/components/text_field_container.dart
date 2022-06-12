import 'package:flutter/material.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/main.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //final double appBarHeight = AppBar().preferredSize.height;
    //print("[HEIGHT] " + appBarHeight.toString());
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding:
          EdgeInsets.symmetric(horizontal: size.height * 0.02, vertical: 0),
      width: size.width * 0.8,
      height: 60,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
