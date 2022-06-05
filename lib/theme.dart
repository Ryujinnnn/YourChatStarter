import 'package:your_chat_starter/constants.dart';
import 'package:flutter/material.dart';
import 'package:your_chat_starter/main.dart';

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.black87,
      appBarTheme: const AppBarTheme(),
      iconTheme: const IconThemeData(color: kContentColorDarkTheme),
      colorScheme: ColorScheme.light(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
          error: kErrorColor));
}

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(),
      iconTheme: const IconThemeData(color: kContentColorLightTheme),
      colorScheme: ColorScheme.light(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
          error: kErrorColor));
}
