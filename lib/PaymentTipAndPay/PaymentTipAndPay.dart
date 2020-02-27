import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineView.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/Otpverify.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayPresenter.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';

class PaymentTipAndPay extends StatefulWidget {
  int price;
  int restId;
  int userId;
  String orderType;
  int tableId;
  List<int> items;
  int totalAmount;
  String latitude;
  String longitude;
  List<MenuCartList> itemdata;
  PaymentTipAndPay(
      {this.userId,
      this.price,
      this.items,
      this.restId,
      this.latitude,
      this.longitude,
      this.orderType,
      this.tableId,
      this.totalAmount,
      this.itemdata});
  // PaymentTipAndPay({Key key}) : super(key: key);
  _PaymentTipAndPayState createState() => _PaymentTipAndPayState();
}

class _PaymentTipAndPayState extends State<PaymentTipAndPay>
    implements PaymentTipAndPayModelView {
  ScrollController _controller = ScrollController();
  var sliderValue = 0.0;
  PaymentTipAndPayPresenter _paymentTipAndPayPresenter;

  OrderData myOrderData;
  @override
  void initState() {
    // TODO: implement initState
    print(widget.items);
    _paymentTipAndPayPresenter = PaymentTipAndPayPresenter(this);
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
                  Container(
                    height: 35,
                    child: FlatButton(
                      child: Text(
                        'Split Bill',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'gotham',
                            decoration: TextDecoration.underline,
                            decorationColor: getColorByHex(Globle().colorscode),
                            color: getColorByHex(Globle().colorscode),
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        // Navigator.pop(context);
                      },
                    ),
                  ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/PaymentMethod');
                      _paymentTipAndPayPresenter.placeOrder(
                          widget.restId,
                          Globle().loginModel.data.id,
                          widget.orderType,
                          1,
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
                    (widget.orderType == 'dine_in') ? 'Dine-in' : 'Take Away',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: getColorByHex(Globle().colorscode)),
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
                    widget.tableId == null
                        ? "Table 1"
                        : 'Table ${widget.tableId}',
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
                        child: (widget.itemdata[index].items.menuType == 'veg')
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
                          Text(
                            widget.itemdata[index].items.itemName ??
                                'Bacon & Cheese Burger',
                            style: TextStyle(
                                // fontFamily: 'gotham',
                                fontSize: 18,
                                color: greytheme700),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 30,
                            width: 180,
                            child: AutoSizeText(
                              widget.itemdata[index].items.itemDescription ??
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
                          '\$ ${widget.itemdata[index].totalAmount}' ?? '\$17',
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
                activeColor: getColorByHex(Globle().colorscode),
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
                  (widget.totalAmount) != null
                      ? " \$ ${widget.totalAmount}"
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
                  '\$ ${widget.totalAmount + sliderValue.toInt()}',
                  // (widget.totalAmount) != null?
                  // " \$ ${widget.totalAmount}":'\$11.20',
                  style: TextStyle(fontSize: 12, color: greytheme700),
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
                      //                 (widget.orderType == 'dine_in')
                      // ?  Navigator.of(context).pushReplacementNamed('/DineInView')
                      // : Navigator.of(context).pushReplacementNamed('/TakeAwayView');
                    },
                  )
                ],
              ),
            ));
  }

  @override
  void placeOrderfailed() {
    // TODO: implement placeOrderfailed
  }

  @override
  void placeOrdersuccess(OrderData orderData) {
    print("Place ORDER SUCCESS.");
    setState(() {
      if (myOrderData == null) {
        myOrderData = orderData;
      }
    });
    // showAlertSuccess(
    //     "Order Placed", "Your order has been successfully placed.", context);
    Navigator.of(context).pushNamed('/ConfirmationDineView');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ConfirmationDineView(restID: widget.restId)));

    // TODO: implement placeOrdersuccess
  }
}
