import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:your_chat_starter/components/primary_button.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/main.dart';
import 'package:your_chat_starter/models/register_request.dart';

import '../../components/password_field.dart';
import '../../components/rounded_text_field.dart';
import '../../components/text_field_container.dart';
import '../../services/api_service.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isAPIcallProcess = false;
  String failureText = "";
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  final TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: signUpUI(context),
        ),
        inAsyncCall: isAPIcallProcess,
        key: UniqueKey(),
        opacity: 0.3,
      ),
    );
  }

  Widget signUpUI(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
              borderRadius: const BorderRadius.only(
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
            controller: username,
            icon: Icons.person,
            hintText: "Tài khoản",
          ),
        ),
        TextFieldContainer(
          child: RoundedTextField(
            controller: email,
            icon: Icons.email,
            hintText: "Email",
          ),
        ),
        TextFieldContainer(
          child: RoundedPasswordField(
            controller: password,
            hintText: "Mật khẩu",
          ),
        ),
        TextFieldContainer(
          child: RoundedPasswordField(
            controller: confirmPassword,
            hintText: "Nhập lại mật khẩu",
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Center(
          child: PrimaryButton(
            text: "Đăng ký",
            press: () {
              if (validateAndSave()) {
                setState(() {
                  isAPIcallProcess = true;
                });
                RegisterRequestModel model = RegisterRequestModel(
                    username: username.text,
                    email: email.text,
                    password: password.text,
                    confirmPassword: confirmPassword.text);
                APIService.register(model).then((response) => {
                      setState(() {
                        isAPIcallProcess = false;
                        switch (response.desc) {
                          case "passwords do not match":
                            failureText = "Mật khẩu không trùng khớp";
                            break;
                          case "username already existed":
                            failureText = "Tài khoản đã tồn tại";
                            break;
                          case "You need to fill all the fields to register":
                            failureText = "Bạn phải nhập đầy đủ các trường";
                            break;
                          default:
                            {
                              failureText = response.desc;
                            }
                            break;
                        }
                      }),
                      if (response.status == 'success')
                        {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              return const LoginScreen();
                            },
                          ), (route) => false)
                        }
                      else
                        {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Đăng ký thất bại"),
                              content: Text(failureText),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: kPrimaryColor),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          )
                        }
                    });
              }
            },
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

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
