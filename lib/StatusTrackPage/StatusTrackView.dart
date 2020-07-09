import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineViewContractor.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineviewPresenter.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';
//import 'package:foodzi/Models/payment_Checkout_model.dart';
import 'package:foodzi/MyOrders/MyOrderContractor.dart';
import 'package:foodzi/MyOrders/MyOrdersPresenter.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDi.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDiPresenter.dart';
import 'package:foodzi/RestaurantPage/RestaurantView.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/RadioDialogAddPeople.dart';
import 'package:progress_dialog/progress_dialog.dart';

class StatusTrackView extends StatefulWidget {
  int tableId;
  int orderID;
  int flag;
  int restId;
  String restname;
  String tableName;
  String title;
  String imgUrl;
  StatusTrackView(
      {this.orderID,
      this.flag,
      this.restId,
      this.title,
      this.restname,
      this.tableId,
      this.tableName,
      this.imgUrl});
  @override
  State<StatefulWidget> createState() {
    return _StatusTrackingViewState();
  }
}

class _StatusTrackingViewState extends State<StatusTrackView>
    implements
        StatusTrackViewModelView,
        ConfirmationDineViewModelView,
        PaymentTipandPayDiModelView {
  List<PeopleData> peopleList = [];
  final GlobalKey<_StatusTrackingViewState> _keyLoader =
      GlobalKey<_StatusTrackingViewState>();
  OrderDetailData _orderDetailList;
  OrderDetailsModel _detailsModel;
  StatusTrackViewPresenter statusTrackViewPresenter;
  PaymentTipandPayDiPresenter _paymentTipandPayDiPresenter;
  Duration _duration = Duration(seconds: 30);
  Timer _timer;
  StatusData statusInfo;
  bool isStart = false;
  ConfirmationDineviewPresenter confirmationDineviewPresenter;
  ProgressDialog progressDialog;

  @override
  void initState() {
    super.initState();
    _paymentTipandPayDiPresenter = PaymentTipandPayDiPresenter(this);
    statusTrackViewPresenter = StatusTrackViewPresenter(this);

    confirmationDineviewPresenter = ConfirmationDineviewPresenter(this);

    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: STR_PLEASE_WAIT);
    callApi();
    print(widget.tableId);

    print(widget.tableName);
  }

  callApi() async {
    isStart = true;
    // DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
    //await progressDialog.show();
    statusTrackViewPresenter.getOrderStatus(widget.orderID, context);
    _timer = Timer.periodic(_duration, (Timer t) {
      isStart = false;
      statusTrackViewPresenter.getOrderStatus(widget.orderID, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    //progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _timer.cancel();
                    // progressDialog.show();
                    callApi();
                  },
                  child: Icon(Icons.refresh),
                ),
                SizedBox(
                  width: 60,
                )
              ],
            )
          ],
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
              fontFamily: Constants.getFontType(),
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
                          fontFamily: Constants.getFontType(),
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
            Row(
              children: <Widget>[
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
                        //print(widget.tableId);
                        // DialogsIndicator.showLoadingDialog(
                        //     context, _keyLoader, "");
                        //progressDialog.show();
                        // _myOrdersPresenter.getOrderDetails(
                        //   STR_SMALL_DINEIN, context);
                        _paymentTipandPayDiPresenter.getOrderDetails(
                            widget.orderID, context);

                        // showDialog(
                        //     context: context,
                        //     child:
                        //     RadioDialogAddPeople(
                        //         widget.tableId, widget.rest_id, widget.orderID));

                        // SizedBox(
                        //   height: 50,
                        // ),
                        // _billPayment(),
                      }),
                ),
                Flexible(child: Container()),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    child: Text(
                      STR_ADD_MORE_ITEM,
                      style: TextStyle(
                          fontSize: FONTSIZE_16,
                          fontFamily: Constants.getFontType(),
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
                                      imageUrl: widget.imgUrl,
                                    )));
                      }
                      if (widget.flag == 3) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestaurantView(
                                      restId: widget.restId,
                                      title: widget.title,
                                      imageUrl: widget.imgUrl,
                                    )));
                      }
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                  child: Text(
                    STR_ADD_MORE_PEOPLE,
                    style: TextStyle(
                        fontSize: FONTSIZE_16,
                        fontFamily: Constants.getFontType(),
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
                    //progressDialog.show();
                    //DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
                    //confirmationDineviewPresenter.getPeopleList(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getstatus() {
    return LimitedBox(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(children: <Widget>[
                AutoSizeText(
                    STR_ORDER_FOR + "${widget.tableName}" + STR_ORDER_CONFIRM,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: FONTSIZE_18,
                        fontFamily: Constants.getFontType(),
                        fontWeight: FontWeight.w500,
                        color: greytheme700)),
                SizedBox(
                  height: 15,
                ),
                AutoSizeText((STR_STATUS + "${getStatus()}"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: FONTSIZE_18,
                        fontFamily: Constants.getFontType(),
                        fontWeight: FontWeight.w500,
                        color: greytheme700)),
              ]))),
    );
  }

  itemListDialog() {
    return showDialog(
      context: context,
      child: Container(
        //decoration:
        // BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4))),
        width: MediaQuery.of(context).size.height * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text("LIST OF ITEMS"),
          content: itemList(),
          actions: <Widget>[
            Divider(
              endIndent: 15,
              indent: 15,
              color: Colors.black,
            ),
            FlatButton(
              child: Text(STR_OK),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget itemList() {
    return (_orderDetailList.list.isEmpty)
        ? Container(
            child: Center(
              child: Text("No items found."),
            ),
          )
        : Container(
            //margin: EdgeInsets.only(top: 15),
            width: MediaQuery.of(context).size.height * 0.7,
            height: MediaQuery.of(context).size.height * 0.35,
            child: ListView.builder(
              itemCount: getlength(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: (_orderDetailList
                                          .list[index].items.menuType ==
                                      'veg')
                                  ? Image.asset(
                                      IMAGE_VEG_ICON_PATH,
                                      height: 20,
                                      width: 20,
                                    )
                                  : Image.asset(
                                      IMAGE_VEG_ICON_PATH,
                                      height: 20,
                                      width: 20,
                                      color: redtheme,
                                    ),
                            ),
                            SizedBox(width: 1),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(
                                    _orderDetailList
                                                .list[index].items.itemName !=
                                            null
                                        ? StringUtils.capitalize(
                                            _orderDetailList
                                                .list[index].items.itemName)
                                        : STR_ITEM_NAME,
                                    style: TextStyle(
                                        fontSize: FONTSIZE_18,
                                        color: greytheme700),
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 150,
                                  child: AutoSizeText(
                                    _orderDetailList.list[index].items
                                                .itemDescription !=
                                            null
                                        ? StringUtils.capitalize(
                                            _orderDetailList.list[index].items
                                                .itemDescription)
                                        : STR_ITEM_DESC,
                                    style: TextStyle(
                                      color: greytheme1000,
                                      fontSize: FONTSIZE_14,
                                    ),
                                    maxFontSize: FONTSIZE_12,
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                  width: 150,
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Quantity: ",
                                        style: TextStyle(
                                          color: greytheme1000,
                                          fontSize: FONTSIZE_11,
                                        ),
                                      ),
                                      AutoSizeText(
                                        _orderDetailList.list[index].quantity
                                                .toString() ??
                                            "",
                                        style: TextStyle(
                                          color: greytheme1000,
                                          fontSize: FONTSIZE_14,
                                        ),
                                        maxFontSize: FONTSIZE_12,
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Expanded(
                            //   child: SizedBox(
                            //       // width: 80,
                            //       ),
                            //   flex: 1,
                            // ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, left: 5),
                              child: AutoSizeText(
                                "${_detailsModel.currencySymbol ?? ""} ${_orderDetailList.list[index].totalAmount}",
                                style: TextStyle(
                                    color: greytheme700,
                                    fontSize: FONTSIZE_16,
                                    fontWeight: FontWeight.w600),
                                maxFontSize: FONTSIZE_12,
                                maxLines: 2,
                              ),
                            )
                          ]),
                      SizedBox(height: 6),
                      Divider(
                        height: 2,
                        thickness: 2,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
            // ),
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

  getlength() {
    if (_orderDetailList != null) {
      if (_orderDetailList.list != null) {
        return _orderDetailList.list.length;
      }
    }
    return 0;
  }

  @override
  void getOrderStatusfailed() async {
    if (isStart) {
      await progressDialog.hide();
      // if (_keyLoader.currentContext != null) {
      //   Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
      // }
    }
  }

  @override
  void getOrderStatussuccess(StatusData statusData) async {
    if (isStart) {
      await progressDialog.hide();
      // if (_keyLoader.currentContext != null) {
      //   Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
      // }
    }
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
  void getPeopleListonFailed() {
    //progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void getPeopleListonSuccess(List<PeopleData> data) {
    // progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    if (data.length == 0) {
      Constants.showAlert("", "No record found!", context);
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
    showDialog(
        context: context,
        child: RadioDialogAddPeople(
            widget.tableId, widget.restId, widget.orderID));
  }

  @override
  void getInvitedPeopleFailed() {}

  @override
  void getInvitedPeopleSuccess(List<InvitePeopleList> list) {}

  @override
  void getOrderDetailsFailed() {
    //progressDialog.hide();
    // Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    // TODO: implement getOrderDetailsFailed
  }

  @override
  void getOrderDetailsSuccess(
      OrderDetailData orderData, OrderDetailsModel model) {
    //progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    if (orderData.list.length == 0) {
      return;
    }

    setState(() {
      if (orderData.list.length != null) {
        _orderDetailList = orderData;
        _detailsModel = model;
      }
    });

    itemListDialog();
    // TODO: implement getOrderDetailsSuccess
  }

  @override
  void paymentCheckoutFailed() {
    // TODO: implement paymentCheckoutFailed
  }

  @override
  void paymentCheckoutSuccess(PaymentCheckoutModel paymentCheckoutModel) {
    // TODO: implement paymentCheckoutSuccess
  }

  @override
  void cancelledPaymentFailed() {
    // TODO: implement cancelledPaymentFailed
  }

  @override
  void cancelledPaymentSuccess() {
    // TODO: implement cancelledPaymentSuccess
  }

  @override
  void onFailedQuantityIncrease() {
    // TODO: implement onFailedQuantityIncrease
  }

  @override
  void onSuccessQuantityIncrease() {
    // TODO: implement onSuccessQuantityIncrease
  }

  @override
  void inviteRequestFailed() {}

  @override
  void inviteRequestSuccess(String message) {
    // TODO: implement inviteRequestSuccess
  }
}
