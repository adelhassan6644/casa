import 'package:casa/features/address/model/address_model.dart';
import 'package:casa/features/product_schedule/model/schedule_model.dart';
import '../../../main_models/item_model.dart';

class PaymentBodyModel {
  ScheduleModel? scheduleModel;
  AddressItem? addressItem;
  ItemModel? model;

  PaymentBodyModel({this.scheduleModel, this.addressItem, this.model});

  PaymentBodyModel copyWith(
      {ScheduleModel? scheduleModel,
      AddressItem? addressItem,
      ItemModel? model}) {
    this.scheduleModel = scheduleModel ?? this.scheduleModel;
    this.addressItem = addressItem ?? this.addressItem;
    this.model = model ?? this.model;
    return this;
  }
}
