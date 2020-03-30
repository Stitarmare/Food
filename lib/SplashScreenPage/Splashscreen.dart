import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseMessaging _fcm = FirebaseMessaging();
  StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();
    setForIosPushNotification();
    fcmConfiguration();
    getFcmToken();
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
          }
        } else {
          Navigator.pushReplacementNamed(context, STR_LOGIN_PAGE);
        }
      }).catchError(() {
        Navigator.pushReplacementNamed(context, STR_LOGIN_PAGE);
      });
    });
  }

  setForIosPushNotification() {
    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {});
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
  }

  fcmConfiguration() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message[STR_SMALL_NOTIFI][STR_SMALL_TITLE]),
              subtitle: Text(message[STR_SMALL_NOTIFI][STR_BODY]),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(STR_OK),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
    );
  }

  getFcmToken() async {
    String fcmToken = await _fcm.getToken();
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
