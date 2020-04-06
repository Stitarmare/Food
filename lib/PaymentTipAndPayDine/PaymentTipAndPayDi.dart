import 'dart:convert';
//import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';

import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/PayCheckOutNetBanking.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';

import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDiPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/WebViewPage.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/RadioDailog.dart';
import 'package:foodzi/widgets/RadioDialogAddPeople.dart';

class PaymentTipAndPayDi extends StatefulWidget {
  int orderID;
  int restid;
  int tableId;

  PaymentTipAndPayDi({this.orderID, this.restid, this.tableId});
  _PaymentTipAndPayDiState createState() => _PaymentTipAndPayDiState();
}

class _PaymentTipAndPayDiState extends State<PaymentTipAndPayDi>
    implements
        PaymentTipandPayDiModelView,
        PayFinalBillModelView,
        PayBillCheckoutModelView {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  ScrollController _controller = ScrollController();
  var sliderValue = 0;
  PaymentTipandPayDiPresenter _paymentTipandPayDiPresenter;
  PayFinalBillPresenter _finalBillPresenter;
  PayBillCheckoutPresenter _billCheckoutPresenter;
  int selectedRadioTile;
  OrderDetailData myOrderData;
  PaycheckoutNetbanking billModel;

  OrderDetailsModel _model;
  List<AddPeopleList> addedPeopleList = [];

  @override
  void initState() {
    _paymentTipandPayDiPresenter = PaymentTipandPayDiPresenter(this);
    _finalBillPresenter = PayFinalBillPresenter(this);
    _billCheckoutPresenter = PayBillCheckoutPresenter(this);
    // DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
    _paymentTipandPayDiPresenter.getOrderDetails(widget.orderID, context);
    selectedRadioTile = 1;
    print(widget.tableId);
    print(widget.orderID);
    _model = OrderDetailsModel();

    print("list data from status track view page----->");

    print(RadioDialogAddPeopleState.addPeopleList);
    if (RadioDialogAddPeopleState.addPeopleList != null) {
      addedPeopleList = RadioDialogAddPeopleState.addPeopleList;
    } else {
      addedPeopleList = RadioDialogAddPeopleState.addPeopleList;
    }

    super.initState();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
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
          brightness: Brightness.dark,
          title: Text(STR_PAYMENT),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[_getmainviewTableno(), _getOptions()],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 80,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 35,
                    child: FlatButton(
                      child: Text(
                        STR_SPLIT_BILL,
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
                        addedPeopleList != null
                            ? showDialog(
                                context: context,
                                child: new RadioDialog(
                                  amount:
                                      (double.parse(myOrderData.totalAmount) +
                                          sliderValue),
                                  tableId: widget.tableId,
                                  orderId: widget.orderID,
                                  elementList: myOrderData.list,
                                ))
                            : _showAlert(context,
                                STR_ADD_PEOPLE_FIRST_SPLIT_BILL, STR_BLANK, () {
                                Navigator.of(context).pop();
                              });
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      DialogsIndicator.showLoadingDialog(
                          context, _keyLoader, STR_BLANK);
                      _billCheckoutPresenter.payBillCheckOut(myOrderData.restId,
                          (int.parse(myOrderData.totalAmount)), context);
                    },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: ((Globle().colorscode) != null)
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Center(
                        child: Text(
                          STR_PAY_BILL,
                          style: TextStyle(
                              fontFamily: KEY_FONTFAMILY,
                              fontWeight: FontWeight.w600,
                              fontSize: FONTSIZE_16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
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
              SizedBox(
                height: 10,
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
                      fontFamily: KEY_FONTFAMILY,
                      fontWeight: FontWeight.w600,
                      color: ((Globle().colorscode) != null)
                          ? getColorByHex(Globle().colorscode)
                          : orangetheme,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text(
                    (getTableName() != null)
                        ? STR_SELECT_TBL + '${myOrderData.tableName}'
                        : STR_TABLE_1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        fontSize: FONTSIZE_14,
                        fontFamily: KEY_FONTFAMILY,
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

  getTableName() {
    if (myOrderData != null) {
      if (myOrderData.tableName != null) {
        return myOrderData.tableName;
      }
    }
    return;
  }

  Widget _getOptions() {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _getMenuList(),
          Divider(
            thickness: 2,
          ),
          _getTipSlider(),
          Divider(
            thickness: 2,
          ),
          _getBillDetails(),
        ],
      ),
    );
  }

  Widget _getMenuList() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height * 0.25,
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
                        padding: EdgeInsets.only(left: 20),
                        child: (myOrderData.list[index].items.menuType == 'veg')
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
                      SizedBox(width: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              myOrderData.list[index].items.itemName ??
                                  STR_ITEM_NAME,
                              style: TextStyle(
                                  fontSize: FONTSIZE_18, color: greytheme700),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 30,
                            width: 180,
                            child: AutoSizeText(
                              myOrderData.list[index].items.itemDescription ??
                                  STR_ITEM_DESC,
                              style: TextStyle(
                                color: greytheme1000,
                                fontSize: FONTSIZE_14,
                              ),
                              maxFontSize: FONTSIZE_12,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 80,
                        ),
                        flex: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20, top: 15),
                        child: Text(
                          (getTotalAmount(index) != null)
                              ? _model.currencySymbol != null
                                  ? '${_model.currencySymbol} ' +
                                      '${myOrderData.list[index].totalAmount}'
                                  : ""
                              : STR_SEVENTEEN_TITLE,
                          style: TextStyle(
                              color: greytheme700,
                              fontSize: FONTSIZE_16,
                              fontWeight: FontWeight.w600),
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

  getAmount() {
    if (myOrderData != null) {
      if (myOrderData.totalAmount != null) {
        return myOrderData.totalAmount;
      }
    }
    return;
  }

  getTotalAmount(int i) {
    if (myOrderData != null) {
      if (myOrderData.list != null) {
        if (myOrderData.list[i].totalAmount != null) {
          return myOrderData.list[i].totalAmount;
        }
      }
    }
    return;
  }

  getlength() {
    if (myOrderData != null) {
      if (myOrderData.list != null) {
        return myOrderData.list.length;
      }
    }
    return 0;
  }

  Widget _getTipSlider() {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              STR_TIP,
              style: TextStyle(
                  fontSize: FONTSIZE_16,
                  color: greytheme700,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Slider(
                activeColor: ((Globle().colorscode) != null)
                    ? getColorByHex(Globle().colorscode)
                    : orangetheme,
                inactiveColor: greytheme100,
                min: 0,
                max: 20,
                value: double.parse(sliderValue.toString()),
                onChanged: (newValue) {
                  setState(() {
                    sliderValue = newValue.round();
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: Text(
              '${_model.currencySymbol} ' + '${sliderValue.toInt()}',
              style: TextStyle(
                  fontSize: FONTSIZE_16,
                  color: greytheme700,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _getBillDetails() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              STR_BILL_DETAILS,
              style: TextStyle(fontSize: FONTSIZE_16, color: greytheme700),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  STR_SUBTOTAL,
                  style: TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 120,
                ),
                flex: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  getAmount() != null
                      ? _model.currencySymbol != null
                          ? '${_model.currencySymbol} ' +
                              "${myOrderData.totalAmount}"
                          : ""
                      : STR_ELEVEN_TITLE,
                  style: TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  STR_TIP,
                  style: TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 120,
                ),
                flex: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  _model.currencySymbol != null
                      ? '${_model.currencySymbol} ' + '${sliderValue.toInt()}'
                      : "",
                  style: TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  STR_TOTAL,
                  style: TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 120,
                ),
                flex: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  (getAmount() != null)
                      ? '${_model.currencySymbol} ' +
                          '${int.parse(myOrderData.totalAmount) + sliderValue.toInt()}'
                      : '${_model.currencySymbol}',
                  style: TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAlert(
      BuildContext context, String title, String message, Function onPressed) {
    showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(title),
                actions: <Widget>[
                  FlatButton(
                    child: Text(STR_OK),
                    onPressed: onPressed,
                  )
                ],
              ),
            ));
  }

  void showAlertSuccess(String title, String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: KEY_FONTFAMILY,
                      fontWeight: FontWeight.w600,
                      color: greytheme700),
                ),
                content:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Image.asset(
                    SUCCESS_IMAGE_PATH,
                    width: 75,
                    height: 75,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: FONTSIZE_15,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w500,
                        color: greytheme700),
                  )
                ]),
                actions: <Widget>[
                  Divider(
                    endIndent: 15,
                    indent: 15,
                    color: Colors.black,
                  ),
                  FlatButton(
                    child: Text(STR_OK,
                        style: TextStyle(
                            fontSize: FONTSIZE_16,
                            fontFamily: KEY_FONTFAMILY,
                            fontWeight: FontWeight.w600,
                            color: greytheme700)),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  )
                ],
              ),
            ));
  }

  @override
  void getOrderDetailsFailed() {}

  @override
  void getOrderDetailsSuccess(
      OrderDetailData orderData, OrderDetailsModel model) {
    setState(() {
      if (myOrderData == null) {
        myOrderData = orderData;
        _model = model;
      }
    });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void payfinalBillFailed() {}

  @override
  void payfinalBillSuccess() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    Preference.setPersistData<int>(null, PreferenceKeys.orderId);
    Preference.removeForKey(PreferenceKeys.orderId);
    Preference.setPersistData<int>(null, PreferenceKeys.restaurantID);
    Preference.setPersistData<bool>(null, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData<int>(null, PreferenceKeys.dineCartItemCount);
    Preference.setPersistData<int>(null, PreferenceKeys.currentRestaurantId);
    Preference.setPersistData<int>(null, PreferenceKeys.currentOrderId);
    Preference.setPersistData<String>(null, PreferenceKeys.restaurantName);
    setState(() {
      if (RadioDialogAddPeopleState.addPeopleList != null) {
        RadioDialogAddPeopleState.addPeopleList.clear();
        RadioDialogAddPeopleState.addPeopleList = null;
      }
    });
    showAlertSuccess(STR_PAYMENT_SUCCESS, STR_TRANSACTION_DONE, context);
  }

  @override
  void payBillCheckoutFailed() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void payBillCheckoutSuccess(PaycheckoutNetbanking model) async {
    if (billModel == null) {
      billModel = model;
    }
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    var data = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewScreen(
                  url: billModel.url,
                )));
    if (data != null && data[STR_CHECKOUT_CODE] != null) {
      var codec = latin1.fuse(base64);
      _paymentTipandPayDiPresenter.getCheckoutDetails(
          codec.encode(data[STR_CHECKOUT_CODE]), context);
    } else {
      Constants.showAlert(STR_FOODZI_TITLE, STR_PAYMENT_CANCELLED, context);
    }
  }

  @override
  void paymentCheckoutFailed() {}

  @override
  void paymentCheckoutSuccess(PaymentCheckoutModel paymentCheckoutModel) {
    if (paymentCheckoutModel.statusCode == 200) {
      DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
      _finalBillPresenter.payfinalOrderBill(
          Globle().loginModel.data.id,
          myOrderData.restId,
          myOrderData.id,
          STR_CARD,
          int.parse(myOrderData.totalAmount),
          int.parse(myOrderData.totalAmount) + sliderValue.toInt(),
          paymentCheckoutModel.transactionId,
          context,
          sliderValue);
    } else {
      Constants.showAlert(STR_FOODZI_TITLE, STR_PAYMENT_FAILED, context);
    }
  }
}
