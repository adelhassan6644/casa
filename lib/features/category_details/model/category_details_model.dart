import '../../home/models/places_model.dart';

class CategoryDetailsModel {
  String? message;
  Data? data;

  CategoryDetailsModel({this.message, this.data});

  CategoryDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? image;
  String? title;
  String? textColor;
  String? color;
  String? description;
  List<PlaceItem>? places;

  Data(
      {this.id,
      this.image,
      this.title,
      this.textColor,
      this.color,
      this.description,
      this.places});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    textColor = json['text_color'];
    color = json['color'];
    description = json['description'];
    if (json['places'] != null) {
      places = [];
      json['places'].forEach((v) {
        places!.add(PlaceItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    data['text_color'] = textColor;
    data['color'] = color;
    data['description'] = description;
    if (places != null) {
      data['places'] = places!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
