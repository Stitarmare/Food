import 'package:flutter/material.dart';
import 'dart:async';
import '../Utils/String.dart';

//import '../Utils/WebServiceHandler.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () => Navigator.pushReplacementNamed(context, '/LoginView'),
      // () => WebServiceHandler.isUserAlreadyLogin() ? Navigator.pushReplacementNamed(context, '/HomePage') : Navigator.pushReplacementNamed(context, '/SignIn'),
    );
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
              'assets/SplashScreen/Group_1567@2x.jpg',
              // width: 900,
              fit: BoxFit.fill,
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
