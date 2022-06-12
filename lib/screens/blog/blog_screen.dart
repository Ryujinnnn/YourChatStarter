import 'package:flutter/material.dart';
import 'package:your_chat_starter/constants.dart';
import 'package:your_chat_starter/main.dart';

import '../../services/api_service.dart';
import 'blog_widget.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<BlogWidget> blogData = [];
  bool circular = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var temp = await APIService.getBlog();
    List<BlogWidget> tempBlogData = [];
    for (var i in temp.blogList) {
      tempBlogData.add(BlogWidget(
        model: i,
      ));
    }
    setState(() {
      blogData = tempBlogData;
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          brightness: Brightness.dark,
          title: Text("Bài viết"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[kPrimaryColor, kSecondaryColor],
              ),
            ),
          ),
        ),
        body: circular
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemBuilder: (context, i) {
                  return blogData[i];
                },
                itemCount: blogData.length,
              ));
  }
}
