import 'package:your_chat_starter/constants.dart';
import 'package:flutter/material.dart';
import 'package:your_chat_starter/main.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData.dark().copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.black87,
      appBarTheme: const AppBarTheme(),
      iconTheme: const IconThemeData(color: kContentColorLightTheme),
      colorScheme: ColorScheme.light(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
          error: kErrorColor));
}
