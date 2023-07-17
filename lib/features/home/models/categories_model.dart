class CategoriesModel {
  String? message;
  List<CategoryItem>? data;

  CategoriesModel({this.message, this.data});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(CategoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItem {
  int? id;
  String? image;
  String? title;
  String? color;
  String? textColor;
  String? description;
  String? createdAt;
  String? updatedAt;

  CategoryItem(
      {this.id,
      this.image,
      this.title,
      this.description,
      this.color,
      this.textColor,
      this.createdAt,
      this.updatedAt});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    color = json['color'];
    textColor = json['text_color'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
