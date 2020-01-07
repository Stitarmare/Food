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

var routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => DineInView(),
  '/SplashScreen': (BuildContext context) => SplashScreen(),
  '/LoginView': (BuildContext context) => LoginView(),
  '/MainWidget': (BuildContext context) => MainWidget(),
  '/Registerview': (BuildContext context) => Registerview(),
  '/ResetPasswordview': (BuildContext context) => ResetPasswordview(),
  '/OTPScreen': (BuildContext context) => OTPScreen(),
  '/EnterOTPScreen': (BuildContext context) => EnterOTPScreen(),
  '/DineInView': (BuildContext context) => DineInView(),
  '/ProfileScreen': (BuildContext context) => ProfileScreen(),
  '/EditProfileview': (BuildContext context) => EditProfileview()
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
