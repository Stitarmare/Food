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

var routes = <String, WidgetBuilder>{
<<<<<<< HEAD
  '/': (BuildContext context) => Landingview(),
=======
<<<<<<< HEAD
  '/': (BuildContext context) => ProfileScreen(),
=======
<<<<<<< HEAD
  '/': (BuildContext context) => Landingview(),
=======
  '/': (BuildContext context) => DineInView(),
>>>>>>> 884e4bcbc1a4476242676f83bd0dc4e723c4c139
>>>>>>> 052567dffd5f160f7f339fa6008c3d0bb9613a1e
>>>>>>> bba64f67149a7794d8e9f43ef74d90f2ae7bc9c6
  '/SplashScreen': (BuildContext context) => SplashScreen(),
  '/LoginView': (BuildContext context) => LoginView(),
  '/MainWidget': (BuildContext context) => MainWidget(),
  '/Registerview': (BuildContext context) => Registerview(),
  '/ResetPasswordview': (BuildContext context) => ResetPasswordview(),
  '/OTPScreen': (BuildContext context) => OTPScreen(),
  '/EnterOTPScreen': (BuildContext context) => EnterOTPScreen(),
  '/DineInView': (BuildContext context) => DineInView(),
  '/ProfileScreen': (BuildContext context) => ProfileScreen(),
  '/EditProfileview': (BuildContext context) => EditProfileview(),
  '/RestaurantView': (BuildContext context) => RestaurantView(),
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
