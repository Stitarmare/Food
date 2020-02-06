import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/AddItemPageView.dart';
import 'package:foodzi/AddItemPage2/AddItemPageSecond.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineView.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/MyprofileBottompage/MyprofileBottompage.dart';
import 'package:foodzi/NotificationBottomPage/NotificationBottomPage.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantViewTA.dart';
import 'package:foodzi/TakeAwayPage/TakeAwayView.dart';
import './Utils/String.dart';

import './Login/LoginView.dart';
import './LandingPage/LandingView.dart';

import './RegistrationPage/RegisterView.dart';
import './ResetPassword/ResetPassView.dart';
import './SplashScreenPage/Splashscreen.dart';

import './Otp/OtpView.dart';
import './EnterMobileNoOTP/EnterOtp.dart';
import './DineInPage/DineInView.dart';

import './ProfilePage/ProfileScreen.dart';
import './EditProfile/EditProfileView.dart';
import './RestaurantPage/RestaurantView.dart';
import './Notifications/NotificationView.dart';
import 'ChangePassword/ChangePassView.dart';

import './OrderConfirmation/OrderConfirmationView.dart';

var routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => SplashScreen(),
  '/SplashScreen': (BuildContext context) => SplashScreen(),
  '/LoginView': (BuildContext context) => LoginView(),
  '/MainWidget': (BuildContext context) => MainWidget(),
  '/Registerview': (BuildContext context) => Registerview(),
  '/ResetPasswordview': (BuildContext context) => ResetPasswordview(),
  '/ChangePasswordview': (BuildContext context) => ChangePasswordview(),
  '/OTPScreen': (BuildContext context) => OTPScreen(),
  '/EnterOTPScreen': (BuildContext context) => EnterOTPScreen(),
  '/DineInView': (BuildContext context) => DineInView(),
  '/TakeAwayView': (BuildContext context) => TakeAwayView(),
  '/ProfileScreen': (BuildContext context) => ProfileScreen(),
  '/EditProfileview': (BuildContext context) => EditProfileview(),
  '/RestaurantView': (BuildContext context) => RestaurantView(),
  '/RestaurantTAView': (BuildContext context) => RestaurantTAView(),
  '/NotificationView': (BuildContext context) => NotificationView(),
  '/MyOrders': (BuildContext context) => MyOrders(),
  '/BottomProfileScreen': (BuildContext context) => BottomProfileScreen(),
  '/BottomNotificationView': (BuildContext context) => BottomNotificationView(),
  '/RestaurantInfoView': (BuildContext context) => RestaurantInfoView(),
  '/AddItemPageView': (BuildContext context) => AddItemPageView(),
  '/AddItemPageSecond': (BuildContext context) => AddItemPageSecond(),
  '/OrderConfirmationView': (BuildContext context) => OrderConfirmationView(),
  '/ConfirmationDineView': (BuildContext context) => ConfirmationDineView()
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
