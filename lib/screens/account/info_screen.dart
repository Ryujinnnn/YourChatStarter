// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../../main.dart';
import '../../models/edit_request.dart';
import '../../models/profile_respond.dart';
import '../../services/api_service.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  //UserRespondModel user;
  //UserRespondModel user;
  late ProfileRespondModel profile;
  bool circular = true;
  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  late File file;
  ImagePicker imagePicker = ImagePicker();
  bool isAPIcallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController paidValidUntilController = TextEditingController();
  TextEditingController statusController = TextEditingController();
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
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Ch???nh s???a h??? s??",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                            buildDisableFocusTextField(
                                "T??i kho???n", userNameController),
                            buildEnableFocusTextField("T??n hi???n th???",
                                "Nh???p t??n hi???n th???", displayNameController),
                            buildEnableFocusTextField(
                                "Email", "Nh???p email", emailController),
                            buildDisableFocusTextField(
                                "H???n s??? d???ng d???ch v??? n??ng cao",
                                paidValidUntilController),
                            buildDisableFocusTextField(
                                "H???ng d???ch v???", statusController),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: ElevatedButton(
                                onPressed: () async {
                                  await applyChanges();
                                  _showToast("L??u h??? s?? th??nh c??ng");
                                  Navigator.of(context).pop();
                                },
                                child: Text("L??u h??? s??"),
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor,
                                    minimumSize: Size(
                                        size.width * 0.9, size.height * 0.055),
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
        if (profile.user != null) {
          userNameController.text = response.user.username;
          displayNameController.text = response.user.displayName;
          emailController.text = response.user.email;
          paidValidUntilController.text = response.user.paidValidUntil;
          statusController.text = response.user.status;
          displayNameController.text = response.user.displayName;
        }
        circular = false;
      });
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
// ignore_for_file: unnecessary_null_comparison


 
