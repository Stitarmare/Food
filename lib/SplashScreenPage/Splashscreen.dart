import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Notifications/NotificationView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  String strWebViewUrl = "";
  @override
  void initState() {
    super.initState();
    setForIosPushNotification();
    fcmConfiguration();
    getFcmToken();
    strWebViewUrl = BaseUrl.getBaseUrl() + STR_URL_TERMS_CONDITION_TITLE;
    Timer(Duration(seconds: 2), () {
      Preference.getPrefValue<String>(PreferenceKeys.User_data).then((value) {
        if (value != null) {
          var jsonData = json.decode(value);
          var userData = LoginModel.fromJson(jsonData);

          if (userData.data.id != null && userData.token != null) {
            Globle().loginModel = userData;
            Globle().authKey = userData.token;
            Navigator.pushReplacementNamed(context, STR_MAIN_WIDGET_PAGE);
          } else {
            Navigator.pushReplacementNamed(context, STR_LOGIN_PAGE);
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) =>
            //             // WebViewPage(
            //             //       title: STR_TERMS_CONDITION,
            //             //       strURL: strWebViewUrl,
            //             //       flag: 2,
            //             //     ),
            //             ),
            //     ModalRoute.withName(STR_WEB_VIEW_PAGE));
          }
        } else {
          Navigator.pushReplacementNamed(context, STR_LOGIN_PAGE);
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) =>
          //             //  WebViewPage(
          //             //       title: STR_TERMS_CONDITION,
          //             //       strURL: strWebViewUrl,
          //             //       flag: 2,
          //             //     ),
          //             ),
          //     ModalRoute.withName(STR_WEB_VIEW_PAGE));
        }
      }).catchError(() {
        Navigator.pushReplacementNamed(context, STR_LOGIN_PAGE);
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             // WebViewPage(
        //             //       title: STR_TERMS_CONDITION,
        //             //       strURL: strWebViewUrl,
        //             //       flag: 2,
        //             //     ),
        //             ),
        //     ModalRoute.withName(STR_WEB_VIEW_PAGE));
      });
    });

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {}

  setForIosPushNotification() {
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {});
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
  }

  Future _showNotificationWithDefaultSound(String title, String desc) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'FoodZiCustomer', 'FoodZi', 'Notification FoodZi',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      desc,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  fcmConfiguration() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print(message);
        //         var fcmModel = FcmModel.fromJson(message);

        Globle().streamController.add(1.0);
        //  final NavigationService _navigationService = locator<NavigationService>();
        //     _navigationService.navigateTo(STR_MAIN_WIDGET_PAGE);

        Globle().notificationFLag = true;
        if (message['notification'] != null) {
          String title = message['notification']['title'];
          String desc = message['notification']['body'];
          _showNotificationWithDefaultSound(title, desc);
        }

        // Navigator.pushNamed(Globle().context, STR_NOTIFICATION_PAGE);
        // Navigator.pushReplacementNamed(context, STR_NOTIFICATION_PAGE);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print(message);

        Globle().notificationFLag = true;
        if (Globle().context != null) {
          // Navigator.pushNamed(Globle().context, STR_NOTIFICATION_PAGE);
          // Navigator.pushReplacementNamed(context, STR_NOTIFICATION_PAGE,arguments:{"flage":1} );
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => NotificationView(
                        flag: 1,
                      )));
        }

        //var fcmModel = FcmModel.fromJson(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print(message);
        //var fcmModel = FcmModel.fromJson(message);
      },
    );
  }

  getFcmToken() async {
    String fcmToken = await _fcm.getToken();
    Globle().fcmToken = fcmToken;
    print(fcmToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset(
              SPLASH_SCREEN_IAMGE_PATH,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
