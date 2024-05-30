import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:wiber_mobile/firebase_options.dart';
import 'package:worker_manager/worker_manager.dart';

import 'injection.dart';
import 'ui/my_app.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("백그라운드 메시지 처리.. ${message.notification!.body!}");
}

void initializeNotification() async {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(const AndroidNotificationChannel(
          'high_importance_channel', 'high_importance_notification',
          importance: Importance.max));

  await flutterLocalNotificationsPlugin.initialize(const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  ));

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(
    nativeAppKey: '868f20dd68b14fe8357b0e7096d15c44',
    javaScriptAppKey: 'b50d10b74c4be8c22f39cfd0fd2cad67',
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("temp_space_id");
  prefs.remove("temp_share_id");

  uriLinkStream.listen((Uri? uri) async {
    if (uri == null) return;

    String url = uri.path;
    String splitUrl = url.split("share=")[1];

    String spaceId = splitUrl.split("-")[0];
    String shareId = splitUrl.split("-")[1];

    prefs.setString("temp_space_id", spaceId);
    prefs.setString("temp_share_id", shareId);
  }, onError: (Object err) {
    print(err);
  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setPreferredOrientations();
  setupDi(Env.dev);

  return runZonedGuarded(() async {
    await Executor().warmUp();

    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
