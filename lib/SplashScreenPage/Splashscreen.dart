import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/loginmodel.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'dart:async';

import 'package:foodzi/network/ApiBaseHelper.dart';
//import '../Utils/String.dart';

//import '../Utils/WebServiceHandler.dart';
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
    Timer(Duration(seconds: 2),
        //() => Navigator.pushReplacementNamed(context, '/LoginView'),

        () {
      Preference.getPrefValue<String>(PreferenceKeys.User_data).then((value) {
        if (value != null) {
          var jsonData = json.decode(value);
          var userData = LoginModel.fromJson(jsonData);

          if (userData.data.id != null && userData.token != null) {
            Globle().loginModel = userData;
            Globle().authKey = userData.token;
            Navigator.pushReplacementNamed(context, '/MainWidget');
          } else {
            Navigator.pushReplacementNamed(context, '/LoginView');
          }
        } else {
          Navigator.pushReplacementNamed(context, '/LoginView');
        }
      }).catchError(() {
        Navigator.pushReplacementNamed(context, '/LoginView');
      });
    });
  }

  setForIosPushNotification() {
    if(Platform.isIOS) {
     iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {

      });
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
  }

  fcmConfiguration() {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
            print("onMessage: $message");
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                        content: ListTile(
                        title: Text(message['notification']['title']),
                        subtitle: Text(message['notification']['body']),
                        ),
                        actions: <Widget>[
                        FlatButton(
                            child: Text('Ok'),
                            onPressed: () => Navigator.of(context).pop(),
                        ),
                    ],
                ),
            );
        },
        onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
            // TODO optional
        },
        onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
            // TODO optional
        },
    );
  }

  getFcmToken() async{
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
            //SizedBox(height: 30),
            Image.asset(
              'assets/SplashScreen/LauncherScreen.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
              // height: 500.0,
            ),
            // SizedBox(height: 100),
            // CircularProgressIndicator(),
            // SizedBox(height: 20),
            // Text(
            //   KEY_APP_SLOGAN,
            //   style: TextStyle(
            //     //color: Colors.white,
            //     fontSize: 18.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
