import 'package:firebase_core/firebase_core.dart';
import 'package:casa/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'app/core/utils/app_storage_keys.dart';
import 'app/core/utils/un_focus.dart';
import 'app/localization/localization/app_localization.dart';
import 'app/localization/provider/localization_provider.dart';
import 'app/notifications/my_notification.dart';
import 'app/theme/dark_theme.dart';
import 'app/theme/light_theme.dart';
import 'app/theme/theme_provider/theme_provider.dart';
import 'data/config/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/core/utils/app_strings.dart';
import 'features/address/page/addresses_page.dart';
import 'features/product_details/page/product_details.dart';
import 'main_page/pages/dashboard.dart';
import 'navigation/custom_navigation.dart';
import 'navigation/routes.dart';
import 'package:casa/data/config/di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseNotifications.init();
  await di.init();
  runApp(
      MultiProvider(providers: ProviderList.providers, child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<Locale> locals = [];
    for (var language in AppStorageKey.languages) {
      locals.add(Locale(language.languageCode!, language.countryCode));
    }

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));

    return MaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: UnFocus(child: child!)),
      initialRoute: Routes.SPLASH,
      navigatorKey: CustomNavigator.navigatorState,
      onGenerateRoute: CustomNavigator.onCreateRoute,
      // home: const AddressPage(),
      navigatorObservers: [CustomNavigator.routeObserver],
      title: AppStrings.appName,
      scaffoldMessengerKey: CustomNavigator.scaffoldState,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(
        context,
      ).darkTheme ? dark : light,
      supportedLocales: locals,
      locale: Provider.of<LocalizationProvider>(
        context,
      ).locale,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
