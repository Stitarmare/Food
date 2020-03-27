import 'package:flutter/material.dart';

class OrderItemsDialogBox extends StatefulWidget {
  String name;
  String count;
  List<OrderDetailListview> orderitems = [];
  OrderItemsDialogBox({this.orderitems, this.count, this.name});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderItemsDialogBoxState();
  }
}

class _OrderItemsDialogBoxState extends State<OrderItemsDialogBox> {
  List<OrderDetailListview> orderitems = [OrderDetailListview()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        children: <Widget>[
          Container(
            height: 350,
            width: 284,
            child: Column(
              children: <Widget>[],
            ),
          )
        ]);
  }
}

class OrderDetailListview {
  String name;
  String count;
  OrderDetailListview({this.name, this.count});
}
