import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:your_chat_starter/components/primary_button.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/models/subscribe_push_request.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';

import '../../components/password_field.dart';
import '../../components/rounded_text_field.dart';
import '../../components/text_field_container.dart';
import '../../main.dart';
import '../../models/login_request.dart';
import '../../services/api_service.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final SubscribeData subscribeData =
      SubscribeData(subscribeId: externalUserId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: loginUI(context),
        ),
        inAsyncCall: isAPIcallProcess,
        key: UniqueKey(),
        opacity: 0.3,
      ),
    );
  }

  Widget loginUI(BuildContext context) {
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
            icon: Icons.person,
            hintText: "Tài khoản",
            controller: username,
          ),
        ),
        TextFieldContainer(
          child:
              RoundedPasswordField(hintText: "Mật khẩu", controller: password),
        ),
        SizedBox(
          height: size.height * 0.015,
        ),
        SizedBox(
          height: size.height * 0.05,
        ),
        Center(
          child: PrimaryButton(
            text: "Đăng nhập",
            press: () {
              if (validateAndSave()) {
                setState(() {
                  isAPIcallProcess = true;
                });
                LoginRequestModel model = LoginRequestModel(
                    username: username.text, password: password.text);
                APIService.login(model).then((response) => {
                      setState(() {
                        isAPIcallProcess = false;
                      }),
                      if (response)
                        {
                          isLogin = true,
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                            builder: (context) {
                              SubscribePushRequestModel model =
                                  SubscribePushRequestModel(
                                      subscribeData: subscribeData);
                              APIService.subscribe(model);
                              return const ChatBotScreen();
                            },
                          ), (route) => false)
                        }
                      else
                        {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("ERROR!!!"),
                              content: const Text("Wrong email or password"),
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
              "Chưa có tài khoản? ",
              style: TextStyle(color: Theme.of(context).iconTheme.color),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text(
                "Đăng ký",
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
