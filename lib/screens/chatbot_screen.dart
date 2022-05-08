import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:latlong2/latlong.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:your_chat_starter/components/web_view.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/models/message_request_model.dart';
import 'package:your_chat_starter/screens/sign_in/login_screen.dart';
import 'package:your_chat_starter/screens/upgrade_screen.dart';
import 'package:flutter_html/flutter_html.dart';
import '../components/image_dialog.dart';
import '../main.dart';
import '../models/message_value.dart';
import '../models/message_respond.dart';
import '../models/setting_respond.dart';
import '../services/api_service.dart';
import '../services/shared_service.dart';
import 'account/info_setting_screen.dart';
import 'account/personal_setting_screen.dart';
import 'blog/blog_screen.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  ChatBotScreenState createState() => ChatBotScreenState();
}

class ChatBotScreenState extends State<ChatBotScreen> {
  SpeechToText _speechToText = SpeechToText();
  TextToSpeech _textToSpeech = TextToSpeech();
  double volume = 1;
  double rate = 1;
  bool speechEnabled = false;
  bool haveMap = false;
  late String location;

  final TextEditingController messController = TextEditingController();
  List<MessageValueHolder> messages = [];
  List<String> suggestions = [
    "Chào bạn!",
    "Đồng Hới ở đâu?",
    "Thời tiết Thành phố Hồ Chí Minh hôm nay"
  ];
  late SettingRespondModel settingRespondModel =
      SettingRespondModel(desc: "", status: "");
  late String languageCode;
  MessageRespondModel preRespond = MessageRespondModel(response: "temp");
  Map<String, dynamic> contextString = {};
  var fltNotification = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initSpeechToText();
    fetchData();
    _configureLocalTimeZone();
    var androidInitialize = const AndroidInitializationSettings('app_icon');
    var iOSInitialize = const IOSInitializationSettings();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    fltNotification.initialize(
      initializationsSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: chatBody(context),
    );
  }

  Column chatBody(context) => Column(
        children: [
          const SizedBox(
            height: kDefaultPadding,
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: ((context, index) =>
                          chatMessage(messages[index]))))
            ],
          )),
          haveMap ? mapWidget(location) : Container(),
          suggestions.isNotEmpty
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color:
                          Theme.of(context).backgroundColor.withOpacity(0.2)),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 50),
                      child: Center(
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: suggestions.length,
                            itemBuilder: (context, index) => Center(
                                child: suggestionBubble(suggestions[index]))),
                      )),
                )
              : Container(),
          chatInput(context)
        ],
      );

  Scaffold webView(String url) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: kPrimaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }),
          title: Text(
            url,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13.0,
            ),
          ),
          backgroundColor: Colors.white10,
          elevation: 0,
        ),
        body: WebView(initialUrl: url));
  }

  Widget chatMessage(MessageValueHolder message) {
    return Row(
      mainAxisAlignment: message.isBot == false
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 0.75,
              vertical: kDefaultPadding / 2),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: message.isBot == false
                    ? kPrimaryColor
                    : kPrimaryColor.withOpacity(0.4),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: kDefaultPadding * 0.75,
                  right: kDefaultPadding * 0.75,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: message.isBot == false
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                          constraints: const BoxConstraints(maxWidth: 180),
                          child: Html(
                              data: md.markdownToHtml(message.response),
                              onLinkTap: (url, _, __, ___) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            webView(url.toString())));
                              },
                              onImageTap: (src, _, __, ___) {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ImageDialog(src.toString()));
                              })),
                    ),
                  ],
                ),
              )),
        )
      ],
    );
  }

  Container chatInput(context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      decoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
      child: SafeArea(
          child: Row(
        children: [
          IconButton(
              icon: Icon(
                _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
                color: kPrimaryColor,
                size: 35,
              ),
              onPressed: () {
                if (settingRespondModel.preference.allowVoiceRecording ==
                    true) {
                  _speechToText.isNotListening
                      ? _startListening()
                      : _stopListening();
                }
              }),
          SizedBox(
            width: kDefaultPadding,
          ),
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const SizedBox(
                    width: kDefaultPadding,
                  ),
                  Expanded(
                      child: TextField(
                    controller: messController,
                    decoration: InputDecoration(
                      hintText: "Nhập tin nhắn...",
                      border: InputBorder.none,
                    ),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            width: kDefaultPadding / 2,
          ),
          IconButton(
              onPressed: () async {
                if (messController.text.isEmpty) {
                  print("empty message");
                } else {
                  MessageValueHolder mess = MessageValueHolder(
                      response: messController.text, context: {}, isBot: false);
                  setState(() {
                    messages.insert(0, mess);
                  });
                  String saveMess = messController.text;
                  messController.clear();
                  MessageRespondModel respond = await APIService.sendMessage(
                      MessageRequestModel(
                          post: saveMess,
                          isLocal: true,
                          contextString: contextString));
                  MessageValueHolder res = MessageValueHolder(
                      response: respond.response.replaceAllMapped(
                          RegExp(r'\[https.*\]', caseSensitive: false),
                          (match) => ""),
                      context: respond.contextString,
                      isBot: true);

                  if (respond.action.action == "REQUEST_OPENAPP") {
                    //Thêm code mở app tại đây
                  }
                  if (respond.action.action == "REQUEST_NOTIFICATION") {
                    _showNotification(
                        respond.action.data.message
                            .replaceAllMapped(RegExp(r'\"'), (match) => ""),
                        respond.action.data.time);
                  }
                  if (respond.action.action == "SHOW_MAP") {
                    haveMap = true;
                    location = respond.action.data.message;
                  } else {
                    haveMap = false;
                    location = "";
                  }
                  setState(() {
                    messages.insert(0, res);
                    preRespond = respond;
                    suggestions = respond.context.suggestionList;
                    contextString = respond.contextString;
                  });
                  if (settingRespondModel.preference.allowAutoT2s == true) {
                    speak(res.response);
                  }
                }
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              icon: Icon(
                Icons.send,
                size: 30,
                color: kPrimaryColor,
              ))
        ],
      )),
    );
  }

  Container mapWidget(String location) {
    List slocation = location.split(' ');
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: FlutterMap(
        options: MapOptions(
          center:
              LatLng(double.parse(slocation[0]), double.parse(slocation[1])),
          zoom: 13.0,
        ),
        children: <Widget>[
          TileLayerWidget(
              options: TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'])),
        ],
      ),
    );
  }

  Widget suggestionBubble(String value) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              messController.text = value;
            },
            child: Bubble(
                radius: const Radius.circular(15.0),
                color: kPrimaryColor.withOpacity(0.2),
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                          child: Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        child: Text(value, textAlign: TextAlign.center),
                      )),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }

  void fetchData() async {
    bool isLoggedIn = await SharedService.isLoggedIn();
    if (isLoggedIn) {
      var model = await APIService.getSetting();
      setState(() {
        settingRespondModel = model;
        rate = model.preference.voiceRate;
        if (model.preference.voiceSelection != "") {
          print(model.preference.voiceSelection);
          languageCode = model.preference.voiceSelection;
        } else {
          getDefaultLanguage();
        }
      });
    }
  }

  Future<void> _showNotification(String title, String isoDatetime) async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer",
        channelDescription: 'your channel description',
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);
    var timeSchedule = DateTime.parse(isoDatetime);
    Duration dif = timeSchedule.difference(DateTime.now());
    await fltNotification.zonedSchedule(
        0,
        'YourChatStarter',
        title,
        tz.TZDateTime.now(tz.local).add(dif),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  void speak(String text) {
    _textToSpeech.setVolume(volume);
    _textToSpeech.setRate(rate);
    if (languageCode != null) {
      _textToSpeech.setLanguage(languageCode);
    }
    final newText = text.replaceAllMapped(
        RegExp(r"__|\*|\#|!*(?:\[([^\]]*)\]\([^)]*\))"), (match) {
      return '';
    });

    _textToSpeech.speak(newText);
  }

  void _initSpeechToText() async {
    speechEnabled = await _speechToText.initialize();

    setState(() {});
  }

  void getDefaultLanguage() async {
    var language = await _textToSpeech.getLanguages();
    var index = language.indexWhere((val) => val == "vi-VN");
    if (index == -1) {
      //pop up warning no vietnamese speech reg
      return;
    }
    //get vietnamese language code
    languageCode = language[index];
  }

  void _startListening() async {
    var locales = await _speechToText.locales();
    var index = locales.indexWhere((val) => val.localeId == "vi_VN");
    if (index == -1) {
      //pop up warning no vietnamese speech reg
      return;
    }

    // get locale of vietnam
    var selectedLocale = locales[index];

    await _speechToText.listen(
        onResult: _onSpeechResult, localeId: selectedLocale.localeId);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      messController.text = result.recognizedWords;
    });
  }

  FutureOr onGoBack(dynamic value) {
    fetchData();
  }

  AppBar buildAppBar(context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[kPrimaryColor, kPrimaryColor],
          ),
        ),
      ),
      title: Image.asset(
        'assets/images/logo.png',
        fit: BoxFit.fitHeight,
        height: 60,
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BlogScreen()));
            },
            icon: const Icon(Icons.article_outlined, size: 25)),
        IconButton(
            onPressed: () async {
              bool isLoggedIn = await SharedService.isLoggedIn();
              if (isLoggedIn) {
                Navigator.of(context).push(
                    MaterialPageRoute<bool>(builder: (BuildContext context) {
                  return ProfileScreen();
                })).then(onGoBack);
              } else {
                Navigator.of(context).push(
                    MaterialPageRoute<bool>(builder: (BuildContext context) {
                  return const LoginScreen();
                }));
              }
            },
            icon: const Icon(Icons.manage_accounts_rounded, size: 25))
      ],
    );
  }
}
