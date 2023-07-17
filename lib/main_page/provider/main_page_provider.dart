import 'package:flutter/material.dart';

class MainPageProvider extends ChangeNotifier {
  bool? isOpen;
  updateIsOpen(v) {
    isOpen = v;
    notifyListeners();
  }

  int selectedIndex = 0;

  updateDashboardIndex(v, {bool isOpen = false}) {
    isOpen = false;
    selectedIndex = v;
    notifyListeners();
  }
}
