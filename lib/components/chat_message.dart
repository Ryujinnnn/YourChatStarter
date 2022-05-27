import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:your_chat_starter/components/image_dialog.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/models/message_value.dart';

class ChatMessage extends StatefulWidget {
  final MessageValueHolder message;
  const ChatMessage({Key? key, required this.message}) : super(key: key);

  @override
  ChatMessageState createState() => ChatMessageState(this.message);
}

class ChatMessageState extends State<ChatMessage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 1000), vsync: this)
    ..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceOut,
  );
  final MessageValueHolder message;
  ChatMessageState(this.message);

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
                padding: BubbleEdges.all(2),
                shadowColor: Colors.green,
                alignment: Alignment.topRight,
                nip: message.isBot == false
                    ? BubbleNip.rightTop
                    : BubbleNip.leftTop,
                color: message.isBot == false
                    ? kPrimaryColor
                    : kPrimaryColor.withOpacity(0.4),
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
