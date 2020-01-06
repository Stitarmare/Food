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
      body: SingleChildScrollView(child: _getMainView()),
    );
  }
}

Widget _getMainView() {
  return Container(
      child: Stack(
    children: <Widget>[
      Image.asset('assets/BlurImage/Group1612.png'),
      Positioned(
        child: Text(
          'My Profile',
          style: TextStyle(color: Colors.white),
        ),
        left: 12,
        top: 10,
      ),
      Positioned(
        child: ClipOval(
          child: Image.asset('assets/ProfileImage/MaskGroup15.png'),
        ),
        left: 20,
      ),
    ],
  ));
}
