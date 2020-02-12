import 'package:flutter/material.dart';
class MyCart extends StatefulWidget {
  MyCart({Key key}) : super(key: key);

  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
         child: Text('No Items in the Cart'),
      ),
    );
  }
}