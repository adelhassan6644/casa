class SettingModel {
  String? logo;
  String? title;
  String? description;
  int? serviceFee;
  int? tax;
  String? terms;
  String? serverKey;
  String? conditions;

  SettingModel(
      {this.logo,
      this.title,
      this.description,
      this.serviceFee,
      this.tax,
      this.terms,
      this.serverKey,
      this.conditions});

  SettingModel.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    title = json['title'];
    description = json['description'];
    serviceFee = int.tryParse(json['service_fee'].toString()) ?? 00;
    tax = int.tryParse(json['tax'].toString()) ?? 00;
    terms = json['terms'];
    serverKey = json['server_key'];
    conditions = json['conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo'] = logo;
    data['title'] = title;
    data['description'] = description;
    data['service_fee'] = serviceFee;
    data['tax'] = tax;
    data['terms'] = terms;
    data['server_key'] = serverKey;
    data['conditions'] = conditions;
    return data;
  }
}
