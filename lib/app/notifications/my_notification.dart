import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../firebase_options.dart';
import '../../navigation/custom_navigation.dart';
import '../../navigation/routes.dart';
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  log('Handling a background message ${message.data}');
}

abstract class FirebaseNotifications {
  static FirebaseMessaging? _firebaseMessaging;
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static AndroidNotificationChannel? _channel;

  static init() async {
    flutterLocalNotificationsPlugin!.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
    _channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      // 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    _firebaseMessaging = FirebaseMessaging.instance;
    flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
    flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel!);
    flutterLocalNotificationsPlugin!.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@drawable/notification_icon'),
      iOS: DarwinInitializationSettings(
          defaultPresentBadge: true,
          defaultPresentAlert: true,
          defaultPresentSound: true),
    )
    );
    _firebaseMessaging!.setAutoInitEnabled(true);
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    if (Platform.isIOS) {
      _firebaseMessaging!.requestPermission(
          alert: true, announcement: true, badge: true, sound: true);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Handling on message ${message.data}');
      if (Platform.isAndroid) {
        flutterLocalNotificationsPlugin!.show(
          message.notification.hashCode,
          message.notification!.title,
          message.notification!.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _channel!.id,
              _channel!.name,
              // _channel!.description,
              icon: '@drawable/notification_icon',
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('Handling message open app ${message.data}');
      // CustomNavigator.push(Routes.NOTIFICATIONS,);
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      log('Handling initial message  ${message?.data}');
    });
    flutterLocalNotificationsPlugin!
        .getNotificationAppLaunchDetails()
        .then((value) {
      log('Handling if local notification launch app  ${value!.notificationResponse}');
    });
  }

  static scheduleNotification(String title, String subtitle) async {
    var rng = math.Random();
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        // 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker');
    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!.show(
        rng.nextInt(100000), title, subtitle, platformChannelSpecifics,
        payload: 'item x');
  }
}
