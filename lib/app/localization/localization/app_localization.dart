import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../app/core/utils/app_storage_keys.dart';

class AppLocalization {


  late Locale locale;
  AppLocalization(this.locale);
  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  Map<String, String>? localizedValues;

  Future<void> load() async {
    String jsonStringValues = await rootBundle.loadString('assets/language/${locale.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    localizedValues = mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return localizedValues![key]??"$key translate not found";
  }

  static const LocalizationsDelegate<AppLocalization> delegate = _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate extends LocalizationsDelegate<AppLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    List<String> languageString = [];
    for (var language in AppStorageKey.languages) {
      languageString.add(language.languageCode!);
    }
    return languageString.contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization =  AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) => false;
}

