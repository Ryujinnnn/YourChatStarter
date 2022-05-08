// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:your_chat_starter/screens/account/personal_setting_screen.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';

import '../../constants.dart';
import '../../main.dart';
import '../../models/change_password.dart';
import '../../models/edit_request.dart';
import '../../models/profile_respond.dart';
import '../../services/api_service.dart';
import '../../services/shared_service.dart';
import '../upgrade_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //UserRespondModel user;
  late ProfileRespondModel profile;
  bool circular = true;
  late DateTime _selectedDate;
  late File file;
  ImagePicker imagePicker = ImagePicker();
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController paidValidUntilController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late FToast fToast;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast = FToast();
    fToast.init(context);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF1D1D35),
          appBar: AppBar(
            brightness: Brightness.dark,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[kPrimaryColor, kPrimaryColor],
                ),
              ),
            ),
            title: Container(
              child: Text("Thông tin cá nhân"),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  SharedService.logout(context);
                  Navigator.of(context).push(
                      MaterialPageRoute<bool>(builder: (BuildContext context) {
                    return const ChatBotScreen();
                  }));
                },
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute<bool>(
                        builder: (BuildContext context) {
                      return UpgradeActivity();
                    }));
                  },
                  icon: const Icon(
                    Icons.arrow_circle_up_outlined,
                    size: 25,
                  )),
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<bool>(builder: (BuildContext context) {
                    return SettingScreen();
                  }));
                },
              )
            ],
          ),
          body: circular
              ? Center(child: CircularProgressIndicator())
              : ProgressHUD(
                  key: UniqueKey(),
                  child: Form(
                    key: globalFormKey,
                    child: _profileUI(context),
                  ),
                  inAsyncCall: isAPIcallProcess)),
    );
  }

  Widget _profileUI(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hồ sơ người dùng: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildEnableFocusTextField(
                  "Tên hiển thị", "Nhập tên hiển thị", displayNameController),
              buildDisableFocusTextField("Tài khoản", userNameController),
              buildDisableFocusTextField("Email", emailController),
              buildDisableFocusTextField(
                  "Hạn sử dụng dịch vụ nâng cao", paidValidUntilController),
              buildDisableFocusTextField("Hạng dịch vụ", statusController),
              buildTextBirthDay(),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () async {
                    await applyChanges();
                    _showToast("Lưu hồ sơ thành công");
                    Navigator.of(context).pop();
                  },
                  child: Text("Lưu hồ sơ"),
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      minimumSize: Size(size.width * 0.9, size.height * 0.055),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Divider(
                thickness: 2,
                color: Colors.black,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Thiết lập bảo mật: ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              buildPasswordTextField("Mật khẩu cũ", oldPasswordController),
              buildPasswordTextField("Mật khẩu mới", newPasswordController),
              buildPasswordTextField(
                  "Xác nhận mật khẩu", confirmPasswordController),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isAPIcallProcess = true;
                    });
                    await APIService.changePassword(ChangePasswordRequestModel(
                        oldPassword: oldPasswordController.text,
                        newPassword: newPasswordController.text,
                        confirmNewPassword: confirmPasswordController.text));
                    setState(() {
                      isAPIcallProcess = false;
                    });
                    _showToast("Thay đổi mật khẩu thành công");
                    Navigator.of(context).pop();
                  },
                  child: Text("Lưu mật khẩu"),
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      minimumSize: Size(size.width * 0.9, size.height * 0.055),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDisableFocusTextField(
      String label, TextEditingController controller) {
    return TextField(
      focusNode: new AlwaysDisabledFocusNode(),
      controller: controller,
      decoration: InputDecoration(
          labelStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
          labelText: label,
          hintStyle: TextStyle(
            fontSize: 16,
            color: Colors.grey.withOpacity(0.3),
          )),
    );
  }

  Widget buildEnableFocusTextField(
      String label, String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
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
        if (response.user != null) {
          userNameController.text = response.user.username;
          displayNameController.text = response.user.displayName;
          emailController.text = response.user.email;
          paidValidUntilController.text = response.user.paidValidUntil;
          statusController.text = response.user.status;
          displayNameController.text = response.user.displayName;
          // birthDayController.text = response.user.birthday != null
          //     ? DateFormat.yMMMd().format(DateTime.parse(response.user.birthday))
          //     : "";
        }
        circular = false;
      });
    }
  }

  Widget buildTextBirthDay() {
    return TextField(
      focusNode: new AlwaysDisabledFocusNode(),
      controller: birthDayController,
      decoration: InputDecoration(
        labelText: "Birth day",
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        hintText: "Birth day",
        hintStyle: TextStyle(
          fontSize: 16,
          color: Colors.grey.withOpacity(0.3),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onTap: () {
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1960),
      lastDate: DateTime(2040),
      // builder: (context, Theme child) async {
      //   assert(context != null);
      //   return Theme(
      //     data: ThemeData.dark().copyWith(
      //       colorScheme: ColorScheme.dark(
      //         primary: Colors.deepPurple,
      //         onPrimary: Colors.white,
      //         surface: Colors.blueGrey,
      //         onSurface: Colors.black,
      //       ),
      //       dialogBackgroundColor: Colors.blue[50],
      //     ),
      //     child: child,
      //   );
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      birthDayController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: birthDayController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  applyChanges() async {
    setState(() {
      isAPIcallProcess = true;
    });
    var model = EditProfileRequestModel(
      username: userNameController.text,
      email: emailController.text,
      birthday: _selectedDate != null
          ? _selectedDate.toIso8601String()
          : profile.user.birthday,
      displayName: displayNameController.text,
    );

    await APIService.saveProfile(model);
    setState(() {
      isAPIcallProcess = false;
    });
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
