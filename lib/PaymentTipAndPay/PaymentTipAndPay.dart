import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/PayCheckOutNetBanking.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayPresenter.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDiPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/WebViewPage.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';

class PaymentTipAndPay extends StatefulWidget {
  String restName;
  int flag;
  int price;
  int restId;
  int userId;
  String orderType;
  int tableId;
  String tablename;
  List<int> items;
  int totalAmount;
  String latitude;
  String longitude;
  List<MenuCartList> itemdata;
  String currencySymbol;
  PaymentTipAndPay(
      {this.userId,
      this.price,
      this.items,
      this.restId,
      this.latitude,
      this.tablename,
      this.longitude,
      this.orderType,
      this.tableId,
      this.totalAmount,
      this.currencySymbol,
      this.itemdata,
      this.restName,
      this.flag});
  _PaymentTipAndPayState createState() => _PaymentTipAndPayState();
}

class _PaymentTipAndPayState extends State<PaymentTipAndPay>
    implements
        PaymentTipAndPayModelView,
        PaymentTipandPayDiModelView,
        PayBillCheckoutModelView,
        PayFinalBillModelView {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  ScrollController _controller = ScrollController();
  var sliderValue = 0;
  PaymentTipAndPayPresenter _paymentTipAndPayPresenter;
  PayBillCheckoutPresenter _billCheckoutPresenter;
  PaymentTipandPayDiPresenter _paymentTipandPayDiPresenter;
  PayFinalBillPresenter _finalBillPresenter;

  String currencySymb = STR_BLANK;
  OrderDetailsModel _model;

  OrderData myOrderData;
  OrderDetailData myOrderDataDetails;

  PaycheckoutNetbanking billModel;
  @override
  void initState() {
    print(widget.items);
    _paymentTipAndPayPresenter = PaymentTipAndPayPresenter(this);
    print(widget.itemdata.length);
    print(widget.currencySymbol);
    currencySymb = widget.currencySymbol;
    _billCheckoutPresenter = PayBillCheckoutPresenter(this);
    _paymentTipandPayDiPresenter = PaymentTipandPayDiPresenter(this);
    _finalBillPresenter = PayFinalBillPresenter(this);

    super.initState();
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
                  ),
                  GestureDetector(
                    onTap: () {
                      DialogsIndicator.showLoadingDialog(
                          context, _keyLoader, STR_BLANK);
                      _paymentTipAndPayPresenter.placeOrder(
                          widget.restId,
                          Globle().loginModel.data.id,
                          widget.orderType,
                          widget.tableId,
                          widget.items,
                          widget.totalAmount,
                          widget.latitude,
                          widget.longitude,
                          context);
                    },
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: getColorByHex(Globle().colorscode),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Center(
                        child: Text(
                          STR_PLACED_PAY_BILL,
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
                    (widget.orderType == STR_SMALL_DINEIN)
                        ? STR_DINEIN_TITLE
                        : STR_COLLECTION,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: FONTSIZE_20,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w600,
                        color: getColorByHex(Globle().colorscode)),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
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
        itemCount: widget.itemdata.length,
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
                        child:
                            (widget.itemdata[index].items.menuType == STR_VEG)
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
                              widget.itemdata[index].items.itemName ??
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
                              widget.itemdata[index].items.itemDescription ??
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
                          currencySymb +
                                  ' ${widget.itemdata[index].totalAmount}' ??
                              currencySymb + STR_SEVENTEEN,
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
    );
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
                  fontSize: 16,
                  color: greytheme700,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 26),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Slider(
                activeColor: getColorByHex(Globle().colorscode),
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
              currencySymb + ' $sliderValue',
              style: TextStyle(
                  fontSize: 16,
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
                  (widget.totalAmount) != null
                      ? currencySymb + " ${widget.totalAmount}"
                      : currencySymb + STR_ELEVEN,
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
                  currencySymb + ' ${sliderValue.toInt()}',
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
                  currencySymb + ' ${widget.totalAmount + sliderValue.toInt()}',
                  style: TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                ),
              ),
            ],
          )
        ],
      ),
    );
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
                      fontSize: FONTSIZE_18,
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
  void placeOrderfailed() {
    Preference.setPersistData(null, PreferenceKeys.restaurantID);
    Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void placeOrdersuccess(OrderData orderData) {
    setState(() {
      if (myOrderData == null) {
        myOrderData = orderData;
      }
    });
    Globle().takeAwayCartItemCount = 0;
    widget.items = [];
    widget.itemdata = [];
    Globle().orderNumber = orderData.orderNumber;
    DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
    _billCheckoutPresenter.payBillCheckOut(
        myOrderData.restId, (int.parse(myOrderData.totalAmount)), context);
  }

  @override
  void payBillCheckoutFailed() {}

  @override
  Future<void> payBillCheckoutSuccess(PaycheckoutNetbanking model) async {
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
  void getOrderDetailsFailed() {}

  @override
  void getOrderDetailsSuccess(
      OrderDetailData orderData, OrderDetailsModel model) {
    setState(() {
      if (myOrderDataDetails == null) {
        myOrderDataDetails = orderData;
        _model = model;
      }
    });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void paymentCheckoutFailed() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void paymentCheckoutSuccess(PaymentCheckoutModel paymentCheckoutModel) {
    if (paymentCheckoutModel.statusCode == 200) {
      DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
      _finalBillPresenter.payfinalOrderBill(
        Globle().loginModel.data.id,
        myOrderData.restId,
        myOrderData.id,
        STR_CARD,
        int.parse(myOrderData.totalAmount),
        int.parse(myOrderData.totalAmount) + sliderValue,
        paymentCheckoutModel.transactionId,
        context,
        sliderValue ?? 0,
      );
    } else {
      Constants.showAlert(STR_FOODZI_TITLE, STR_PAYMENT_FAILED, context);
    }
  }

  @override
  void payfinalBillFailed() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void payfinalBillSuccess() {
    Preference.setPersistData<int>(null, PreferenceKeys.orderId);
    Preference.removeForKey(PreferenceKeys.orderId);
    Globle().dinecartValue = 0;
    Preference.setPersistData<int>(null, PreferenceKeys.restaurantID);
    Preference.setPersistData<bool>(null, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData<int>(null, PreferenceKeys.dineCartItemCount);
    Preference.setPersistData<int>(null, PreferenceKeys.currentRestaurantId);
    Preference.setPersistData<int>(null, PreferenceKeys.currentOrderId);
    Preference.setPersistData<String>(null, PreferenceKeys.restaurantName);
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    showAlertSuccess(STR_PAYMENT_SUCCESS, STR_TRANSACTION_DONE, context);
  }
}
