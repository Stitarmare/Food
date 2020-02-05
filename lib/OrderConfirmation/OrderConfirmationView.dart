import 'package:flutter/material.dart';
import 'package:foodzi/Utils/ConstantImages.dart';
import 'package:foodzi/theme/colors.dart';

class OrderConfirmationView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderConfirmationViewState();
  }
}

class _OrderConfirmationViewState extends State<OrderConfirmationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getmainview(),
    );
  }

  Widget _getmainview() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(15, 200, 0, 0)),
          Center(child: Text('data')),
          //_getmainviewTableno(),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 3,
          ),
        ],
      ),
    );
  }
}

Widget _getmainviewTableno() {
  return SliverToBoxAdapter(
    child: Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "Items",
                    //  widget.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: greytheme700),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              //endIndent: 10,
              //indent: 10,
            ),
            Row(
              children: <Widget>[
                // SizedBox(
                //   width: 26,
                // ),
                // Image.asset('assets/DineInImage/Group1504.png'),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Dine-in',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w600,
                      color: redtheme),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 20),
                Text(
                  'Add Table Number',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                      fontSize: 14,
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w600,
                      color: greytheme100),
                )
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    ),
  );
}
