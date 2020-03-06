import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayPresenter.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDiPresenter.dart';
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

  PaymentTipAndPayDi({this.orderID, this.restid});
  // PaymentTipAndPay({Key key}) : super(key: key);
  _PaymentTipAndPayDiState createState() => _PaymentTipAndPayDiState();
}

class _PaymentTipAndPayDiState extends State<PaymentTipAndPayDi>
    implements PaymentTipandPayDiModelView, PayFinalBillModelView {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  ScrollController _controller = ScrollController();
  var sliderValue = 0.0;
  PaymentTipandPayDiPresenter _paymentTipandPayDiPresenter;
  PayFinalBillPresenter _finalBillPresenter;
  int selectedRadioTile;
  // bool isSplitBillVisible = false;

  Data myOrderData;
  @override
  void initState() {
    // TODO: implement initState
    _paymentTipandPayDiPresenter = PaymentTipandPayDiPresenter(this);
    _finalBillPresenter = PayFinalBillPresenter(this);

    _paymentTipandPayDiPresenter.getOrderDetails(widget.orderID, context);
    //_finalBillPresenter.payfinalOrderBill(Globle().loginModel.data.id, restId, widget.orderID, payment_mode, amount, total_amount, context)
    selectedRadioTile = 1;
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
          title: Text("Payment"),
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
                  // isSplitBillVisible?

                  Container(
                    height: 35,
                    child: FlatButton(
                      child: Text(
                        'Split Bill',
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
                        // showDialog(context: context, child: new RadioDialog());
                        showDialog(
                            context: context, child: RadioDialogAddPeople());
                      },
                    ),
                  ),
                  // : Container(
                  //     height: 35,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      _finalBillPresenter.payfinalOrderBill(
                          Globle().loginModel.data.id,
                          myOrderData.restId,
                          myOrderData.id,
                          "cash",
                          double.parse(myOrderData.totalAmount),
                          double.parse(myOrderData.totalAmount) +
                              sliderValue.toInt(),
                          context);
                      // Navigator.pushNamed(context, '/PaymentMethod');
                      // _paymentTipAndPayPresenter.placeOrder(
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
                          color: ((Globle().colorscode) != null)
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      // color: getColorByHex(Globle().colorscode,
                      child: Center(
                        child: Text(
                          'PAY BILL',
                          style: TextStyle(
                              fontFamily: 'gotham',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
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
              // Row(
              //   children: <Widget>[
              //     SizedBox(
              //       width: 20,
              //     ),
              //     Container(
              //       width: MediaQuery.of(context).size.width * 0.8,
              //       child: Text(
              //         'Wimpy',
              //         textAlign: TextAlign.start,
              //         style: TextStyle(
              //             fontSize: 20,
              //             fontFamily: 'gotham',
              //             fontWeight: FontWeight.w600,
              //             color: greytheme700),
              //       ),
              //     ),
              //   ],
              // ),
              // Divider(
              //   thickness: 2,
              //   //endIndent: 10,
              //   //indent: 10,
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  // SizedBox(
                  //   width: 26,
                  // ),
                  // Image.asset('assets/DineInImage/Group1504.png'),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Dine-in',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'gotham',
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
                        ? 'Selected Table : ${myOrderData.tableName}'
                        : "Table 1",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                        fontSize: 14,
                        fontFamily: 'gotham',
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
                                'assets/VegIcon/Group1661.png',
                                height: 20,
                                width: 20,
                              )
                            : Image.asset(
                                'assets/VegIcon/Group1661.png',
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
                                  'Bacon & Cheese Burger',
                              style: TextStyle(
                                  // fontFamily: 'gotham',
                                  fontSize: 18,
                                  color: greytheme700),
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
                                  "  Lorem Epsom is simply dummy text Lorem Epsom is simply dummy text",
                              style: TextStyle(
                                color: greytheme1000,
                                fontSize: 14,
                                // fontFamily: 'gotham',
                              ),
                              // minFontSize: 8,
                              maxFontSize: 12,
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
                              ? '\$ ${myOrderData.list[index].totalAmount}'
                              : '\$17',
                          style: TextStyle(
                              color: greytheme700,
                              fontSize: 16,
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
              'Tip',
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
                activeColor: ((Globle().colorscode) != null)
                    ? getColorByHex(Globle().colorscode)
                    : orangetheme,
                inactiveColor: greytheme100,
                min: 0,
                max: 20,
                //divisions: 20,
                value: sliderValue,
                // label: '${sliderValue}',
                onChanged: (newValue) {
                  setState(() {
                    sliderValue = newValue;
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
              '\$ ${sliderValue.toInt()}',
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
              'Bill Details',
              style: TextStyle(fontSize: 16, color: greytheme700),
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
                  'Subtotal',
                  style: TextStyle(fontSize: 12, color: greytheme700),
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
                      ? " \$ ${myOrderData.totalAmount}"
                      : '\$11.20',
                  style: TextStyle(fontSize: 12, color: greytheme700),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          // Row(
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.only(left: 20),
          //       child: Text(
          //         'VAT (7.7%)',
          //         style: TextStyle(fontSize: 12, color: greytheme700),
          //       ),
          //     ),
          //     Expanded(
          //       child: SizedBox(
          //         width: 120,
          //       ),
          //       flex: 2,
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(right: 20),
          //       child: Text(
          //         '\$ 0.0',
          //         style: TextStyle(fontSize: 12, color: greytheme700),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 13,
          // ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Tip',
                  style: TextStyle(fontSize: 12, color: greytheme700),
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
                  '\$ ${sliderValue.toInt()}',
                  style: TextStyle(fontSize: 12, color: greytheme700),
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
                  'Total',
                  style: TextStyle(fontSize: 12, color: greytheme700),
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
                      ? '\$ ${int.parse(myOrderData.totalAmount) + sliderValue.toInt()}'
                      : "\$ ",
                  // (widget.totalAmount) != null?
                  // " \$ ${widget.totalAmount}":'\$11.20',
                  style: TextStyle(fontSize: 12, color: greytheme700),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: Divider(
              thickness: 0.4,
              color: greytheme300,
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: RadioListTile(
                  value: 1,
                  groupValue: selectedRadioTile,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Pay",
                          style: TextStyle(color: greytheme300),
                        ),
                      ),
                      Text(
                        "By Cash",
                        style: TextStyle(color: greytheme300),
                      ),
                    ],
                  ),
                  onChanged: (val) {
                    print("Radio Tile pressed $val");
                    setSelectedRadioTile(val);
                    // isSplitBillVisible = false;
                  },
                  activeColor: ((Globle().colorscode) != null)
                      ? getColorByHex(Globle().colorscode)
                      : orangetheme,
                ),
              ),
              Expanded(
                  child: Container(
                      height: 30, child: VerticalDivider(color: greytheme300))),
              Expanded(
                flex: 5,
                child: RadioListTile(
                  value: 2,
                  groupValue: selectedRadioTile,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          "Net",
                          style: TextStyle(color: greytheme300),
                        ),
                      ),
                      Text(
                        "Banking",
                        style: TextStyle(color: greytheme300),
                      ),
                    ],
                  ),
                  onChanged: (val) {
                    print("Radio Tile pressed $val");
                    setSelectedRadioTile(val);
                    // isSplitBillVisible = true;
                  },
                  activeColor: ((Globle().colorscode) != null)
                      ? getColorByHex(Globle().colorscode)
                      : orangetheme,
                ),
              )
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
                      fontSize: 18,
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w600,
                      color: greytheme700),
                ),
                content:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Image.asset(
                    'assets/SuccessIcon/success.png',
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
                        fontSize: 15,
                        fontFamily: 'gotham',
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
                    child: Text("Ok",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'gotham',
                            fontWeight: FontWeight.w600,
                            color: greytheme700)),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      //  (widget.orderType == 'dine_in');
                      // ?  Navigator.of(context).pushReplacementNamed('/DineInView')
                      // : Navigator.of(context).pushReplacementNamed('/TakeAwayView');
                    },
                  )
                ],
              ),
            ));
  }

  // @override
  // void placeOrderfailed() {
  //   Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  //   Preference.setPersistData(null, PreferenceKeys.restaurantID);
  //   Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
  //   // TODO: implement placeOrderfailed
  // }

  // @override
  // void placeOrdersuccess(OrderData orderData) {
  //   print("Place ORDER SUCCESS.");
  //   setState(() {
  //     if (myOrderData == null) {
  //       myOrderData = orderData;
  //     }
  //   });
  //   Preference.setPersistData(null, PreferenceKeys.restaurantID);
  //   Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
  //   Globle().orderNumber = orderData.orderNumber;
  //   DialogsIndicator.showLoadingDialog(context, _keyLoader, "Loading");

  //   showAlertSuccess(
  //       "Order Placed", "Your order has been successfully placed.", context);
  //   Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

  //Navigator.of(context).pushNamed('/ConfirmationDineView');
  // Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => DineInView(

  //             //restId: widget.restId
  //             )));

  // TODO: implement placeOrdersuccess
  // }

  @override
  void getOrderDetailsFailed() {
    // TODO: implement getOrderDetailsFailed
  }

  @override
  void getOrderDetailsSuccess(Data orderData) {
    // TODO: implement getOrderDetailsSuccess
    setState(() {
      if (myOrderData == null) {
        myOrderData = orderData;
      }
    });
    // DialogsIndicator.showLoadingDialog(context, _keyLoader, "Loading");
    // showAlertSuccess(
    //     "Order Placed", "Your order has been successfully placed.", context);
    // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void payfinalBillFailed() {
    // TODO: implement payfinalBillFailed
  }

  @override
  void payfinalBillSuccess() {
    print("payment Success");
    Preference.setPersistData(null, PreferenceKeys.ORDER_ID);
    Preference.setPersistData(null, PreferenceKeys.restaurantID);
    Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData(null, PreferenceKeys.dineCartItemCount);
    Preference.setPersistData(null, PreferenceKeys.restaurantName);
    Constants.showAlertSuccess("Payment Success",
        "your Transactions Has been Done Successfully", context);
    // TODO: implement payfinalBillSuccess
  }
}
