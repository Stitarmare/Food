import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDi.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';

class StatusTrackView extends StatefulWidget {
  int orderID;
  StatusTrackView({this.orderID});
  @override
  State<StatefulWidget> createState() {
    return _StatusTrackingViewState();
  }
}

class _StatusTrackingViewState extends State<StatusTrackView>
    implements StatusTrackViewModelView {
  StatusTrackViewPresenter statusTrackViewPresenter;
  Duration _duration = Duration(seconds: 30);
  Timer _timer;
  StatusData statusInfo;
  @override
  void initState() {
    super.initState();
    statusTrackViewPresenter = StatusTrackViewPresenter(this);
    statusTrackViewPresenter.getOrderStatus(widget.orderID, context);

    _timer = Timer.periodic(_duration, (Timer t) {
      statusTrackViewPresenter.getOrderStatus(widget.orderID, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: _getmainview(),
        bottomNavigationBar:
            (statusInfo != null) ? billPaymentButton() : Text(""),
      ),
    );
  }

  Widget billPaymentButton() {
    return (statusInfo.status == "completed")
        ? Container(
            //margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            width: MediaQuery.of(context).size.width,
            height: 54,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Text(
                'BILL PAYMENT',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              color: getColorByHex(Globle().colorscode),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentTipAndPayDi(
                              orderID: widget.orderID,
                            )));
              },
            ),
          )
        : Text("");
  }

  Widget _getmainview() {
    return LimitedBox(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 5.0,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "That's Amore",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w600,
                          color: greytheme700),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    _getstatus(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ), // Restauarants Name
            Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.black,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Text(
                  'Add more Items',
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
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  //Navigator.popUntil(context, ModalRoute.withName('/RestaurantView'));

                  //Navigator.pushNamed(context, '/OrderConfirmation2View');
                },
              ),
            ),

            // SizedBox(
            //   height: 50,
            // ),
            // _billPayment(),
          ],
        ),
      ),
    );
  }

  Widget _getstatus() {
    return LimitedBox(
      child: Container(
        decoration: BoxDecoration(
            //color: getColorByHex(Globle().colorscode),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: <Widget>[
              AutoSizeText(
                  "Order for table number 8 is confirmed. Please wait while kitchen updates time for prepration. You will be notified about the status.",
                  //maxFontSize: 12,
                  //maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w500,
                      color: greytheme700)),
              SizedBox(
                height: 15,
              ),
              AutoSizeText((" Status: ${getStatus()}"),
                  //maxFontSize: 12,
                  //maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w500,
                      color: greytheme700)),
            ],
          ),
        ),
      ),
    );
  }

  String getStatus() {
    if (statusInfo != null) {
      if (statusInfo.status != null) {
        return statusInfo.status;
      }
    }
    return "You will be notified about the status.";
  }

  @override
  void getOrderStatusfailed() {
    // TODO: implement getOrderStatusfailed
  }

  @override
  void getOrderStatussuccess(StatusData statusData) {
    if (statusData != null) {
      setState(() {
        statusInfo = statusData;
      });
    }
    // TODO: implement getOrderStatussuccess
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }
}

String name;

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

  //TODO: dispose
}
