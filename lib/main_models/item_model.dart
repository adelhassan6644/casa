class ItemModel {
  int? id;
  String? description;
  String? name;
  String? title;
  String? image;
  List<String>? images;
  int? price;
  String? service;
  String? subService;

  ItemModel(
      {this.id,
      this.description,
      this.name,
      this.title,
      this.image,
      this.images,
      this.price,
      this.service,
      this.subService});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    name = json['name'];
    title = json['title'];
    image = json['image'];
    images =json['images'] != null?  json['images'].cast<String>() : null;
    price = json['price'];
    service = json['service'];
    subService = json['subService'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['name'] = name;
    data['title'] = title;
    data['image'] = image;
    data['images'] = images;
    data['price'] = price;
    data['service'] = service;
    data['subService'] = subService;
    return data;
  }
}
