import 'package:flutter/material.dart';

class Landingview extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LandingStateView();
  }
}

class _LandingStateView extends State<Landingview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('data'),
      ),
      body: Text("Welcome TO LANDING PAGE"),
    );
  }
}
