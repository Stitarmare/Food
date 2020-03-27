import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineviewPresenter.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/StatusTrackviewTakeAway.dart/StatTrackTakeContractor.dart';
import 'package:foodzi/StatusTrackviewTakeAway.dart/StatTrackTakePresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/theme/colors.dart';

class StatusTakeAwayView extends StatefulWidget {
  int tableId;
  int orderID;
  int flag;
  int restId;
  String restname;
  String title;
  StatusTakeAwayView(
      {this.orderID,
      this.flag,
      this.restId,
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

  @override
  void initState() {
    super.initState();
    statusTrackViewPresenter = StatTrackTakePresenter(this);
    statusTrackViewPresenter.getOrderStatus(widget.orderID, context);

    _timer = Timer.periodic(_duration, (Timer t) {
      statusTrackViewPresenter.getOrderStatus(widget.orderID, context);
    });

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
          title: Text(STR_ORDER_STATUS),
          brightness: Brightness.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ),
        body: _getmainview(),
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
                          fontSize: FONTSIZE_20,
                          fontFamily: KEY_FONTFAMILY,
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
            ),
            Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getstatus() {
    return LimitedBox(
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            children: <Widget>[
              AutoSizeText(STR_PLEASE_WAIT_NOTIFI,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FONTSIZE_18,
                      fontFamily: KEY_FONTFAMILY,
                      fontWeight: FontWeight.w500,
                      color: greytheme700)),
              SizedBox(
                height: 15,
              ),
              AutoSizeText((STR_STATUS + "${getStatus()}"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: FONTSIZE_18,
                      fontFamily: KEY_FONTFAMILY,
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
    return STR_STATUS_NOTIFIED;
  }

  @override
  void getOrderStatusfailed() {}

  @override
  void getOrderStatussuccess(StatusData statusData) {
    if (statusData != null) {
      setState(() {
        statusInfo = statusData;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
