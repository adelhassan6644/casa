import 'package:casa/features/maps/provider/map_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:casa/data/config/di.dart' as di;

import '../../app/localization/provider/localization_provider.dart';
import '../../app/theme/theme_provider/theme_provider.dart';
import '../../features/address/provider/addresses_provider.dart';
import '../../features/auth/provider/auth_provider.dart';
import '../../features/contact_with_us/provider/contact_provider.dart';
import '../../features/favourite/provider/favourite_provider.dart';
import '../../features/home/provider/home_provider.dart';
import '../../features/product_schedule/provider/product_schedule_provider.dart';
import '../../features/reservations/provider/reservations_provider.dart';
import '../../features/notifications/provider/notifications_provider.dart';
import '../../features/product_details/provider/product_details_provider.dart';
import '../../features/profile/provider/profile_provider.dart';
import '../../features/splash/provider/splash_provider.dart';
import '../../features/setting/provider/setting_provider.dart';
import '../../main_page/provider/main_page_provider.dart';

abstract class ProviderList {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => di.sl<ThemeProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<LocalizationProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<MainPageProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<SplashProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<FavouriteProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProfileProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<HomeProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ReservationsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<NotificationsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<MapProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProductDetailsProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<MapProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<AddressesProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ProductScheduleProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<ContactProvider>()),
    ChangeNotifierProvider(create: (_) => di.sl<SettingProvider>()),
  ];
}
