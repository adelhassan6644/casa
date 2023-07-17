import 'package:flutter/cupertino.dart';
import '../main_models/weak_model.dart';

class ScheduleProvider extends ChangeNotifier {
  List<WeekModel> selectedDays = [];

  onSelectDay(WeekModel value) {
    if (checkSelectDay(value)) {
      selectedDays.removeAt(
          selectedDays.indexWhere((element) => element.id == value.id));
    } else {
      selectedDays.add(value);
    }
    notifyListeners();
  }

  checkSelectDay(WeekModel value) {
    return selectedDays.indexWhere((element) => element.id == value.id) == -1
        ? false
        : true;
  }
}
