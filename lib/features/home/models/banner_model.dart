import 'package:casa/features/home/models/places_model.dart';

class BannerModel {
  String? message;
  List<Data>? data;

  BannerModel({this.message, this.data});

  BannerModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  String? image;
  String? title;
  PlaceItem? place;

  Data({this.id, this.image, this.title, this.place});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    place = json['place'] != null ? PlaceItem.fromJson(json['place']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['title'] = title;
    if (place != null) {
      data['place'] = place!.toJson();
    }
    return data;
  }
}
