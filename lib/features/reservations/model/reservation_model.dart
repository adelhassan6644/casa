class ReservationModel {
  int? id;
  String? image;
  String? service;
  String? subService;
  int? subServiceID;
  int? price;
  DateTime? date;
  DateTime? startTime;
  DateTime? endTime;
  String? address;

  ReservationModel(
      {this.id,
      this.service,
      this.subService,
      this.price,
      this.date,
      this.startTime,
        this.subServiceID,
      this.endTime,
      this.address});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service = json['service'];
    image = json['image'];
    subService = json['subService'];
    subServiceID = json['subService_id'];
    price = json['price'];
    date = json['date'] != null ? DateTime.parse(json['date']) : DateTime.now();
    startTime = json['start_time'] != null
        ? DateTime.parse(json['start_time'])
        : DateTime.now();
    endTime = json['end_time'] != null
        ? DateTime.parse(json['end_time'])
        : DateTime.now();
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service'] = service;
    data['image'] = image;
    data['subService'] = subService;
    data['price'] = price;
    data['date'] = date?.toIso8601String();
    data['start_time'] = startTime?.toIso8601String();
    data['end_time'] = endTime?.toIso8601String();
    data['address'] = address;
    return data;
  }
}
