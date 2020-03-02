import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';

class StatusTrackView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatusTrackingViewState();
  }
}

class _StatusTrackingViewState extends State<StatusTrackView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getmainview(),
    );
  }

  Widget _getmainview() {
    return LimitedBox(
      child: Container(
        child: Column(
          children: <Widget>[
            Text('data'), // Restauarants Name
            SizedBox(
              height: 50,
            ),
            _getstatus(),
            Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.black,
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                child: Text(
                  'Add More Items',
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'gotham',
                      decoration: TextDecoration.underline,
                      decorationColor: getColorByHex(Globle().colorscode),
                      color: getColorByHex(Globle().colorscode),
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  //Navigator.pushNamed(context, '/OrderConfirmation2View');
                },
              ),
            ),

            SizedBox(
              height: 50,
            ),
            _billPayment(),
          ],
        ),
      ),
    );
  }
}

String name;

Widget _getstatus() {
  return LimitedBox(
    child: Container(
      child: AutoSizeText(
        name,
        maxFontSize: 12,
        maxLines: 2,
        style: TextStyle(fontSize: 12),
      ),
    ),
  );
}

Widget _billPayment() {
  return Container(
      child: FlatButton(
    child: Text("Bill Payment",
        style: TextStyle(
            fontSize: 16,
            fontFamily: 'gotham',
            fontWeight: FontWeight.w600,
            color: greytheme700)),
    onPressed: () {},
  ));
}
