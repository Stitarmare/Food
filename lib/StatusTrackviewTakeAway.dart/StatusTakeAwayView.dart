import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/BottomTabbar/BottomTabbarRestaurant.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineViewContractor.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineviewPresenter.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDi.dart';
import 'package:foodzi/RestaurantPage/RestaurantView.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/StatusTrackviewTakeAway.dart/StatTrackTakeContractor.dart';
import 'package:foodzi/StatusTrackviewTakeAway.dart/StatTrackTakePresenter.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/RadioDialogAddPeople.dart';

class StatusTakeAwayView extends StatefulWidget {
  int tableId;
  int orderID;
  int flag;
  int rest_id;
  String restname;
  //   String lat;
  // String long;
  String title;
  StatusTakeAwayView(
      {this.orderID,
      this.flag,
      this.rest_id,
      this.title,
      this.restname,
      this.tableId});
  @override
  State<StatefulWidget> createState() {
    return _StatusTakeAwayViewState();
  }
}

class _StatusTakeAwayViewState extends State<StatusTakeAwayView>
    implements StatTrackTakeModelView {
  List<Data> peopleList = [];

  StatTrackTakePresenter statusTrackViewPresenter;
  Duration _duration = Duration(seconds: 30);
  Timer _timer;
  StatusData statusInfo;
  ConfirmationDineviewPresenter confirmationDineviewPresenter;
  List<CheckBoxOptions> _checkBoxOptions = [];

  @override
  void initState() {
    super.initState();
    statusTrackViewPresenter = StatTrackTakePresenter(this);
    statusTrackViewPresenter.getOrderStatus(widget.orderID, context);

    _timer = Timer.periodic(_duration, (Timer t) {
      statusTrackViewPresenter.getOrderStatus(widget.orderID, context);
    });

    print("table from statustrackView---->");
    print(widget.tableId);
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
          centerTitle: true,
          title: Text("Order Status"),
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          // automaticallyImplyLeading:true,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);

              // if (widget.flag == 1) {
              //   Navigator.popUntil(
              //       context, (Route<dynamic> route) => route.isFirst);
              // }
              // if (widget.flag == 2) {
              //   // Navigator.pushNamedAndRemoveUntil(context, '/RestaurantView', (_) => false);
              //   Navigator.pop(context);
              // }
              // if (widget.flag == 3) {
              //   // Navigator.pushNamedAndRemoveUntil(context, '/RestaurantView', (_) => false);
              //   Navigator.pop(context);
              // }
            },
          ),
        ),
        body: _getmainview(),
        // bottomNavigationBar:
        //     (statusInfo != null) ? billPaymentButton() : Text(""),
      ),
    );
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
                      "${widget.title}",
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
            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: FlatButton(
            //     child: Text(
            //       'Add more Items',
            //       style: TextStyle(
            //           fontSize: 16,
            //           fontFamily: 'gotham',
            //           decoration: TextDecoration.underline,
            //           decorationColor: (Globle().colorscode != null)
            //               ? getColorByHex(Globle().colorscode)
            //               : orangetheme,
            //           color: (Globle().colorscode != null)
            //               ? getColorByHex(Globle().colorscode)
            //               : orangetheme,
            //           fontWeight: FontWeight.w600),
            //     ),
            //     onPressed: () {
            //       Preference.setPersistData<int>(
            //           widget.orderID, PreferenceKeys.ORDER_ID);

            //       if (widget.flag == 1) {
            //         Navigator.pop(context);
            //         Navigator.pop(context);
            //         Navigator.pop(context);
            //         Navigator.pop(context);
            //       }
            //       if (widget.flag == 2) {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => RestaurantView(
            //                       rest_Id: widget.rest_id,
            //                       title: widget.title,
            //                     )));
            //       }
            //       if (widget.flag == 3) {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => RestaurantView(
            //                       rest_Id: widget.rest_id,
            //                       title: widget.title,
            //                     )));
            //       }
            //       //Navigator.popUntil(context, ModalRoute.withName('/RestaurantView'));

            //       //Navigator.pushNamed(context, '/OrderConfirmation2View');
            //     },
            //   ),
            // ),
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
                  "Please wait while kitchen updates time for prepration. You will be notified about the status.",
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
