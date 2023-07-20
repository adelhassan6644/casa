import '../../home/models/places_model.dart';

class FavouriteModel {
  String? message;
  List<ProductItem>? data;

  FavouriteModel({this.message, this.data});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductItem>[];
      json['data'].forEach((v) {
        data!.add(ProductItem.fromJson(v));
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

