import 'package:casa/features/notifications/repo/notifications_repo.dart';
import 'package:dio/dio.dart';
import 'package:casa/features/home/repo/home_repo.dart';
import 'package:casa/features/maps/provider/map_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/localization/provider/language_provider.dart';
import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/address/provider/addresses_provider.dart';
import '../../features/address/repo/addresses_repo.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/contact_with_us/provider/contact_provider.dart';
import '../../features/contact_with_us/repo/contact_repo.dart';
import '../../features/favourite/provider/favourite_provider.dart';
import '../../features/favourite/repo/favourite_repo.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/maps/repo/map_repo.dart';
import '../../features/reservations/provider/reservations_provider.dart';
import '../../features/reservations/repo/reservations_repo.dart';
import '../../features/notifications/provider/notifications_provider.dart';
import '../../features/product_details/provider/product_details_provider.dart';
import '../../features/product_details/repo/product_details_repo.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../features/profile/repo/profile_repo.dart';
import '../../features/setting/provider/setting_provider.dart';
import '../../features/setting/repo/setting_repo.dart';
import '../../main_page/provider/main_page_provider.dart';
import '../api/end_points.dart';
import '../network/network_info.dart';
import '../dio/dio_client.dart';
import '../dio/logging_interceptor.dart';
import '../../features/auth/repo/auth_repo.dart';
import '../../features/splash/provider/splash_provider.dart';
import '../../features/splash/repo/splash_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => DioClient(
        EndPoints.baseUrl,
        dio: sl(),
        loggingInterceptor: sl(),
        sharedPreferences: sl(),
      ));

  // Repository
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(
      () => AuthRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => ProfileRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => HomeRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(
      () => ReservationsRepo(sharedPreferences: sl(), dioClient: sl()));

  sl.registerLazySingleton(
      () => NotificationsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => FavouriteRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => MapRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => ProductDetailsRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => SettingRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => ContactRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(
      () => AddressesRepo(sharedPreferences: sl(), dioClient: sl()));

  //provider
  sl.registerLazySingleton(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => LanguageProvider());
  sl.registerLazySingleton(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SplashProvider(splashRepo: sl()));
  sl.registerLazySingleton(() => MainPageProvider());
  sl.registerLazySingleton(() => AuthProvider(authRepo: sl()));
  sl.registerLazySingleton(() => FavouriteProvider(favouriteRepo: sl()));
  sl.registerLazySingleton(() => ProductDetailsProvider(repo: sl()));
  sl.registerLazySingleton(() => HomeProvider(homeRepo: sl()));
  sl.registerLazySingleton(() => ReservationsProvider(repo: sl()));
  sl.registerLazySingleton(
      () => NotificationsProvider(notificationsRepo: sl()));
  sl.registerLazySingleton(() => ProfileProvider(profileRepo: sl()));
  sl.registerLazySingleton(() => MapProvider(mapRepo: sl()));
  sl.registerLazySingleton(() => AddressesProvider(repo: sl()));
  sl.registerLazySingleton(() => SettingProvider(repo: sl()));
  sl.registerLazySingleton(() => ContactProvider(contactRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
