import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:guardian/bloc/home_bloc/home_bloc.dart';
import 'package:guardian/common/color_assets.dart';
import 'package:guardian/common/common_ext.dart';
import 'package:guardian/common/common_methos.dart';
import 'package:guardian/common/common_methos_ios.dart';
import 'package:guardian/common/common_widget.dart';
import 'package:guardian/common/image_assets.dart';
import 'package:guardian/common/pref_keys.dart';
import 'package:guardian/common/text_assets.dart';
import 'package:guardian/common/tracker/circle_painter.dart';
import 'package:guardian/di/injection_container.dart';
import 'package:guardian/main.dart';
import 'package:guardian/repository/location_repository.dart';
import 'package:guardian/ui/webview_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  final double size = 80.0;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController animationController;
  late Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  late Animation rotationAnimation;
  bool isStarted = false;
  late Color buttonShadow;
  late String buttonText = TextAsset.start;

  String latitude = 'waiting...';
  String longitude = 'waiting...';
  String altitude = 'waiting...';
  String accuracy = 'waiting...';
  String bearing = 'waiting...';
  String speed = 'waiting...';
  String time = 'waiting...';
  late RemoteMessage foregroundMessage;
  late RemoteMessage payloadGlobal;
  var initializationSettings;
  var initializationSettingsAndroid;
  var initializationSettingsIOS;

  HomeBloc _blocHome = sl<HomeBloc>();
  var _pref = sl<SharedPreferences>();
  ReceivePort _port = ReceivePort();

  List<Widget> exposureWidgetList = [];
  SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.dark;

  receiveNotification() {
    print("receiveNotification......");
    _blocHome.add(GetExposureListEvent());
  }

  @override
  void initState() {
    super.initState();
    _blocHome = HomeBloc(sl<LocationRepository>(), _pref);
    isStarted = _pref.getBool(PrefKeys.isLocationStarted) ?? false;
    initAnimations();
    buttonShadow = setTrackerShadowColor();
    // __blocHome.exposureSitesApiCall();
    _blocHome.add(GetExposureListEvent());

    ///FCM
    setupPermissionAndToken();
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        bool isAndroid = Platform.isIOS ? false : true;
        String typeCheck = Platform.isIOS
            ? value.data['CustomData']['type']
            : value.data['type'];
        print('### Notification received');
        /*switch (typeCheck) {
          case "admin":
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => NotificationListPage()));
            break;
        }*/
        // Navigator.pushNamed(context, Routes.HOME);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      /*String payload = Platform.isIOS
          ? message.data['CustomData']['type']
          : message.data['type'];*/

      RemoteNotification? notification = message.notification;
      print('### Notification received $notification');
      _blocHome.add(GetExposureListEvent());

      ///For showing  notification on push receive
      /*try {
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null && !kIsWeb) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  //      one that already exists in example app.
                  icon: 'launch_background',
                ),
              ));
        }
      } catch (exception) {
        print('exception forgetting notification $exception');
      }*/
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print('### Notification clicked');
        var date = stringFromDateTime(DateTime.now(), FORMAT4);
        _pref.setString(PrefKeys.received, date);
        bool isAndroid = Platform.isIOS ? false : true;
        String typeCheck = Platform.isIOS
            ? message.data['CustomData']['type']
            : message.data['type'];
        WebViewPage(link: TextAsset.notificationRedirectLink).push(context);
        switch (typeCheck) {
          /*case "admin":
          Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => NotificationListPage()));
          break;*/
        }
      },
    );

    IsolateNameServer.registerPortWithName(_port.sendPort, 'port_name');
    _port.listen((dynamic data) {
      /// navigate here
      print(".....BABA.....");
      _blocHome.add(GetExposureListEvent());
    });
  }

  setupPermissionAndToken() async {
    initializationSettingsAndroid =
        AndroidInitializationSettings('launch_background');
    initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        // your call back to the UI
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    _pref.setString(PrefKeys.received, DateTime.now().toString());

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    // ---------------------------  Token ----------------------
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('### Token == $fcmToken');
  }

  Future selectNotification(String? payload) async {
    print('### selectNotification $payload');
    WebViewPage(link: TextAsset.notificationRedirectLink).push(context);
    bool isAndroid = Platform.isIOS ? false : true;
    String typeCheck = Platform.isIOS
        ? payloadGlobal.data['CustomData']['type']
        : payloadGlobal.data['type'];
    switch (typeCheck) {
      /*case "admin":
        Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) => NotificationListPage()));
        break;*/
    }
  }

  ///Setting Tracker button shadow color.
  Color setTrackerShadowColor() {
    return isStarted
        ? buttonShadow = AppColor.waveShadowGreen
        : buttonShadow = AppColor.waveShadowBlue;
  }

  ///Setting Tracker button color.
  Color setTrackerButtonColor() {
    return isStarted
        ? buttonShadow = AppColor.buttonBgGreen
        : buttonShadow = AppColor.buttonBgBlue;
  }

  ///Setting Tracker button color.
  String setTrackerButtonText() {
    return isStarted
        ? buttonText = TextAsset.stop
        : buttonText = TextAsset.start;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  startSTopEvent(bool allow) {
    if (allow == true) {
      // isStarted = !isStarted;
      // _pref.setBool(PrefKeys.isLocationStarted, isStarted);
      if (isStarted == true) {
        _blocHome.add(StopTrackingEvent());
      } else {
        _blocHome.add(StartTrackingEvent());
      }
    }
  }

  Widget _button() {
    return Center(
      child: GestureDetector(
        onTap: () {
          if (Platform.isIOS) {
            checkLocationPermissionIOS(context, callback: (allow) {
              startSTopEvent(allow);
            });
          } else {
            checkLocationPermission(context, callback: (allow) {
              startSTopEvent(allow);
            });
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(500.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[
                  setTrackerShadowColor(),
                  Color.lerp(setTrackerShadowColor(), Colors.black, .05)!
                ],
              ),
            ),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: setTrackerButtonColor(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  commonTextNoHeight(buttonText, Colors.white, 26.0,
                      weight: FontWeight.w600),
                  commonTextNoHeight(TextAsset.tracking, Colors.white, 14.0,
                      weight: FontWeight.w400),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUI() {
    return BlocConsumer(
      buildWhen: (previousState, state) {
        return true;
      },
      bloc: _blocHome,
      listener: (context, state) {
        print("state==$state");
        if (state is ChangeButtonState) {
          isStarted = state.isStarted ?? false;
          _pref.setBool(PrefKeys.isLocationStarted, isStarted);
          if (state.isStarted == true) {
            buttonShadow = AppColor.buttonBgGreen;
            buttonText = TextAsset.stop;
          } else {
            buttonShadow = AppColor.waveShadowBlue;
            buttonText = TextAsset.start;
          }
        }
      },
      builder: (BuildContext context, HomeState state) {
        return Stack(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              bloc: _blocHome,
              builder: (context, state) {
                if (state is ExposureDetectedState) {
                  exposureWidgetList.clear();
                  if (state.detectedList.isNotEmpty) {
                    state.detectedList.forEach((element) {
                      exposureWidgetList.add(
                        Dismissible(
                          key: Key(element.id.toString()),
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 100.0),
                            child: Card(
                              color: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: InkWell(
                                customBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                onTap: () {
                                  WebViewPage(link: element.url.toString())
                                      .push(context);
                                },
                                child: FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 8,
                                          ),
                                          SvgPicture.asset(
                                            ImageAsset.icInfo,
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              commonTextNoHeight(
                                                  TextAsset.exposureDetected,
                                                  AppColor.buttonBg,
                                                  16.0,
                                                  weight: FontWeight.w400),
                                              Row(
                                                children: [
                                                  commonTextNoHeight(
                                                      stringFromDateTimeWithTH(
                                                        dateTimeFromString(
                                                            element.datetime ??
                                                                '',
                                                            FORMAT5),
                                                      ),
                                                      AppColor.textGrey,
                                                      12.0,
                                                      weight: FontWeight.w400),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  SvgPicture.asset(
                                                    ImageAsset.icDot,
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Container(
                                                    width: 200,
                                                    child: commonTextNoHeight(
                                                        element.title,
                                                        AppColor.textGrey,
                                                        12.0,
                                                        weight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onDismissed: (v) {
                            _blocHome.add(DeleteExposure(element));
                          },
                        ),
                      );
                    });
                  } else {
                    exposureWidgetList.add(
                      Container(
                        margin: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 100.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onTap: () {},
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Center(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ),
                                      SvgPicture.asset(
                                        ImageAsset.icInfo,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          commonTextNoHeight(
                                            TextAsset.noExposure,
                                            AppColor.textGrey,
                                            16.0,
                                            weight: FontWeight.w400,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }

                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Stack(
                    children: exposureWidgetList,
                  ),
                );
              },
            ),
            Positioned(
              top: 80.0,
              right: 1.0,
              left: 1.0,
              child: Hero(
                tag: 'shield',
                child: SvgPicture.asset(
                  ImageAsset.icShield,
                  // height: 80.0,
                  // width: 75.0,
                ),
              ),
            ),
            Center(
              child: CustomPaint(
                painter: CirclePainter(
                  _controller,
                  color: setTrackerShadowColor(),
                ),
                child: SizedBox(
                  width: widget.size * 4.125,
                  height: widget.size * 4.125,
                  child: _button(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  addExposureStackWidget() {}
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _currentStyle,
      child: Scaffold(
        floatingActionButton:
            floatingButton(context, currentScreen: CurrentScreen.HOME),
        backgroundColor: AppColor.appBg,
        body: SafeArea(
          top: false,
          child: (WillPopScope(
            onWillPop: onWillPop,
            child: _buildUI(),
          )),
        ),
      ),
    );
  }

  /// init animation.
  void initAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }
}
