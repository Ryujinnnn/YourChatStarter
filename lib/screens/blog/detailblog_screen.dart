import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:string_to_hex/string_to_hex.dart';
import '../../constants.dart';
import '../../models/detail_blog_request.dart';
import '../../models/detail_blog_respond.dart';
import '../../services/api_service.dart';

class DetailBlogWidget extends StatefulWidget {
  final String id;

  const DetailBlogWidget({Key? key, required this.id}) : super(key: key);

  @override
  _DetailBlogWidgetState createState() => _DetailBlogWidgetState(this.id);
}

class _DetailBlogWidgetState extends State<DetailBlogWidget> {
  final String id;

  late DetailBlogRespondModel model;
  bool circular = true;

  _DetailBlogWidgetState(this.id);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("Thông tin bài viết"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: circular
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        model.blog.tag[0] != null
                            ? Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 8, bottom: 8, right: 15),
                                  child: Text(
                                    model.blog.tag[0].name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Color(StringToHex.toColor(
                                        model.blog.tag[0].name)),
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            : Container(),
                        SizedBox(
                          width: 15,
                        ),
                        model.blog.tag[1] != null
                            ? Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, top: 8, bottom: 8, right: 15),
                                  child: Text(
                                    model.blog.tag[1].name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Color(StringToHex.toColor(
                                        model.blog.tag[1].name)),
                                    borderRadius: BorderRadius.circular(10)),
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Text(
                            model.blog.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        "Bài đăng lúc: " + model.blog.createOn,
                        style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.withOpacity(0.7)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Markdown(
                      styleSheet: MarkdownStyleSheet(
                          p: TextStyle(height: 1.5),
                          textAlign: WrapAlignment.spaceAround),
                      data: model.blog.content,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ))
                  ],
                ),
              ),
            ),
    );
  }

  void fetchData() async {
    var temp =
        await APIService.getDetailsBlog(DetailBlogRequestModel(articleId: id));
    setState(() {
      model = temp;
      circular = false;
    });
  }
}
