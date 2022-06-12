import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:your_chat_starter/components/chat_message.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_chat_starter/main.dart';
import 'package:your_chat_starter/models/message_value.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';

class FontScreen extends StatefulWidget {
  const FontScreen({Key? key}) : super(key: key);

  @override
  _FontScreenState createState() => _FontScreenState();
}

double fontSize = 15;
String selectedFontStyle = "Roboto";
List<String> fontList = ["Roboto"];

class _FontScreenState extends State<FontScreen> {
  bool circular = true;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
          child: Text(
            "Phông chữ",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
              onPressed: () async {
                //await applyChanges();
                setState(() {
                  saveLocalData();
                });
                saveLocalData();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const ChatBotScreen()),
                    (Route<dynamic> route) => false);
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: Form(
        key: globalFormKey,
        child: _settingUI(context),
      ),
    );
  }

  Widget _settingUI(BuildContext context) {
    return circular
        ? const Center(child: const CircularProgressIndicator())
        : Container(
            padding: const EdgeInsets.only(left: 5, top: 10, right: 10),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Text("Cỡ chữ: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).iconTheme.color)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "A",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 10),
                        ),
                        SliderTheme(
                          data: const SliderThemeData(
                            thumbColor: Colors.red,
                          ),
                          child: Slider(
                            activeColor: kPrimaryColor,
                            value: fontSize,
                            onChanged: (newRating) {
                              setState(() {
                                fontSize = newRating;
                              });
                            },
                            min: 10,
                            max: 20,
                            divisions: 4,
                            label: "$fontSize",
                          ),
                        ),
                        const Text(
                          "A",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Text("Kiểu chữ: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).iconTheme.color)),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 15),
                      padding: const EdgeInsets.only(top: 30, left: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kPrimaryColor, width: 1),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedFontStyle,
                          selectedItemBuilder: (BuildContext context) {
                            return fontList.map((String value) {
                              return Text(
                                selectedFontStyle,
                                style: TextStyle(
                                    color: Theme.of(context).iconTheme.color),
                              );
                            }).toList();
                          },
                          //isExpanded: true,
                          items: fontList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedFontStyle = value.toString();
                            });
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 30),
                      child: Text("Xem trước: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).iconTheme.color)),
                    ),
                    ChatMessage(
                        message: MessageValueHolder(
                            response: "Xin chào", context: {}, isBot: true)),
                    ChatMessage(
                        message: MessageValueHolder(
                            response: "Chào bạn", context: {}, isBot: false))
                  ],
                )),
          );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8)),
      ));

  void saveLocalData() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontSize', fontSize);
  }

  void loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getDouble('fontSize') != null) {
      fontSize = prefs.getDouble('fontSize')!;
    } else {
      fontSize = 15;
    }
  }

  void fetchData() async {
    setState(() {
      circular = false;
      loadLocalData();
    });
  }
}
