// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:your_chat_starter/screens/account/voice_screen.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';

import '../../components/custom_page_route.dart';
import '../../constants.dart';
import '../../main.dart';
import '../../models/change_password_request.dart';
import '../../models/edit_request.dart';
import '../../models/profile_respond.dart';
import '../../services/api_service.dart';
import '../../services/shared_service.dart';
import 'upgrade_screen.dart';

class PasswordScreen extends StatefulWidget {
  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  //UserRespondModel user;
  late ProfileRespondModel profile;
  bool circular = true;
  String failureText = "";
  late File file;
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late FToast fToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    return Scaffold(
        backgroundColor: Color(0xFF1D1D35),
        appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[kPrimaryColor, kSecondaryColor],
              ),
            ),
          ),
          title: Container(
            child: Text("Thi???t l???p b???o m???t"),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: circular
            ? Center(child: CircularProgressIndicator())
            : ProgressHUD(
                key: UniqueKey(),
                child: Form(
                  key: globalFormKey,
                  child: _profileUI(context),
                ),
                inAsyncCall: isAPIcallProcess));
  }

  Widget _profileUI(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            border: Border.all(color: kPrimaryColor),
          ),
          padding: EdgeInsets.only(left: 15, top: 25, right: 15),
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        "?????i m???t kh???u ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor),
                      ),
                      buildPasswordTextField(
                          "M???t kh???u c??", oldPasswordController),
                      buildPasswordTextField(
                          "M???t kh???u m???i", newPasswordController),
                      buildPasswordTextField(
                          "X??c nh???n m???t kh???u", confirmPasswordController),
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isAPIcallProcess = true;
                            });
                            await APIService.changePassword(
                                    ChangePasswordRequestModel(
                                        oldPassword: oldPasswordController.text,
                                        newPassword: newPasswordController.text,
                                        confirmNewPassword:
                                            confirmPasswordController.text))
                                .then((response) => {
                                      setState(() {
                                        isAPIcallProcess = false;
                                        switch (response.desc) {
                                          case "missing required field":
                                            failureText =
                                                "Ch??a nh???p ????? c??c tr?????ng";
                                            break;
                                          case "old password is incorrect":
                                            failureText =
                                                "M???t kh???u c?? kh??ng ch??nh x??c";
                                            break;
                                          case "new password and confirm password does not match":
                                            failureText =
                                                "X??c nh???n m???t kh???u kh??ng tr??ng kh???p";
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
                                          _showToast(
                                              "Thay ?????i m???t kh???u th??nh c??ng"),
                                          Navigator.of(context).pop()
                                        }
                                      else
                                        {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: const Text(
                                                  "Thay ?????i m???t kh???u th???t b???i"),
                                              content: Text(failureText),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(
                                                        color: kPrimaryColor),
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
                          },
                          child: Text("L??u m???t kh???u"),
                          style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor,
                              minimumSize:
                                  Size(size.width * 0.9, size.height * 0.055),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ))),
    );
  }

  Widget buildDisableFocusTextField(
      String label, TextEditingController controller) {
    return TextField(
      focusNode: new AlwaysDisabledFocusNode(),
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
        labelText: label,
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
    );
  }

  Widget buildEnableFocusTextField(
      String label, String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey.withOpacity(0.3),
          )),
    );
  }

  Widget buildPasswordTextField(
      String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      obscureText: true,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey.withOpacity(0.3),
          )),
    );
  }

  _showToast(String content) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text(content),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 3),
    );
  }

  void fetchData() async {
    if (isLogin = true) {
      var response = await APIService.getProfile();
      setState(() {
        profile = response;
        circular = false;
      });
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
