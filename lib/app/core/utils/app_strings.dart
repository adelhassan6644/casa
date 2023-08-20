import '../../../features/language/provider/language_provider.dart';
import '../../../features/maps/models/location_model.dart';
import '../../../main_models/weak_model.dart';

class AppStrings {
  static const String appName = 'Casa';
  static const String googleApiKey = 'AIzaSyBxi2NcKA8JE90J07U9M2D90tHgaSg3Xjg';
  static const String defaultAddress = 'المملكة العربية السعودية ، الرياض';
  static const String defaultLat = '24.67401824245781';
  static const String defaultLong = '46.691234707832336';
  static LocationModel defaultPickUp = LocationModel(
      address: defaultAddress, longitude: defaultLong, latitude: defaultLat);
  static LocationModel defaultDrop = LocationModel(
      address: defaultAddress, longitude: defaultLong, latitude: defaultLat);

  static const String fontFamily = 'ar';
  static const String noRouteFound = 'No Route Found';
  static const String cachedRandomQuote = 'CACHED_RANDOM_QUOTE';
  static const String contentType = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String serverFailure = 'Server Failure';
  static const String cacheFailure = 'Cache Failure';
  static const String unexpectedError = 'Unexpected Error';
  static const String englishCode = 'en';
  static const String arabicCode = 'ar';
  static const String locale = 'locale';
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: 'Images.united_kindom',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: 'Images.arabic',
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];
  static List<WeekModel> days = [
    WeekModel(
      id: 1,
      dayName: "الاثنين",
    ),
    WeekModel(
      id: 2,
      dayName: "الثلاثاء",
    ),
    WeekModel(
      id: 3,
      dayName: "الاربعاء",
    ),
    WeekModel(
      id: 4,
      dayName: "الخميس",
    ),
    WeekModel(
      id: 5,
      dayName: "الجمعة",
    ),
    WeekModel(
      id: 6,
      dayName: "السبت",
    ),
    WeekModel(
      id: 7,
      dayName: "الاحد",
    ),
  ];
}
