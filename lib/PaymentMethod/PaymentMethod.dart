import 'package:flutter/material.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/theme/colors.dart';

class PaymentMethod extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaymentmethodState();
}

class _PaymentmethodState extends State<PaymentMethod> {
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
        children: <Widget>[_getmainviewTableno()],
      )),
    );
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
                      STR_WIMPY_TITLE,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: FONTSIZE_20,
                          fontFamily: Constants.getFontType(),
                          fontWeight: FontWeight.w600,
                          color: greytheme700),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    STR_DINEIN_TITLE,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: FONTSIZE_20,
                        fontFamily: Constants.getFontType(),
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
                    STR_ADD_TABLE,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        fontSize: FONTSIZE_14,
                        fontFamily: Constants.getFontType(),
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
}
