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
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CartDetailsPage extends StatefulWidget {
  int orderId;

  CartDetailsPage({this.orderId});
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
  String tableName;
  bool isTableList = false;
  PaymentTipandPayDiPresenter _paymentTipandPayDiPresenter;
  OrderDetailsModel _model;
  OrderDetailData myOrderDataDetails;

  @override
  void initState() {
    _paymentTipandPayDiPresenter = PaymentTipandPayDiPresenter(this);
    _paymentTipandPayDiPresenter.getOrderDetails(widget.orderId, context);
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);

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
                        color: getColorByHex(Globle().colorscode)),
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
                          color: getColorByHex(Globle().colorscode))),
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

    return SafeArea(
      left: false,
      top: false,
      right: false,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: greytheme100),
          title: Text(
            "MY CART",
            style: TextStyle(
                fontSize: 20,
                fontFamily: "gotham",
                fontWeight: FontWeight.w600,
                color: getColorByHex(Globle().colorscode)),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
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
            isloading ? Container() : _getAddedListItem()
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _model != null ? totalamounttext() : Text(""),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      child: Text(
                        "Add More Item",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "gotham",
                            decoration: TextDecoration.underline,
                            decorationColor: getColorByHex(Globle().colorscode),
                            color: getColorByHex(Globle().colorscode),
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        //Add More Items Pressed
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentTipAndPayDi(
                                    orderID: widget.orderId,
                                    tableId: myOrderDataDetails.tableId,
                                  )));
                    },
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                          color: getColorByHex(Globle().colorscode),
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
                ],
              )),
        ),
      ),
    );
  }

  Widget _getAddedListItem() {
    return (myOrderDataDetails != null)
        ? Expanded(
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
                                padding: EdgeInsets.only(left: 20),
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
                              SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Text(
                                      myOrderDataDetails
                                                  .list[index].items.itemName !=
                                              null
                                          ? StringUtils.capitalize(
                                              myOrderDataDetails
                                                  .list[index].items.itemName)
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
                                  Text(
                                    myOrderDataDetails.list[index].quantity !=
                                            null
                                        ? "Quantity : ${myOrderDataDetails.list[index].quantity}"
                                        : "Quantity : 1",
                                    style: TextStyle(
                                        fontFamily: "gotham",
                                        fontSize: 16,
                                        color: greytheme700),
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
                              Expanded(
                                child: SizedBox(
                                  width: 0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: 12,
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
                                color: greytheme1400,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5.0, top: 4, right: 2),
                              child: Text(
                                myOrderDataDetails.list[index].status,
                                style: TextStyle(
                                    color: greytheme900,
                                    fontSize: 11,
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
                }))
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

  @override
  Future<void> getOrderDetailsFailed() async {
    await progressDialog.hide();
    // TODO: implement getOrderDetailsFailed
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

  getTableName() {
    if (myOrderDataDetails != null) {
      if (myOrderDataDetails.tableName != null) {
        return myOrderDataDetails.tableName;
      }
    }
    return;
  }
}