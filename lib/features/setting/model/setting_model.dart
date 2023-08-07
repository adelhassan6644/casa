class SettingModel {
  String? logo;
  String? title;
  String? description;
  String? serviceFee;
  String? tax;
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
    serviceFee = json['service_fee'];
    tax = json['tax'];
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
