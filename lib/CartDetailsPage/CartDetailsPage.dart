import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDi.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDiPresenter.dart';
import 'package:foodzi/RestaurantPage/RestaurantView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CartDetailsPage extends StatefulWidget {
  int orderId;
  int flag;
  bool isFromOrder = false;
  int restId;
  CartDetailsPage({this.orderId, this.flag, this.isFromOrder, this.restId});
  @override
  State<StatefulWidget> createState() {
    return CartDetailsPageState();
  }
}

class CartDetailsPageState extends State<CartDetailsPage>
    implements PaymentTipandPayDiModelView {
  int count;
  int cartId;
  int page = 1;
  bool isloading = false;
  int id;
  List<int> itemList = [];
  ProgressDialog progressDialog;
  int _dropdownTableNumber;
  Stream stream;
  StreamSubscription<double> _streamSubscription;
  var isSplitTrans = false;

  String tableName;
  bool isTableList = false;
  PaymentTipandPayDiPresenter _paymentTipandPayDiPresenter;
  OrderDetailsModel _model;
  OrderDetailData myOrderDataDetails;
  var isFirst = false;
  var _timer;
  Duration _duration = Duration(seconds: 30);
  @override
  void initState() {
    _paymentTipandPayDiPresenter = PaymentTipandPayDiPresenter(this);
    stream = Globle().streamController.stream;

    setState(() {
      isloading = true;
      isFirst = true;
    });
    callApi();
    setTimer();
    //onStreamListen();
    super.initState();
  }

  onStreamListen() {
    if (stream != null) {
      _streamSubscription = stream.listen((onData) {
        callApi();
      });
    }
  }

  setTimer() {
    _timer = Timer(_duration, () {
      isFirst = true;
      callApi();
    });
  }

  callApi() async {
    if (!isFirst) {
      await progressDialog.show();
    }

    _paymentTipandPayDiPresenter.getOrderDetails(widget.orderId, context);
  }

  Widget totalamounttext() {
    return Container(
      // color: Colors.grey,
      child: Center(
        child: Column(
          children: <Widget>[
            Text(
              '${"Total"} : ' +
                  '${getCurrencySymbol()} ' +
                  '${gettottalAmount()}',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }

  getCurrencySymbol() {
    if (_model != null) {
      if (_model.currencySymbol != null) {
        return _model.currencySymbol;
      }
      return;
    }
    return;
  }

  gettottalAmount() {
    if (_model != null) {
      if (_model.grandTotal != null) {
        return _model.grandTotal;
      }
      return;
    }
    return;
  }

  Future<bool> _onBackPressed() {
    if (widget.isFromOrder) {
      Navigator.of(context).pop();
    } else {
      if (widget.flag == 1) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else if (widget.flag == 2) {
        Navigator.of(context).pop();
      } else if (widget.flag == 3) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: STR_LOADING);

    Widget _getmainviewTableno() {
      return Container(
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
                    "DINE IN",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: "gotham",
                        fontWeight: FontWeight.w600,
                        color: Globle().colorscode != null
                            ? getColorByHex(Globle().colorscode)
                            : orangetheme),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                  child: Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Text("${getTableName()}",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "gotham",
                          fontWeight: FontWeight.w600,
                          color: Globle().colorscode != null
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme)),
                ],
              )),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        // ),
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        left: false,
        top: false,
        right: false,
        child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: greytheme100),
            title: Text(
              "MY ORDER",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "gotham",
                  fontWeight: FontWeight.w600,
                  color: Globle().colorscode != null
                      ? getColorByHex(Globle().colorscode)
                      : orangetheme),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: isloading
              ? Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "Loading..",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: FONTSIZE_15,
                              fontFamily: KEY_FONTFAMILY,
                              fontWeight: FontWeight.w500,
                              color: greytheme1200),
                        ),
                      ),
                      CircularProgressIndicator()
                    ],
                  ),
                )
              : Column(
                  children: <Widget>[
                    _getmainviewTableno(),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _getAddedListItem()
                  ],
                ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
                height: 110,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _model != null ? totalamounttext() : Text(""),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: FlatButton(
                    //     child: Text(
                    //       "Add More Item",
                    //       style: TextStyle(
                    //           fontSize: 16,
                    //           fontFamily: "gotham",
                    //           decoration: TextDecoration.underline,
                    //           decorationColor: getColorByHex(Globle().colorscode),
                    //           color: getColorByHex(Globle().colorscode),
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //     onPressed: () {
                    //       //Add More Items Pressed
                    //       Navigator.pop(context);
                    //     },
                    //   ),
                    // ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                        GestureDetector(
                          onTap: () {
                            _timer.cancel();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentTipAndPayDi(
                                          orderID: widget.orderId,
                                          tableId: myOrderDataDetails.tableId,
                                        )));
                          },
                          child: isPayBillButtonEnable()
                              ? Container()
                              : Container(
                                  height: 54,
                                  width: isAddMoreButtonEnable()
                                      ? (MediaQuery.of(context).size.width *
                                          0.96)
                                      : (MediaQuery.of(context).size.width *
                                          0.45),
                                  decoration: BoxDecoration(
                                      color: Globle().colorscode != null
                                          ? getColorByHex(Globle().colorscode)
                                          : orangetheme,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  child: Center(
                                    child: Text(
                                      STR_PAY_BILL,
                                      style: TextStyle(
                                          fontFamily: "gotham",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                        ),
                        isAddMoreButtonEnable()
                            ? Container()
                            : SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.06),
                        GestureDetector(
                          onTap: () {
                            if (widget.isFromOrder) {
                              if (myOrderDataDetails != null) {
                                if (myOrderDataDetails.restId != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RestaurantView(
                                                restId:
                                                    myOrderDataDetails.restId,
                                                title: "",
                                                imageUrl: "",
                                                isFromOrder: true,
                                              )));
                                }
                              }
                            } else {
                              if (widget.flag == 1) {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              } else if (widget.flag == 2) {
                                Navigator.of(context).pop();
                              } else if (widget.flag == 3) {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: isAddMoreButtonEnable()
                              ? Container()
                              : Container(
                                  height: 54,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  decoration: BoxDecoration(
                                      color: greentheme100,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15))),
                                  child: Center(
                                    child: Text(
                                      "Add More Item",
                                      style: TextStyle(
                                          fontFamily: "gotham",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget steppercount(int index) {
    return Container(
      height: 24,
      width: 150,
      child: Row(children: <Widget>[
        InkWell(
          onTap: () {},
          splashColor: Colors.redAccent.shade200,
          child: Container(
            decoration: BoxDecoration(
                color: greytheme100,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            alignment: Alignment.center,
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13, right: 13),
          child: Text(
            myOrderDataDetails.list[index].quantity.toString(),
            style: TextStyle(
                fontSize: FONTSIZE_16,
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w600,
                color: greytheme700),
          ),
        ),
        InkWell(
          onTap: () {
            if (!isAddMoreButtonEnable()) {
              callIncreaseQuantityApi(myOrderDataDetails.list[index].itemId,
                  myOrderDataDetails.list[index].id.toString());
            }
          },
          splashColor: Colors.lightBlue,
          child: Container(
            decoration: BoxDecoration(
                color: Globle().colorscode != null
                    ? getColorByHex(Globle().colorscode)
                    : orangetheme,
                borderRadius: BorderRadius.all(Radius.circular(4))),
            alignment: Alignment.center,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _getAddedListItem() {
    return (myOrderDataDetails != null)
        ? Expanded(
            child: RefreshIndicator(
                child: ListView.builder(
                    itemCount: myOrderDataDetails.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      id = myOrderDataDetails.list[index].itemId;
                      cartId = myOrderDataDetails.list[index].id;

                      return Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: (myOrderDataDetails
                                                .list[index].items.menuType ==
                                            "veg")
                                        ? Image.asset(
                                            IMAGE_VEG_ICON_PATH,
                                            height: 25,
                                            width: 25,
                                          )
                                        : Image.asset(
                                            IMAGE_VEG_ICON_PATH,
                                            color: redtheme,
                                            width: 25,
                                            height: 25,
                                          ),
                                  ),
                                  SizedBox(width: 5),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                          myOrderDataDetails.list[index].items
                                                      .itemName !=
                                                  null
                                              ? StringUtils.capitalize(
                                                  myOrderDataDetails.list[index]
                                                      .items.itemName)
                                              : "Bacon & Cheese Burger",
                                          style: TextStyle(
                                              fontFamily: "gotham",
                                              fontSize: 16,
                                              color: greytheme700),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        height: 30,
                                        width: 180,
                                        child: AutoSizeText(
                                          getExtra(
                                              myOrderDataDetails.list[index]),
                                          style: TextStyle(
                                            color: greytheme1000,
                                            fontSize: FONTSIZE_14,
                                          ),
                                          maxFontSize: 12,
                                          maxLines: 2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "Quantity : ",
                                            style: TextStyle(
                                                fontFamily: "gotham",
                                                fontSize: 16,
                                                color: greytheme700),
                                          ),
                                          SizedBox(width: 5),
                                          steppercount(index)
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 30,
                                      //   width: 180,
                                      //   child: AutoSizeText(
                                      //     getExtra(myOrderDataDetails.list[index]),
                                      //     style: TextStyle(
                                      //       color: Colors.grey,
                                      //       fontSize: 14,
                                      //     ),
                                      //     maxFontSize: 12,
                                      //     maxLines: 2,
                                      //   ),
                                      // ),
                                      //SizedBox(height: 10),
                                    ],
                                  ),
                                  // Expanded(
                                  //   child: Container(),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: 0,
                                    ),
                                    child: Text(
                                      "${_model.currencySymbol} " +
                                              "${myOrderDataDetails.list[index].totalAmount}" ??
                                          '',
                                      style: TextStyle(
                                          color: greytheme700,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ]),

                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: 20,
                                //color: greytheme1400,
                                decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, top: 4, right: 2),
                                  child: Text(
                                    myOrderDataDetails.list[index].status,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.22),
                                  ),
                                ),
                              ),
                            ),

                            //SizedBox(height: 12),
                            Divider(
                              height: 2,
                              thickness: 2,
                            ),
                            SizedBox(height: 8),
                          ],
                        ),
                      );
                    }),
                onRefresh: _getData))
        : Expanded(
            child: Center(
              child: Text(
                "Nothing in the Cart",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w500,
                    color: greytheme1200),
              ),
            ),
          );
  }

  bool isPayBillButtonEnable() {
    if (myOrderDataDetails != null) {
      if (myOrderDataDetails.splitbilltransactions != null) {
        if (myOrderDataDetails.splitbilltransactions.length > 0) {
          var isPaid = false;
          for (var trans in myOrderDataDetails.splitbilltransactions) {
            if (trans.userId != null) {
              if (Globle().loginModel.data.id == trans.userId) {
                isPaid = false;
                // if (trans.paystatus == "paid") {
                //   isPaid = true;
                // }
              }
            } else {
              isPaid = true;
            }
          }
          return isPaid;
        }
      }
    }

    return false;
  }

  bool isAddMoreButtonEnable() {
    if (myOrderDataDetails != null) {
      if (myOrderDataDetails.splitbilltransactions != null) {
        if (myOrderDataDetails.splitbilltransactions.length > 0) {
          isSplitTrans = true;
          bool isSplitBillTrans = isSplitTrans;
          // for (var trans in myOrderDataDetails.splitbilltransactions) {
          //   if (trans.paystatus == "paid") {
          //     isPaid = true;
          //   }
          // }
          return isSplitBillTrans;
        }
      }
    }

    return false;
  }

  callIncreaseQuantityApi(int itemId, String id) async {
    await progressDialog.show();
    _paymentTipandPayDiPresenter.increaseQuantity(
        myOrderDataDetails.id.toString(), itemId.toString(), id, context);
  }

  // String getExtra(CartDetailData menuCartList) {
  //   var extras = "";
  //   for (int i = 0; i < menuCartList.cartExtraItems.length; i++) {
  //     if (menuCartList.cartExtraItems[i].spreads.length > 0) {
  //       for (int j = 0;
  //           j < menuCartList.cartExtraItems[i].spreads.length;
  //           j++) {
  //         extras += "${menuCartList.cartExtraItems[i].spreads[j].name}, ";
  //       }
  //     }

  //     if (menuCartList.cartExtraItems[i].extras.length > 0) {
  //       for (int j = 0; j < menuCartList.cartExtraItems[i].extras.length; j++) {
  //         extras += "${menuCartList.cartExtraItems[i].extras[j].name}, ";
  //       }
  //     }
  //     if (menuCartList.cartExtraItems[i].switches.length > 0) {
  //       for (int j = 0;
  //           j < menuCartList.cartExtraItems[i].switches.length;
  //           j++) {
  //         extras += "${menuCartList.cartExtraItems[i].switches[j].name}, ";
  //       }
  //     }
  //   }
  //   if (extras.isNotEmpty) {
  //     extras = removeLastChar(extras);
  //     extras = removeLastChar(extras);
  //   }
  //   return extras;
  // }
  // Widget getTableNumber() {
  //   return Container(
  //     margin: EdgeInsets.only(left: 20),
  //     height: 50,
  //     width: MediaQuery.of(context).size.width * 0.8,
  //     child: FormField(builder: (FormFieldState state) {
  //       return DropdownButtonFormField(
  //         items: _dropdownItemsTable.map((tableNumber) {
  //           return new DropdownMenuItem(
  //               value: tableNumber.id,
  //               child: Row(
  //                 children: <Widget>[
  //                   Container(
  //                       width: MediaQuery.of(context).size.width * 0.4,
  //                       child: Text(
  //                         "${tableNumber.name}",
  //                         style: TextStyle(
  //                           decoration: TextDecoration.underline,
  //                           decorationColor: getColorByHex(Globle().colorscode),
  //                           fontSize: 14,
  //                           fontFamily: "gotham",
  //                           fontWeight: FontWeight.w600,
  //                           color: getColorByHex(Globle().colorscode),
  //                         ),
  //                       )),
  //                 ],
  //               ));
  //         }).toList(),
  //         onChanged: (newValue) async {
  //           setState(() {
  //             _dropdownTableNumber = newValue;
  //           });
  //           for (int i = 0; i < _dropdownItemsTable.length; i++) {
  //             if (newValue == _dropdownItemsTable[i].id) {
  //               print(_dropdownItemsTable[i].name);
  //               tableName = _dropdownItemsTable[i].name;
  //             }
  //           }
  //           await progressDialog.show();
  //           _myCartpresenter.getCartMenuList(widget.restId, newValue, context);

  //           //DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_BLANK);
  //           // _myCartpresenter.addTablenoToCart(Globle().loginModel.data.id,
  //           //     widget.restId, _dropdownTableNumber, context);
  //         },
  //         value: _dropdownTableNumber,
  //         decoration: InputDecoration(
  //           contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: greentheme100, width: 2),
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //               borderSide: BorderSide(color: greytheme900, width: 2)),
  //           border:
  //               OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
  //           filled: false,
  //           hintText: "Choose Table",
  //           labelText:
  //               _dropdownTableNumber == null ? "Add Table" : "Table Number",
  //           labelStyle: TextStyle(
  //               decoration: TextDecoration.underline,
  //               decorationColor: Colors.black,
  //               fontSize: 14,
  //               fontFamily: "gotham",
  //               fontWeight: FontWeight.w600,
  //               color: greytheme100),
  //         ),
  //       );
  //     }),
  //   );
  // }

  String getExtra(ListElements menuCartList) {
    var extras = STR_BLANK;
    for (int i = 0; i < menuCartList.cartExtras.length; i++) {
      if (menuCartList.cartExtras[i].spreads.length > 0) {
        for (int j = 0; j < menuCartList.cartExtras[i].spreads.length; j++) {
          extras += "${menuCartList.cartExtras[i].spreads[j].name}, ";
        }
      }

      if (menuCartList.cartExtras[i].extras.length > 0) {
        for (int j = 0; j < menuCartList.cartExtras[i].extras.length; j++) {
          extras += "${menuCartList.cartExtras[i].extras[j].name}, ";
        }
      }
      if (menuCartList.cartExtras[i].switches.length > 0) {
        for (int j = 0; j < menuCartList.cartExtras[i].switches.length; j++) {
          extras += "${menuCartList.cartExtras[i].switches[j].name}, ";
        }
      }
    }
    if (extras.isNotEmpty) {
      extras = removeLastChar(extras);
      extras = removeLastChar(extras);
    }
    return extras;
  }

  static String removeLastChar(String str) {
    return str.substring(0, str.length - 1);
  }

  Future<void> _getData() async {
    setState(() {
      setState(() {
        isFirst = false;
      });
      callApi();
    });
  }

  @override
  Future<void> getOrderDetailsFailed() async {
    _timer.cancel();
    if (!isFirst) {
      await progressDialog.hide();
    }
    setState(() {
      isloading = false;
      isFirst = false;
    });
  }

  @override
  Future<void> getOrderDetailsSuccess(
      OrderDetailData orderData, OrderDetailsModel model) async {
    setState(() {
      myOrderDataDetails = orderData;
      _model = model;
    });
    if (!isFirst) {
      await progressDialog.hide();
    }
    setState(() {
      isloading = false;
      isFirst = false;
    });
  }

  @override
  void paymentCheckoutFailed() {}

  @override
  void paymentCheckoutSuccess(PaymentCheckoutModel paymentCheckoutModel) {}
  @override
  void cancelledPaymentFailed() {}

  @override
  void cancelledPaymentSuccess() {}

  getTableName() {
    if (myOrderDataDetails != null) {
      if (myOrderDataDetails.tableName != null) {
        return myOrderDataDetails.tableName;
      }
    }
    return;
  }

  @override
  void onFailedQuantityIncrease() async {
    await progressDialog.hide();
    // TODO: implement onFailedQuantityIncrease
  }

  @override
  void onSuccessQuantityIncrease() async {
    await progressDialog.hide();
    callApi();
    // TODO: implement onSuccessQuantityIncrease
  }

  @override
  void dispose() {
    // TODO: implement dispose
    if (_timer != null) {
      _timer.cancel();
    }

    if (_streamSubscription != null) {
      _streamSubscription.cancel();
    }

    super.dispose();
  }
}
