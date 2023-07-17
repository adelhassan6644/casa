class NewsModel {
  String? message;
  List<NewsItem>? news;

  NewsModel({this.message, this.news});

  NewsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      news = [];
      json['data'].forEach((v) {
        news!.add(NewsItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (news != null) {
      data['data'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewsItem {
  int? id;
  String? title;
  String? author;
  String? content;
  String? image;
  String? address;
  int? status;
  String? createdAt;
  String? updatedAt;

  NewsItem(
      {this.id,
        this.title,
        this.author,
        this.content,
        this.image,
        this.status,
        this.address,
        this.createdAt,
        this.updatedAt});

  NewsItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    author = json['author'];
    content = json['content'];
    image = json['image'];
    status = json['status'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['author'] = author;
    data['content'] = content;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
