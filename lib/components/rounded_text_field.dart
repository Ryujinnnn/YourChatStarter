import 'package:flutter/material.dart';
import 'package:your_chat_starter/components/text_field_container.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/main.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  const RoundedTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.icon = Icons.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
