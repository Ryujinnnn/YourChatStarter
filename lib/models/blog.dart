import 'dart:convert';

BlogRespondModel blogRespondJson(String str) =>
    BlogRespondModel.fromJson(json.decode(str));

class BlogRespondModel {
  late String status;
  late List<BlogList> blogList;

  BlogRespondModel({required this.status, required this.blogList});

  BlogRespondModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['blog_list'] != null) {
      blogList = <BlogList>[];
      json['blog_list'].forEach((v) {
        blogList.add(BlogList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['blog_list'] = blogList.map((v) => v.toJson()).toList();
    return data;
  }
}

class BlogList {
  late String sId;
  late String articleId;
  late String createOn;
  late String desc;
  late String imageLink;
  late List<Tag> tag;
  late String title;

  BlogList(
      {required this.sId,
      required this.articleId,
      required this.createOn,
      required this.desc,
      required this.imageLink,
      required this.tag,
      required this.title});

  BlogList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    articleId = json['articleId'];
    createOn = json['createOn'];
    desc = json['desc'];
    imageLink = json['imageLink'];
    if (json['tag'] != null) {
      tag = <Tag>[];
      json['tag'].forEach((v) {
        tag.add(Tag.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['articleId'] = articleId;
    data['createOn'] = createOn;
    data['desc'] = desc;
    data['imageLink'] = imageLink;
    data['tag'] = tag.map((v) => v.toJson()).toList();
    data['title'] = title;
    return data;
  }
}

class Tag {
  late String name;
  late String color;

  Tag({required this.name, required this.color});

  Tag.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}
