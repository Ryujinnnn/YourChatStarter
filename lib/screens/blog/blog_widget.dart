import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:string_to_hex/string_to_hex.dart';
import 'package:your_chat_starter/constants.dart';

import '../../models/blog.dart';
import 'detailblog_screen.dart';

class BlogWidget extends StatefulWidget {
  final BlogList model;

  const BlogWidget({Key? key, required this.model}) : super(key: key);

  @override
  _BlogWidgetState createState() => _BlogWidgetState(this.model);
}

class _BlogWidgetState extends State<BlogWidget> {
  final BlogList model;

  _BlogWidgetState(this.model);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        openBlogDetail(context: context, articleId: model.articleId);
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor.withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  model.imageLink,
                  //"https://image.cooky.vn/recipe/g6/54859/s1242/cooky-recipe-637387013241463008.jpg",
                  fit: BoxFit.fitWidth,
                  height: size.height * 0.25,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 14, right: 14),
              child: Center(
                child: Text(
                  model.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: model.tag.length,
                      itemBuilder: (context, index) {
                        return Center(
                            child: (model.tag[index] != null)
                                ? Container(
                                    margin: EdgeInsets.all(5),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15,
                                          top: 8,
                                          bottom: 8,
                                          right: 15),
                                      child: Text(
                                        model.tag[index].name,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(StringToHex.toColor(
                                            model.tag[index].name)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )
                                : Container());
                      }),
                ],
              ),
            ),
            Container(
                margin:
                    EdgeInsets.only(left: 24, right: 24, bottom: 24, top: 16),
                child: Center(
                  child: Text(model.desc),
                )),
          ],
        ),
      ),
    );
  }

  void openBlogDetail(
      {required BuildContext context, required String articleId}) {
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return DetailBlogWidget(
        id: articleId,
      );
    }));
  }
}
