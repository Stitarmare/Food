import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/network/ApiBaseHelper.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/EmailReceiptDialog.dart';

class PaymentReceiptDeliveryView extends StatefulWidget {
  GetMyOrderBookingHistoryList getmyOrderBookingHistory;
  List<GetMyOrderBookingList> list;
  PaymentReceiptDeliveryView({this.getmyOrderBookingHistory, this.list});

  @override
  _PaymentReceiptDeliveryViewState createState() =>
      _PaymentReceiptDeliveryViewState();
}

class _PaymentReceiptDeliveryViewState
    extends State<PaymentReceiptDeliveryView> {
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
          title: Text(
            "Payment Receipt",
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: CustomScrollView(
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
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          child: EmailReceiptDialogView());
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
                          "Email Receipt",
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
        margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        imageUrl: BaseUrl.getBaseUrlImages() +
                            '${widget.getmyOrderBookingHistory.restaurant.coverImage}',
                        errorWidget: (context, url, error) => Image.asset(
                          RESTAURANT_IMAGE_PATH,
                          fit: BoxFit.fill,
                        ),
                      ),
                      borderRadius: new BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  SizedBox(width: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      widget.getmyOrderBookingHistory.restaurant.restName ??
                          null,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: FONTSIZE_22,
                          fontFamily: Constants.getFontType(),
                          fontWeight: FontWeight.w700,
                          color: Globle().colorscode != null
                              ? getColorByHex(Globle().colorscode)
                              : orangetheme300),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getOptions() {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20),
            child: Text(
              "Your Order",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: FONTSIZE_20,
                fontFamily: Constants.getFontType(),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          _getMenuList(),
          _getBillDetails(),
        ],
      ),
    );
  }

  Widget _getMenuList() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        itemCount: getLenghtOfHistoryOrder(),
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
                        child: (widget.list[index].items.menuType == STR_VEG)
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
                              widget.list[index].items.itemName != null
                                  ? StringUtils.capitalize(
                                      widget.list[index].items.itemName)
                                  : STR_ITEM_NAME,
                              style: TextStyle(
                                  fontSize: FONTSIZE_18,
                                  color: greytheme700,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            height: 30,
                            width: 180,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.1),
                                        // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: AutoSizeText(
                                    widget.list[index].qty != null
                                        ? widget.list[index].qty.toString()
                                        : null,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: FONTSIZE_15,
                                        fontWeight: FontWeight.w700),
                                    maxLines: 2,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text("X"),
                                SizedBox(width: 10),
                                Row(
                                  children: <Widget>[
                                    // Text(
                                    //   Globle().currencySymb != null
                                    //       ? Globle().currencySymb
                                    //       : STR_R_CURRENCY_SYMBOL,
                                    //   style: TextStyle(
                                    //       fontSize: FONTSIZE_15,
                                    //       fontWeight: FontWeight.w700),
                                    // ),
                                    Text(
                                      widget.list[index].price != null
                                          ? widget.list[index].price
                                          : widget.list[index].sizePrice != null
                                              ? widget.list[index].sizePrice
                                              : "",
                                      style: TextStyle(
                                          fontSize: FONTSIZE_15,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ],
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
                        child: Row(
                          children: <Widget>[
                            Text(
                              Globle().currencySymb != null
                                  ? Globle().currencySymb
                                  : STR_R_CURRENCY_SYMBOL,
                              style: TextStyle(
                                  fontSize: FONTSIZE_15,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '${widget.list[index].totalAmount}' ?? "0.00",
                              style: TextStyle(
                                  fontSize: FONTSIZE_16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      )
                    ]),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 0.5,
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          );
        },
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: Text(
          //     STR_BILL_DETAILS,
          //     style: TextStyle(fontSize: FONTSIZE_16, color: greytheme700),
          //   ),
          // ),
          SizedBox(
            height: 25,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Item Total",
                  style: TextStyle(
                      fontSize: FONTSIZE_18, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 120,
                ),
                flex: 2,
              ),
              Row(
                children: <Widget>[
                  Text(
                    Globle().currencySymb != null
                        ? Globle().currencySymb
                        : STR_R_CURRENCY_SYMBOL,
                    style: TextStyle(
                        fontSize: FONTSIZE_15, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      double.parse(widget.getmyOrderBookingHistory.totalAmount)
                          .toStringAsFixed(2),
                      style: TextStyle(
                          fontSize: FONTSIZE_16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 18,
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Delivery charges",
                  style: TextStyle(
                      fontSize: FONTSIZE_16, fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 120,
                ),
                flex: 2,
              ),
              Row(
                children: <Widget>[
                  Text(
                    Globle().currencySymb != null
                        ? Globle().currencySymb
                        : STR_R_CURRENCY_SYMBOL,
                    style: TextStyle(
                        fontSize: FONTSIZE_15, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: widget.getmyOrderBookingHistory.deliveryCharge != ""
                        ? Text(
                            widget.getmyOrderBookingHistory.deliveryCharge ??
                                "0.00",
                            style: TextStyle(
                                fontSize: FONTSIZE_16,
                                fontWeight: FontWeight.w500),
                          )
                        : Text(
                            "0.00",
                            style: TextStyle(
                                fontSize: FONTSIZE_16,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  STR_TOTAL,
                  style: TextStyle(
                    fontSize: FONTSIZE_18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 120,
                ),
                flex: 2,
              ),
              Row(
                children: <Widget>[
                  Text(
                    Globle().currencySymb != null
                        ? Globle().currencySymb
                        : STR_R_CURRENCY_SYMBOL,
                    style: TextStyle(
                        fontSize: FONTSIZE_18, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text(
                      getTotalAmount(),
                      style: TextStyle(
                          fontSize: FONTSIZE_18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  int getLenghtOfHistoryOrder() {
    if (widget.list != null) {
      return widget.list.length;
    }
    return 0;
  }

  String getTotalAmount() {
    double dou = double.parse(widget.getmyOrderBookingHistory.totalAmount);
    double dou1 = widget.getmyOrderBookingHistory.deliveryCharge != ""
        ? double.parse(widget.getmyOrderBookingHistory.deliveryCharge)
        : 0;
    double dou2 = dou + dou1;
    String strTotalAmount = dou2.toStringAsFixed(2);
    return strTotalAmount;
  }
}
