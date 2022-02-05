import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:guardian/bloc/home_bloc/home_bloc.dart';
import 'package:guardian/common/pref_keys.dart';
import 'package:guardian/common/text_assets.dart';
import 'package:guardian/di/injection_container.dart' as di;
import 'package:guardian/di/injection_container.dart';
import 'package:guardian/repository/location_repository.dart';
import 'package:guardian/ui/home_page.dart';
import 'package:guardian/ui/intro_page.dart';
import 'package:guardian/ui/webview_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:guardian/common/common_ext.dart';

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

///Handling bg notification
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  final SendPort? send = IsolateNameServer.lookupPortByName('port_name');
  send?.send(true);
  return;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();

  ///FCM
  await Firebase.initializeApp();
  // subscribe to topic on each app start-up
  await FirebaseMessaging.instance.subscribeToTopic('guardian-exposure');

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'Channel ID', // id
      'name', // title
      'description', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.

  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _pref = di.sl<SharedPreferences>();

  @override
  void initState() {
    super.initState();
    _pref.setBool(PrefKeys.isLocationStarted, false);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guardian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SFUIText',
        primarySwatch: Colors.blue,
      ),
      // home: HomePage()
      home: _initMainScreen(),
    );
  }

  Widget? _initMainScreen() {
    if (_pref.getBool(PrefKeys.isIntroDone) == true) {
      return HomePage();
    } else {
      return IntroScreen();
    }
  }
}
