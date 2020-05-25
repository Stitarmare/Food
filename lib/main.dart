import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/AddItemPageView.dart';
import 'package:foodzi/AddItemPageTA/AddItemPageTAView.dart';
import 'package:foodzi/CartDetailsPage/CartDetailsPage.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineView.dart';
import 'package:foodzi/EnterMobileNoPage/EnterMobileNoPage.dart';
import 'package:foodzi/MyOrderTakeAway/MyOrderTakeAway.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/MyprofileBottompage/MyprofileBottompage.dart';
import 'package:foodzi/NotificationBottomPage/NotificationBottomPage.dart';
import 'package:foodzi/OTPScreen/UpdateNoOtpScreen.dart';
import 'package:foodzi/PaymentMethod/PaymentMethod.dart';
import 'package:foodzi/RestaurantInfoPage/RestaurantInfoView.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantViewTA.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackView.dart';
import 'package:foodzi/SubCategory/CategoriesSection.dart';
import 'package:foodzi/TakeAwayPage/TakeAwayView.dart';
import 'package:foodzi/Utils/WebViewPage.dart';
import 'package:foodzi/Utils/locator.dart';
import 'package:foodzi/customNavigator/customNavigation.dart';
import 'package:foodzi/widgets/WebView.dart';
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
import 'package:foodzi/MyCart/MyCartView.dart';
import 'package:foodzi/OrderConfirmation2/OrderConfirmation2.dart';

var routes = <String, WidgetBuilder>{
  STR_SPLASH_SCREEN_PAGE_INITIAL: (BuildContext context) => SplashScreen(),
  STR_SPLASH_SCREEN_PAGE: (BuildContext context) => SplashScreen(),
  STR_LOGIN_PAGE: (BuildContext context) => LoginView(),
  STR_MAIN_WIDGET_PAGE: (BuildContext context) => MainWidget(),
  STR_REGISTRATION_PAGE: (BuildContext context) => Registerview(),
  STR_RESET_PWD_PAGE: (BuildContext context) => ResetPasswordview(),
  STR_CHANGE_PWD_PAGE: (BuildContext context) => ChangePasswordview(),
  STR_OTP_SCREEN_PAGE: (BuildContext context) => OTPScreen(),
  STR_OTP_SCREEN_UPATE: (BuildContext context) => UpdateNoOTPScreen(),
  STR_ENTER_OTP_PAGE: (BuildContext context) => EnterOTPScreen(),
  STR_DINE_IN_PAGE: (BuildContext context) => DineInView(),
  STR_TAKE_AWAY_PAGE: (BuildContext context) => TakeAwayView(),
  STR_PROFILE_PAGE: (BuildContext context) => ProfileScreen(),
  STR_EDIT_PROFILE_PAGE: (BuildContext context) => EditProfileview(),
  STR_RETAURANT_PAGE: (BuildContext context) => RestaurantView(),
  STR_RESTAURANT_TAKE_AWAY_PAGE: (BuildContext context) => RestaurantTAView(),
  STR_NOTIFICATION_PAGE: (BuildContext context) => NotificationView(),
  STR_MYORDER_PAGE: (BuildContext context) => MyOrders(),
  STR_MYORDER_TAKE_AWAY_PAGE: (BuildContext context) => MyOrderTakeAway(),
  STR_BOTTOM_PROFILE_PAGE: (BuildContext context) => BottomProfileScreen(),
  STR_BOTTOM_NOTIFICATION_PAGE: (BuildContext context) =>
      BottomNotificationView(),
  STR_RETAURANT_INFO_PAGE: (BuildContext context) => RestaurantInfoView(),
  STR_ADD_ITEM_PAGE: (BuildContext context) => AddItemPageView(),
  STR_ADD_ITEM_TAKE_AWAY_PAGE: (BuildContext context) => AddItemPageTAView(),
  STR_MY_CART_PAGE: (BuildContext context) => MyCartView(),
  STR_ORDER_CONFIRM_2_PAGE: (BuildContext context) => OrderConfirmation2View(),
  STR_CONFIRMATION_DINE_PAGE: (BuildContext context) => ConfirmationDineView(),
  STR_WEB_VIEW_PAGE: (BuildContext context) => WebViewPage(),
  STR_PAYMENT_PAGE: (BuildContext context) => PaymentMethod(),
  STR_STATUS_TRACK_PAGE: (BuildContext context) => StatusTrackView(),
  STR_WEB_VIEW_SCREEN_PAGE: (BuildContext context) => WebViewScreen(),
  STR_CART_DETAILS_PAGE: (BuildContext context) => CartDetailsPage(),
  STR_ENTER_MOBILE_PAGE: (BuildContext context) => EnterMobileNoPage(),
  STR_CATEGORY_SECTION : (BuildContext context) => CategoriesSection(),
};
void main() {
  setupLocator();
  runApp(MaterialApp(
    title: KEY_APP_NAME,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Color.fromRGBO(34, 180, 91, 1),
      accentColor: Color.fromRGBO(34, 180, 91, 1),
    ),
    routes: routes,
    navigatorKey: locator<NavigationService>().navigatorKey,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return null;
  }
}
