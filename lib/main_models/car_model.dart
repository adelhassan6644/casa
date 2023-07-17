class CarModel {
  String? name;
  int? model;
  String? palletNumber;
  int? seatsCount;
  String? carImage;
  String? licenceImage;
  String? insuranceImage;
  String? formImage;

  CarModel({
    this.name,
    this.model,
    this.palletNumber,
    this.seatsCount,
    this.carImage,
    this.licenceImage,
    this.insuranceImage,
    this.formImage,
  });

  CarModel copyWith({
    String? name,
    int? model,
    String? palletNumber,
    int? seatsCount,
    String? carImage,
    String? licenceImage,
    String? insuranceImage,
    String? formImage,
  }) =>
      CarModel(
        name: name ?? this.name,
        model: model ?? this.model,
        palletNumber: palletNumber ?? this.palletNumber,
        seatsCount: seatsCount ?? this.seatsCount,
        carImage: carImage ?? this.carImage,
        licenceImage: licenceImage ?? this.licenceImage,
        insuranceImage: insuranceImage ?? this.insuranceImage,
        formImage: formImage ?? this.formImage,
      );

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        name: json["name"],
        model: json["model"],
        palletNumber: json["pallet_number"],
        seatsCount: json["seats_count"],
        carImage: json["car_image"],
        licenceImage: json["licence_image"],
        insuranceImage: json["insurance_image"],
        formImage: json["form_image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "model": model,
        "pallet_number": palletNumber,
        "seats_count": seatsCount,
        "car_image": carImage,
        "licence_image": licenceImage,
        "insurance_image": insuranceImage,
        "form_image": formImage,
      };
}
