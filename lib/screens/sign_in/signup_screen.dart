import 'package:flutter/material.dart';
import 'package:your_chat_starter/components/primary_button.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/main.dart';

import '../../components/password_field.dart';
import '../../components/rounded_text_field.dart';
import '../../components/text_field_container.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: signupUI(context),
    );
  }

  Widget signupUI(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController controller = TextEditingController();

    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: size.width,
          height: size.height / 5,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    kPrimaryColor,
                    kSecondaryColor,
                  ]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset("assets/images/logo.png",
                    width: 300, fit: BoxFit.contain),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        SizedBox(
          height: size.height * 0.1,
        ),
        TextFieldContainer(
          child: RoundedTextField(
            controller: controller,
            icon: Icons.person,
            hintText: "Tài khoản",
          ),
        ),
        TextFieldContainer(
          child: RoundedTextField(
            controller: controller,
            icon: Icons.email,
            hintText: "Email",
          ),
        ),
        TextFieldContainer(
          child: RoundedPasswordField(
            controller: controller,
            hintText: "Mật khẩu",
          ),
        ),
        TextFieldContainer(
          child: RoundedPasswordField(
            controller: controller,
            hintText: "Nhập lại mật khẩu",
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Center(
          child: PrimaryButton(
            text: "Đăng ký",
            press: () {},
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Đã có tài khoản? ",
              style: TextStyle(color: Theme.of(context).iconTheme.color),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                "Đăng nhập tại đây",
                style: TextStyle(fontSize: 16.0, color: kPrimaryColor),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
