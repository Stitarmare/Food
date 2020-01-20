import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './Utils/String.dart';

import './Login/LoginView.dart';
import './LandingPage/LandingView.dart';

import './RegistrationPage/RegisterView.dart';
import './ResetPassword/ResetPassView.dart';
import './SplashScreenPage/Splashscreen.dart';

import './Otp/OtpView.dart';
import './EnterOTP/EnterOtp.dart';
import './DineInPage/DineInView.dart';

import './ProfilePage/ProfileScreen.dart';
import './EditProfile/EditProfileView.dart';
import './RestaurantPage/RestaurantView.dart';
import './Notifications/NotificationView.dart';
import 'ChangePassword/ChangePassView.dart';
//import './demofile.dart';

var routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => SplashScreen(),
  '/SplashScreen': (BuildContext context) => SplashScreen(),
  //'/MyHomePage': (BuildContext context) => MyHomePage(),
  '/LoginView': (BuildContext context) => LoginView(),
  '/MainWidget': (BuildContext context) => MainWidget(),
  '/Registerview': (BuildContext context) => Registerview(),
  '/ResetPasswordview': (BuildContext context) => ResetPasswordview(),
  '/ChangePasswordview': (BuildContext context) => ChangePasswordview(),
  '/OTPScreen': (BuildContext context) => OTPScreen(),
  '/EnterOTPScreen': (BuildContext context) => EnterOTPScreen(),
  '/DineInView': (BuildContext context) => DineInView(),
  '/ProfileScreen': (BuildContext context) => ProfileScreen(),
  '/EditProfileview': (BuildContext context) => EditProfileview(),
  '/RestaurantView': (BuildContext context) => RestaurantView(),
  '/NotificationView': (BuildContext context) => NotificationView(),
};

void main() => runApp(MaterialApp(
      title: KEY_APP_NAME,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(34, 180, 91, 1),
        accentColor: Color.fromRGBO(34, 180, 91, 1),
      ),
      routes: routes,
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
