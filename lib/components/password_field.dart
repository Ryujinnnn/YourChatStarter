import 'package:flutter/material.dart';
import 'package:your_chat_starter/components/text_field_container.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/main.dart';

class RoundedPasswordField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const RoundedPasswordField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  //get _hintText => hintText;
  //get _onChanged => onChanged;

  @override
  RoundedPasswordFieldState createState() => RoundedPasswordFieldState();
}

class RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        obscureText: _isHidden,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isHidden = !_isHidden;
              });
            },
            icon: Icon(
              _isHidden ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
