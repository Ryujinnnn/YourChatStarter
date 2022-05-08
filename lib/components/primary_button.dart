import 'dart:ffi';

import 'package:flutter/material.dart';
import '../constants.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {required this.text,
      required this.press,
      this.color = kPrimaryColor,
      this.padding = const EdgeInsets.all(kDefaultPadding * 0.75)});
  final String text;
  final VoidCallback press;
  final color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      padding: padding,
      color: color,
      minWidth: 300,
      onPressed: press,
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
