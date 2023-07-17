class BaseModel {
  void Function(dynamic)? valueChanged;
  dynamic object;
  bool? boolean;
  BaseModel({
    this.valueChanged,
    this.object,
    this.boolean,
  });
}
