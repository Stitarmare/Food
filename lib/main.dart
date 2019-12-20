import 'package:flutter/material.dart';
import './Utils/String.dart';

import './Login/LoginView.dart';
import './LandingPage/LandingView.dart';

import './RegistrationPage/RegisterView.dart';

var routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => LoginView(),
  '/LoginView': (BuildContext context) => LoginView(),
  '/Landingview': (BuildContext context) => Landingview(),
  '/Registerview': (BuildContext context) => Registerview()
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
