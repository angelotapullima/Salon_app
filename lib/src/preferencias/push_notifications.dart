import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:salon_app/src/api/token_api.dart';
import 'package:salon_app/src/models/ReceivedNotification.dart';
import 'package:salon_app/src/preferencias/preferencias_usuario.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// Streams are created so that app can respond to notification-related events since the plugin is initialised in the `main` function
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

NotificationAppLaunchDetails? notificationAppLaunchDetails;

Future<void> showNotificationWithIconBadge(ReceivedNotification notification) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails('icon badge channel', 'icon badge name');
  var iOSPlatformChannelSpecifics = const IOSNotificationDetails(badgeNumber: 1);
  var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, '${notification.title}', '${notification.body}', platformChannelSpecifics,
      payload: notification.payload);
}

class FirebaseInstance {
  void initConfig() async {
    await PushNotificationService.initializeApp();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    //await PushNotificationService.initializeApp();

    notificationAppLaunchDetails = await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    var initializationSettingsAndroid = const AndroidInitializationSettings('logo');
    // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
    // of the `IOSFlutterLocalNotificationsPlugin` class
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (int? id, String? title, String? body, String? payload) async {
          didReceiveLocalNotificationSubject.add(
            ReceivedNotification(id: id!, title: title!, body: body!, payload: payload!),
          );
        });
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload!);
    });
  }
}

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? tokenFirebase;
  static StreamController<String> _messageStreamController = StreamController.broadcast();

  static Stream<String> get messagesStream => _messageStreamController.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    //aplicacion minimizada
    if (kDebugMode) {
      print('_backgroundHandler');
      print(message.data);
    }

    //_messageStreamController.add(message.data.toString());
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //primer plano  app abierta
    if (kDebugMode) {
      print('_onMessageHandler');
      print(message.data);
    }

    String title;
    String body;
    if (Platform.isAndroid) {
      title = message.notification!.title!;
      body = message.notification!.title!;
    } else {
      title = message.notification!.title!;
      body = message.notification!.body!;
    }

    ReceivedNotification notification = ReceivedNotification();
    notification.title = title;
    notification.body = body;
    notification.payload = message.data.toString();
    showNotificationWithIconBadge(notification);

    NotificationModel notificationModel = NotificationModel();
    notificationModel.tipo = message.data['tipo'];
    notificationModel.contenido = message.data['Contenido'];
    notificationModel.id = message.data['id'];

    //_messageStreamController.add(message.data.toString());
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    //aplicacion terminada
    if (kDebugMode) {
      print('_onMessageOpenApp');
      print(message.data);
    }
    //_messageStreamController.add(message.data.toString());
  }

  static Future initializeApp() async {
    final tokenApi = TokenApi();

    // Push Notification
    await Firebase.initializeApp();

    messaging.requestPermission();
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }

    //RemoteMessage initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    //print('initialMessage $initialMessage');

    tokenFirebase = await FirebaseMessaging.instance.getToken();

    final prefs = Preferences();

    //String? token = await StorageManager.readData('token');
    if (prefs.token != null) {
      if (prefs.token.length > 0) {
        tokenApi.enviarToken(tokenFirebase!);
        prefs.tokenFirebases = tokenFirebase!;
      }
    }

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //Local Notification
  }

  static closeStreams() {
    _messageStreamController.close();
  }
}
