import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_chat_starter/main.dart';
import 'package:your_chat_starter/screens/chatbot_screen.dart';
import '../../models/setting_request.dart';
import '../../services/api_service.dart';
import '../../services/shared_service.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({Key? key}) : super(key: key);

  @override
  _VoiceScreenState createState() => _VoiceScreenState();
}

bool t2svalue = false;
bool s2tvalue = false;
bool notivalue = false;
double valueRate = 1.0;
String selectedItemLanguage = "";

class _VoiceScreenState extends State<VoiceScreen> {
  bool circular = true;
  bool isAPIcallProcess = false;
  String? _externalUserId;
  TextToSpeech _textToSpeech = TextToSpeech();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  List<String> itemLanguages = [""];
  String defaultItemLanguage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListLanguage();
    getDefaultLanguage();
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
                  colors: <Color>[kPrimaryColor, kSecondaryColor],
                ),
              ),
            ),
            title: Container(
              child: Text(
                "Cài đặt",
                style: TextStyle(color: Colors.white),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    //await applyChanges();
                    setState(() {
                      isAPIcallProcess = true;
                    });
                    await APIService.saveSetting(SettingRequestModel(
                        allowAutoT2s: t2svalue,
                        allowPushNotification: notivalue,
                        allowVoiceRecording: s2tvalue,
                        voiceRate: valueRate));
                    setState(() {
                      isAPIcallProcess = false;
                      saveLocalData();
                      saveVocal();
                    });
                    saveLocalData();
                    saveVocal();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const ChatBotScreen()),
                        (Route<dynamic> route) => false);
                  },
                  icon: Icon(Icons.check))
            ],
          ),
          body: ProgressHUD(
            child: Form(
              key: globalFormKey,
              child: _settingUI(context),
            ),
            inAsyncCall: isAPIcallProcess,
            key: UniqueKey(),
            opacity: 0.3,
          )),
    );
  }

  Widget _settingUI(BuildContext context) {
    return circular
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.only(left: 5, top: 10, right: 10),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Text(
                        "Âm thanh: ",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: kPrimaryColor,
                      ),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            t2svalue = !t2svalue;
                          });
                        },
                        leading: Checkbox(
                            checkColor: Colors.white,
                            activeColor: kPrimaryColor,
                            value: t2svalue,
                            onChanged: (value) {
                              setState(() {
                                t2svalue = !t2svalue;
                              });
                            }),
                        title: Text("Luôn phát âm phản hồi",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8))),
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: kPrimaryColor,
                      ),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            s2tvalue = !s2tvalue;
                          });
                        },
                        leading: Checkbox(
                            checkColor: Colors.white,
                            activeColor: kPrimaryColor,
                            value: s2tvalue,
                            onChanged: (value) {
                              setState(() {
                                s2tvalue = !s2tvalue;
                              });
                            }),
                        title: Text("Cho phép ghi giọng nói",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8))),
                      ),
                    ),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: kPrimaryColor,
                      ),
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            notivalue = !notivalue;
                            OneSignal.shared.disablePush(!notivalue);
                          });
                        },
                        leading: Checkbox(
                            checkColor: Colors.white,
                            activeColor: kPrimaryColor,
                            value: notivalue,
                            onChanged: (value) {
                              setState(() {
                                notivalue = !notivalue;
                                OneSignal.shared.disablePush(!notivalue);
                              });
                            }),
                        title: Text("Nhận thông báo từ dịch vụ",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10),
                      child: Text("Tốc độ nói: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    SliderTheme(
                      data: SliderThemeData(
                        thumbColor: Colors.red,
                      ),
                      child: Slider(
                        activeColor: kPrimaryColor,
                        value: valueRate,
                        onChanged: (newRating) {
                          setState(() {
                            valueRate = newRating;
                          });
                        },
                        min: 0,
                        max: 2,
                        divisions: 20,
                        label: "$valueRate",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("Giọng nói: ",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 15),
                      padding: EdgeInsets.only(left: 15, right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: kPrimaryColor, width: 1)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedItemLanguage,
                          isExpanded: true,
                          items: itemLanguages.map(buildMenuItem).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedItemLanguage = value.toString();
                            });
                          },
                        ),
                      ),
                    )
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
  void getListLanguage() async {
    var language = await _textToSpeech.getLanguages();
    itemLanguages = language;
  }

  void getDefaultLanguage() async {
    var language = await _textToSpeech.getLanguages();
    var index = language.indexWhere((val) => val == "vi-VN");
    if (index == -1) {
      //pop up warning no vietnamese speech reg
      return;
    }
    //get vietnamese language code
    defaultItemLanguage = language[index];
  }

  void saveLocalData() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('s2tvalue', s2tvalue);
    await prefs.setBool('t2svalue', t2svalue);
    await prefs.setBool('notivalue', notivalue);
    await prefs.setDouble('valueRate', valueRate);
  }

  void saveVocal() async {
    final prefs = await SharedPreferences.getInstance();
    (selectedItemLanguage != "") ? selectedItemLanguage : defaultItemLanguage;
    print(selectedItemLanguage);
    await prefs.setString('selectedLanguage', selectedItemLanguage);
  }

  void loadVocal() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('selectedLanguage'));
    if (prefs.getString('selectedLanguage') != defaultItemLanguage) {
      selectedItemLanguage = prefs.getString('selectedLanguage').toString();
    } else {
      selectedItemLanguage = defaultItemLanguage;
    }
  }

  void loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    s2tvalue = prefs.getBool('s2tvalue')!;
    t2svalue = prefs.getBool('t2svalue')!;
    notivalue = prefs.getBool('notivalue')!;
    valueRate = prefs.getDouble('valueRate')!;
  }

  void fetchData() async {
    var model = await APIService.getSetting();
    if (model.status == "failed") {
      setState(() {
        circular = false;
        loadLocalData();
        loadVocal();
      });
    } else {
      setState(() {
        circular = false;
        setState(() {
          s2tvalue = model.preference.allowVoiceRecording;
          t2svalue = model.preference.allowAutoT2s;
          notivalue = model.preference.allowPushNotification;
          valueRate = model.preference.voiceRate;
          loadVocal();
        });
      });
    }
  }
}
