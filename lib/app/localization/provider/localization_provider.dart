import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';

class LocalizationProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  LocalizationProvider({required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  Locale _locale =   const Locale('ar', 'SA');
  bool _isLtr = false;
  Locale get locale => _locale;
  bool get isLtr => _isLtr;

   bool _isBottomSheet = false;
  bool get isBottomSheet => _isBottomSheet;


  bottomSheetMode(){
    _isBottomSheet = true;
    notifyListeners();
  }

  nonBottomSheetMode(){
    _isBottomSheet = false;
    notifyListeners();
  }

  void setLanguage(Locale locale) {
    _locale = locale;
    if(_locale.languageCode == 'ar') {
      _isLtr = false;
    }else {
      _isLtr = true;
    }
    _saveLanguage(_locale);
    notifyListeners();

  }

  _loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences.getString(AppStorageKey.languageCode) ?? 'ar',
        sharedPreferences.getString(AppStorageKey.countryCode) ?? 'SA');
    _isLtr = _locale.languageCode == 'en' ;
    notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppStorageKey.languageCode, locale.languageCode);
    sharedPreferences.setString(AppStorageKey.countryCode, locale.countryCode!);
  }
}