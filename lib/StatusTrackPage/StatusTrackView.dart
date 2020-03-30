import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineViewContractor.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineviewPresenter.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDi.dart';
import 'package:foodzi/RestaurantPage/RestaurantView.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/OrderItemsDialogBox.dart';
import 'package:foodzi/widgets/RadioDialogAddPeople.dart';

class StatusTrackView extends StatefulWidget {
  int tableId;
  int orderID;
  int flag;
  int restId;
  String restname;
  String tableName;
  String title;
  StatusTrackView(
      {this.orderID,
      this.flag,
      this.restId,
      this.title,
      this.restname,
      this.tableId,
      this.tableName});
  @override
  State<StatefulWidget> createState() {
    return _StatusTrackingViewState();
  }
}

class _StatusTrackingViewState extends State<StatusTrackView>
    implements StatusTrackViewModelView, ConfirmationDineViewModelView {
  List<Data> peopleList = [];

  StatusTrackViewPresenter statusTrackViewPresenter;
  Duration _duration = Duration(seconds: 30);
  Timer _timer;
  StatusData statusInfo;
  ConfirmationDineviewPresenter confirmationDineviewPresenter;

  @override
  void initState() {
    super.initState();
    statusTrackViewPresenter = StatusTrackViewPresenter(this);
    statusTrackViewPresenter.getOrderStatus(widget.orderID, context);
    confirmationDineviewPresenter = ConfirmationDineviewPresenter(this);
    confirmationDineviewPresenter.getPeopleList(context);

    _timer = Timer.periodic(_duration, (Timer t) {
      statusTrackViewPresenter.getOrderStatus(widget.orderID, context);
    });

    print(widget.tableId);

    print(widget.tableName);
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
              if (widget.flag == 1) {
                Navigator.popUntil(
                    context, (Route<dynamic> route) => route.isFirst);
              }
              if (widget.flag == 2) {
                Navigator.pop(context);
              }
              if (widget.flag == 3) {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: _getmainview(),
        bottomNavigationBar:
            (statusInfo != null) ? billPaymentButton() : Text(STR_BLANK),
      ),
    );
  }

  Widget billPaymentButton() {
    return Container(
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
          STR_BILL_PAYMENT,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: FONTSIZE_18,
              fontFamily: KEY_FONTFAMILY,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        color: ((Globle().colorscode) != null)
            ? getColorByHex(Globle().colorscode)
            : orangetheme,
        onPressed: () {
          _timer.cancel();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentTipAndPayDi(
                        orderID: widget.orderID,
                        tableId: widget.tableId,
                      )));
        },
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
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Text(
                  STR_ADD_MORE_ITEM,
                  style: TextStyle(
                      fontSize: FONTSIZE_16,
                      fontFamily: KEY_FONTFAMILY,
                      decoration: TextDecoration.underline,
                      decorationColor: (Globle().colorscode != null)
                          ? getColorByHex(Globle().colorscode)
                          : orangetheme,
                      color: (Globle().colorscode != null)
                          ? getColorByHex(Globle().colorscode)
                          : orangetheme,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () {
                  Preference.setPersistData<int>(
                      widget.orderID, PreferenceKeys.orderId);

                  if (widget.flag == 1) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                  if (widget.flag == 2) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantView(
                                  restId: widget.restId,
                                  title: widget.title,
                                )));
                  }
                  if (widget.flag == 3) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantView(
                                  restId: widget.restId,
                                  title: widget.title,
                                )));
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                  child: Text(
                    STR_ADD_MORE_PEOPLE,
                    style: TextStyle(
                        fontSize: FONTSIZE_16,
                        fontFamily: KEY_FONTFAMILY,
                        decoration: TextDecoration.underline,
                        decorationColor: ((Globle().colorscode) != null)
                            ? getColorByHex(Globle().colorscode)
                            : orangetheme,
                        color: ((Globle().colorscode) != null)
                            ? getColorByHex(Globle().colorscode)
                            : orangetheme,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    print(widget.tableId);
                    showDialog(
                        context: context,
                        child: RadioDialogAddPeople(
                            widget.tableId, widget.restId, widget.orderID));
                  }),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    child: Text(
                      'View Order Details',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'gotham',
                          decoration: TextDecoration.underline,
                          decorationColor: ((Globle().colorscode) != null)
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme,
                          color: ((Globle().colorscode) != null)
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      print(widget.tableId);
                      showDialog(
                          context: context, child: OrderItemsDialogBox());
                    })),
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
              AutoSizeText(
                  STR_ORDER_FOR + "${widget.tableName}" + STR_ORDER_CONFIRM,
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

  @override
  void addPeopleFailed() {}

  @override
  void addPeopleSuccess() {}

  @override
  void getPeopleListonFailed() {}

  @override
  void getPeopleListonSuccess(List<Data> data) {
    if (data.length == 0) {
      return;
    }
    setState(() {
      if (peopleList == null) {
        peopleList = data;
      } else {
        peopleList.addAll(data);
      }
    });
    print(peopleList.length);
    print(peopleList.elementAt(0).firstName);
  }

  @override
  void getInvitedPeopleFailed() {}

  @override
  void getInvitedPeopleSuccess(List<InvitePeopleList> list) {}
}

String name;
