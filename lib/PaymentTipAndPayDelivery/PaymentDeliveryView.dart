import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetDeliveryChargeModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/PayCheckOutNetBanking.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayPresenter.dart';
import 'package:foodzi/PaymentTipAndPayDelivery/PaymentDeliveryContractor.dart';
import 'package:foodzi/PaymentTipAndPayDelivery/PaymentDeliveryPresenter.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDiPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/WebViewPage.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:geocoder/geocoder.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PaymentDeliveryView extends StatefulWidget {
  String restName;
  int flag;
  int price;
  int restId;
  int userId;
  String orderType;
  int tableId;
  String tablename;
  List<int> items;
  double totalAmount;
  String latitude;
  String longitude;
  List<MenuCartList> itemdata;
  String currencySymbol;
  String addressData;
  String address;
  String houseNo;
  String landmark;
  PaymentDeliveryView(
      {this.userId,
      this.price,
      this.items,
      this.restId,
      this.latitude,
      this.tablename,
      this.addressData,
      this.longitude,
      this.orderType,
      this.tableId,
      this.totalAmount,
      this.currencySymbol,
      this.itemdata,
      this.restName,
      this.flag,
      this.address,
      this.houseNo,
      this.landmark});
  _PaymentDeliveryViewState createState() => _PaymentDeliveryViewState();
}

class _PaymentDeliveryViewState extends State<PaymentDeliveryView>
    implements
        PaymentDeliveryModelView,
        PaymentTipandPayDiModelView,
        PayBillCheckoutModelView,
        PayFinalBillModelView {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  ScrollController _controller = ScrollController();
  var sliderValue = 0;
  PaymentDeliveryPresenter _paymentDeliveryPresenter;
  PayBillCheckoutPresenter _billCheckoutPresenter;
  PaymentTipandPayDiPresenter _paymentTipandPayDiPresenter;
  PayFinalBillPresenter _finalBillPresenter;
  PaymentCheckoutModel _paymentCheckoutModel;
  ProgressDialog progressDialog;
  String currencySymb = STR_BLANK;
  OrderDetailsModel _model;
  DeliveryData _deliveryData;
  int deliveryCharge = 0;
  OrderData myOrderData;
  OrderDetailData myOrderDataDetails;
  PaycheckoutNetbanking billModel;
  bool isIgnoreTouch = false;
  @override
  void initState() {
    print(widget.items);
    _paymentDeliveryPresenter = PaymentDeliveryPresenter(this);
    print(widget.itemdata.length);
    print(widget.currencySymbol);
    currencySymb = widget.currencySymbol;
    _billCheckoutPresenter = PayBillCheckoutPresenter(this);
    _paymentTipandPayDiPresenter = PaymentTipandPayDiPresenter(this);
    _finalBillPresenter = PayFinalBillPresenter(this);
    _paymentDeliveryPresenter.getDeliveryChargeDetails(
        widget.latitude, widget.longitude, widget.restId, context);
    print(widget.addressData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    return SafeArea(
      left: false,
      top: false,
      right: false,
      bottom: true,
      child: IgnorePointer(
        ignoring: isIgnoreTouch,
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
                      onTap: () async {
                        getVerifyAmount();
                        // DialogsIndicator.showLoadingDialog(
                        //     context, _keyLoader, STR_BLANK);
                        // await progressDialog.show();
                        // _billCheckoutPresenter.payBillCheckOut(
                        //     widget.restId,
                        //     widget.totalAmount.toString(),
                        //     sliderValue.toString(),
                        //     "ZAR",
                        //     context);
                        // _paymentDeliveryPresenter.placeOrder(
                        //     widget.restId,
                        //     Globle().loginModel.data.id,
                        //     widget.orderType,
                        //     widget.tableId,
                        //     widget.items,
                        //     widget.totalAmount,
                        //     widget.latitude,
                        //     widget.longitude,
                        //     context);
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
                            STR_PLACE_ORDER_PAY_BILL,
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
      ),
    );
  }

  getVerifyAmount() async {
    if ((widget.totalAmount + deliveryCharge) > 1.0) {
      setState(() {
        isIgnoreTouch = true;
      });
      await progressDialog.show();
      _billCheckoutPresenter.payBillCheckOut(
          widget.restId,
          widget.totalAmount.toString(),
          deliveryCharge.toString(),
          "ZAR",
          context);
    } else {
      _model.currencySymbol != null
          ? Constants.showAlert(
              "Amount",
              "Amount should be greater than ${_model.currencySymbol} 1.00",
              context)
          : Constants.showAlert(
              "Amount", "Amount should be greater than 1.00", context);
    }
  }

  Widget _getmainviewTableno() {
    return SliverToBoxAdapter(
        child: Column(
      children: <Widget>[
        Card(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    STR_DELIVERY_TITLE,
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
        Container(
          margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "House No : ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w600,
                        color: greytheme700),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.houseNo,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w500,
                        color: greytheme700),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                widget.address,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: KEY_FONTFAMILY,
                    fontWeight: FontWeight.w500,
                    color: greytheme700),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text(
                    "Landmark : ",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w600,
                        color: greytheme700),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.landmark,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w500,
                        color: greytheme700),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 0.1,
                height: 50,
                child: Card(
                  child: Center(
                    child: Text(
                      widget.restName,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: KEY_FONTFAMILY,
                          fontWeight: FontWeight.w600,
                          color: getColorByHex(Globle().colorscode)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
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
          //_getTipSlider(),
          // Divider(
          //   thickness: 2,
          // ),
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
                              widget.itemdata[index].items.itemName != null
                                  ? StringUtils.capitalize(
                                      widget.itemdata[index].items.itemName)
                                  : STR_ITEM_NAME,
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
                              widget.itemdata[index].items.itemDescription !=
                                      null
                                  ? StringUtils.capitalize(widget
                                      .itemdata[index].items.itemDescription)
                                  : STR_ITEM_DESC,
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
                      ? currencySymb + " ${getSubTotalAmount()}"
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
                  DELV_CHARGE,
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
                  currencySymb + ' ${deliveryCharge.toStringAsFixed(2)}',
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
                  currencySymb + ' ${getTotalAmount()}',
                  // ' ${widget.totalAmount + sliderValue.toInt() + 12}',
                  style: TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String getSubTotalAmount() {
    String str = (widget.totalAmount).toStringAsFixed(2);
    return str;
  }

  String getTotalAmount() {
    String str = (widget.totalAmount + deliveryCharge).toStringAsFixed(2);
    return str;
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
  Future<void> placeOrderfailed() async {
    Preference.setPersistData(null, PreferenceKeys.restaurantID);
    Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
    await progressDialog.hide();
    setState(() {
      isIgnoreTouch = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> placeOrdersuccess(OrderData orderData) async {
    setState(() {
      isIgnoreTouch = false;
    });

    if (orderData == null) {
      await progressDialog.hide();
      Globle().takeAwayCartItemCount = 0;
      return;
    }
    setState(() {
      if (myOrderData == null) {
        myOrderData = orderData;
        Globle().takeAwayCartItemCount = 0;
      }
    });
    widget.items = [];
    widget.itemdata = [];
    Globle().orderNumber = orderData.orderNumber;
    await progressDialog.show();
    _finalBillPresenter.payfinalOrderBill(
      Globle().loginModel.data.id,
      myOrderData.restId,
      myOrderData.id,
      STR_CARD,
      myOrderData.totalAmount,
      (double.parse(myOrderData.totalAmount) + deliveryCharge).toString(),
      _paymentCheckoutModel.transactionId,
      context,
      deliveryCharge.toString(),
    );
    //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
    // _billCheckoutPresenter.payBillCheckOut(myOrderData.restId,
    //     myOrderData.totalAmount, sliderValue.toString(), "ZAR", context);
  }

  @override
  Future<void> payBillCheckoutFailed() async {
    await progressDialog.hide();
    setState(() {
      isIgnoreTouch = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> payBillCheckoutSuccess(PaycheckoutNetbanking model) async {
    setState(() {
      isIgnoreTouch = false;
    });
    if (billModel == null) {
      billModel = model;
    }
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
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
      await progressDialog.hide();
      Constants.showAlert(
          "Payment Failed!", "Please pay first before place order.", context);
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
      // _paymentTipandPayDiPresenter.onCancelledPayment(
      //     myOrderData.id, widget.orderType, context);
    }
  }

  @override
  Future<void> getOrderDetailsFailed() async {
    await progressDialog.hide();
    setState(() {
      isIgnoreTouch = false;
    });
  }

  @override
  Future<void> getOrderDetailsSuccess(
      OrderDetailData orderData, OrderDetailsModel model) async {
    setState(() {
      if (myOrderDataDetails == null) {
        myOrderDataDetails = orderData;
        _model = model;
      }
    });
    await progressDialog.hide();
    setState(() {
      isIgnoreTouch = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> paymentCheckoutFailed() async {
    await progressDialog.hide();
    setState(() {
      isIgnoreTouch = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> paymentCheckoutSuccess(
      PaymentCheckoutModel paymentCheckoutModel) async {
    setState(() {
      isIgnoreTouch = false;
    });
    if (paymentCheckoutModel.statusCode == 200) {
      _paymentCheckoutModel = paymentCheckoutModel;
      await progressDialog.show();
      _paymentDeliveryPresenter.placeOrderDelivery(
          Globle().loginModel.data.id,
          widget.restId,
          widget.totalAmount,
          deliveryCharge,
          widget.houseNo,
          widget.landmark,
          widget.latitude,
          widget.longitude,
          widget.items,
          context);
      //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
      // _finalBillPresenter.payfinalOrderBill(
      //   Globle().loginModel.data.id,
      //   myOrderData.restId,
      //   myOrderData.id,
      //   STR_CARD,
      //   myOrderData.totalAmount,
      //   (double.parse(myOrderData.totalAmount) + sliderValue).toString(),
      //   paymentCheckoutModel.transactionId,
      //   context,
      //   sliderValue.toString(),
      // );
    } else {
      await progressDialog.hide();
      Constants.showAlert(STR_FOODZI_TITLE, STR_PAYMENT_FAILED, context);
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    }
  }

  @override
  Future<void> payfinalBillFailed() async {
    await progressDialog.hide();
    setState(() {
      isIgnoreTouch = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> payfinalBillSuccess() async {
    setState(() {
      isIgnoreTouch = false;
    });
    Preference.setPersistData<int>(null, PreferenceKeys.orderId);
    Preference.removeForKey(PreferenceKeys.orderId);
    Globle().orderID = 0;
    Globle().dinecartValue = 0;
    Preference.setPersistData<int>(null, PreferenceKeys.tableId);
    Preference.setPersistData<int>(null, PreferenceKeys.restaurantID);
    Preference.setPersistData<bool>(null, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData<int>(null, PreferenceKeys.dineCartItemCount);
    Preference.setPersistData<int>(null, PreferenceKeys.currentRestaurantId);
    Preference.setPersistData<int>(null, PreferenceKeys.currentOrderId);
    Preference.setPersistData<String>(null, PreferenceKeys.restaurantName);
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    showAlertSuccess(STR_PAYMENT_SUCCESS, STR_TRANSACTION_DONE, context);
  }

  @override
  Future<void> cancelledPaymentFailed() async {
    await progressDialog.hide();
    setState(() {
      isIgnoreTouch = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> cancelledPaymentSuccess() async {
    await progressDialog.hide();
    setState(() {
      isIgnoreTouch = false;
    });
    // Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    Constants.showAlert(STR_FOODZI_TITLE, STR_PAYMENT_CANCELLED, context);
  }

  @override
  void onFailedQuantityIncrease() {}
  @override
  void onSuccessQuantityIncrease() {}
  @override
  void getDeliveryDataFailed() {}
  @override
  void getDeliveryDataSuccess(DeliveryData data) {
    setState(() {
      isIgnoreTouch = false;
    });
    if (data != null) {
      setState(() {
        _deliveryData = data;
        deliveryCharge = _deliveryData.deliveryCharge;
      });
    }
  }
}
