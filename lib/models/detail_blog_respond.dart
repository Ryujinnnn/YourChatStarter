import 'dart:convert';
import 'blog.dart';

DetailBlogRespondModel detailBlogRespondJson(String str) =>
    DetailBlogRespondModel.fromJson(json.decode(str));

class DetailBlogRespondModel {
  late String status;
  late Blog blog;

  DetailBlogRespondModel({required this.status, required this.blog});

  DetailBlogRespondModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['blog'] != null) blog = new Blog.fromJson(json['blog']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.blog != null) {
      data['blog'] = this.blog.toJson();
    }
    return data;
  }
}

class Blog {
  late String sId;
  late String title;
  late List<Tag> tag;
  late String desc;
  late String createOn;
  late String content;
  late String articleId;
  late String imageLink;

  Blog(
      {required this.sId,
      required this.title,
      required this.tag,
      required this.desc,
      required this.createOn,
      required this.content,
      required this.articleId,
      required this.imageLink});

  Blog.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    if (json['tag'] != null) {
      tag = <Tag>[];
      json['tag'].forEach((v) {
        tag.add(new Tag.fromJson(v));
      });
    }
    desc = json['desc'];
    createOn = json['createOn'];
    content = json['content'];
    articleId = json['articleId'];
    imageLink = json['imageLink'] != null ? json['imageLink'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    if (this.tag != null) {
      data['tag'] = this.tag.map((v) => v.toJson()).toList();
    }
    data['desc'] = this.desc;
    data['createOn'] = this.createOn;
    data['content'] = this.content;
    data['articleId'] = this.articleId;
    data['imageLink'] = this.imageLink;
    return data;
  }
}
