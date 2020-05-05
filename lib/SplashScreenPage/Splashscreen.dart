import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/fcm_model.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/locator.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'dart:async';

import 'package:foodzi/customNavigator/customNavigation.dart';

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
        print(message);
                var fcmModel = FcmModel.fromJson(message);
                
        Globle().streamController.add(fcmModel);
           final NavigationService _navigationService = locator<NavigationService>();
              _navigationService.navigateTo(STR_MAIN_WIDGET_PAGE);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print(message);
        var fcmModel = FcmModel.fromJson(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print(message);
        var fcmModel = FcmModel.fromJson(message);
      },
    );
  }

  getFcmToken() async {
    String fcmToken = await _fcm.getToken();
    Globle().fcmToken =  fcmToken;
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
