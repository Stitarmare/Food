import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          title: Text("My Orders"),),
          body: Center(child: Text("No Orders yet."),),
      ),
    );
  }
}