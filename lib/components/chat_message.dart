import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:your_chat_starter/components/image_dialog.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/main.dart';
import 'package:your_chat_starter/models/message_value.dart';

import '../screens/account/font_screen.dart';
import '../screens/chatbot_screen.dart';
import 'custom_page_route.dart';

class ChatMessage extends StatefulWidget {
  MessageValueHolder message;
  MapCallBack map;
  ChatMessage({Key? key, required this.message, required this.map})
      : super(key: key);

  @override
  ChatMessageState createState() => ChatMessageState(this.message, this.map);
}

void loadFontData() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getDouble('fontSize') != null) {
    fontSize = prefs.getDouble('fontSize')!;
  } else {
    fontSize = 15;
  }
}

typedef MapCallBack = void Function(bool isShowed, String location);

class ChatMessageState extends State<ChatMessage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 500), vsync: this)
    ..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutBack,
  );
  final MessageValueHolder message;
  final MapCallBack map;
  ChatMessageState(this.message, this.map);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadFontData();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isBot == false
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 0.75,
              vertical: kDefaultPadding / 2),
          child: ScaleTransition(
            scale: _animation,
            child: Bubble(
                padding: const BubbleEdges.all(2),
                elevation: 0,
                alignment: Alignment.topRight,
                nip: message.isBot == false
                    ? BubbleNip.rightTop
                    : BubbleNip.leftBottom,
                color: message.isBot == false
                    ? kPrimaryColor
                    : kSecondaryColor.withOpacity(0.6),
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
                                style: {
                                  "body": Style(
                                      fontSize: FontSize(fontSize),
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                  "a": Style(
                                      fontSize: FontSize(fontSize),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)
                                },
                                onLinkTap: (url, _, __, ___) {
                                  if (url!.startsWith("openMap"))
                                    setState(() {
                                      map(true, Uri.decodeFull(url));
                                    });
                                  else {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                webView(url.toString()),
                                            direction: AxisDirection.up));
                                  }
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
          ),
        )
      ],
    );
  }

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
}
