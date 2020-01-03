import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('My Profile'),
      //   backgroundColor: Colors.transparent,
      // ),
      body: SingleChildScrollView(
        child: Stack(
          //fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/HotelImages/Image12.png',
              width: MediaQuery.of(context).size.width,
              height: 180,
              fit: BoxFit.fitWidth,
            ),
            Center(
              child: ClipRect(
                // <-- clips to the 200x200 [Container] below
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 400, 0, 0),
                    alignment: Alignment.topCenter,
                    // width: 400.0,
                    // height: 400.0,
                    child: Text('Hello World'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _getMainView() {
  return Container(
      child: Column(
    children: <Widget>[
      CircleAvatar(
        child: Image.asset('assets/ProfileImage/MaskGroup15.png'),
      ),
    ],
  ));
}
