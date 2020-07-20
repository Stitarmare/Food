import 'dart:async';
import 'dart:convert';
import 'dart:io';
//import 'dart:html';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineViewContractor.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineviewPresenter.dart';
import 'package:foodzi/LandingPage/LandingView.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/PayCheckOutNetBanking.dart';
import 'package:foodzi/Models/error_model.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDiPresenter.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/UserFeedbackPage/UserFeedbackView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/WebViewPage.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/InvitedPeopleDialogSplitBill.dart';
import 'package:foodzi/widgets/RadioDailog.dart';
import 'package:foodzi/widgets/RadioDialogAddPeople.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
        PayBillCheckoutModelView,
        ConfirmationDineViewModelView {
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  ScrollController _controller = ScrollController();
  var sliderValue = 10;
  int tipDefaultValue = 10;
  PaymentTipandPayDiPresenter _paymentTipandPayDiPresenter;
  PayFinalBillPresenter _finalBillPresenter;
  StatusTrackViewPresenter statusTrackViewPresenter;
  PayBillCheckoutPresenter _billCheckoutPresenter;
  int selectedRadioTile;
  OrderDetailData myOrderData;
  PaycheckoutNetbanking billModel;
  ProgressDialog progressDialog;
  bool isLoading = true;
  var isSplitTrans = false;
  ConfirmationDineviewPresenter confirmationDineviewPresenter;
  OrderDetailsModel _model;
  //List<AddPeopleList> addedPeopleList = [];
  List<PeopleData> addedPeopleList = [];
  List<InvitationOrder> invitationOrder = [];
  double grandTotal = 0;
  double tipAmount;
  var isBillSplitedForUser = false;
  Stream stream;
  StreamSubscription<double> _streamSubscription;

  String searchText;
  bool isIgnoreTouch = false;

  @override
  void initState() {
    _paymentTipandPayDiPresenter = PaymentTipandPayDiPresenter(this);
    _finalBillPresenter = PayFinalBillPresenter(this);
    _billCheckoutPresenter = PayBillCheckoutPresenter(this);
    confirmationDineviewPresenter = ConfirmationDineviewPresenter(this);
    setState(() {
      isLoading = true;
    });
    confirmationDineviewPresenter.getPeopleList(searchText, context);
    _paymentTipandPayDiPresenter.getOrderDetails(widget.orderID, context);
    selectedRadioTile = 1;
    print(widget.tableId);
    print(widget.orderID);
    _model = OrderDetailsModel();
    stream = Globle().streamController.stream;

    //print(RadioDialogAddPeopleState.addPeopleList);
    if (RadioDialogAddPeopleState.addPeopleList != null) {
      //addedPeopleList = RadioDialogAddPeopleState.addPeopleList;
    } else {
      //addedPeopleList = RadioDialogAddPeopleState.addPeopleList;
    }
    onStreamListen();
    super.initState();
  }

  // checkIntenet() async {
  //   await progressDialog.show();

  //   _billCheckoutPresenter.payBillCheckOut(
  //     myOrderData.restId,
  //     getOrderTotal(),
  //     sliderValue.toString(),
  //     "ZAR",
  //     myOrderData.id,
  //     context,
  //   );
  // }

  onStreamListen() {
    if (stream != null) {
      _streamSubscription = stream.listen((onData) {
        callApi();
      });
    }
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  bool isSplitBillEnabled() {
    if (myOrderData.splitbilltransactions != null) {
      if (myOrderData.splitbilltransactions.length > 0) {
        isSplitTrans = true;
        return isSplitTrans;
      }
    }
    return isSplitTrans;
  }

  bool isInvited() {
    if (myOrderData != null) {
      if (myOrderData.invited == Invited.yes.toString().split('.').last) {
        return true;
      }
      if (myOrderData.splitbilltransactions != null) {
        var isAvalable = false;
        for (var trasaction in myOrderData.splitbilltransactions) {
          if (trasaction.paystatus == "paid") {
            isAvalable = true;
          }
        }
        return isAvalable;
      }
    }
    return false;
  }

  bool isSplitAmount() {
    if (myOrderData != null) {
      if (myOrderData.invited == Invited.yes.toString().split('.').last &&
          myOrderData.splitAmount == null) {
        return true;
      }
      if (myOrderData.splitbilltransactions != null) {
        var isAvalable = false;
        for (var trasaction in myOrderData.splitbilltransactions) {
          if (Globle().loginModel.data.id == trasaction.userId) {
            if (trasaction.paystatus != "pending") {
              isAvalable = true;
            }
          }
        }
        return isAvalable;
      }
    }
    return false;
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
          body: isLoading
              ? Container()
              : (myOrderData == null)
                  ? Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "No data found.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: FONTSIZE_15,
                                  fontFamily: KEY_FONTFAMILY,
                                  fontWeight: FontWeight.w500,
                                  color: greytheme1200),
                            ),
                          ),
                        ],
                      ),
                    )
                  : CustomScrollView(
                      controller: _controller,
                      slivers: <Widget>[_getmainviewTableno(), _getOptions()],
                    ),
          bottomNavigationBar: isLoading
              ? Container(height: 0)
              : (myOrderData == null)
                  ? Container(height: 0)
                  : BottomAppBar(
                      child: Container(
                          height: (isBillSplitedForUser) ? 0 : 80,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              isInvited()
                                  ? Expanded(child: Container())
                                  : isSplitBillEnabled()
                                      ? SizedBox(height: 35, child: Text(""))
                                      : Container(
                                          height: 35,
                                          child: FlatButton(
                                            child: Text(
                                              STR_SPLIT_BILL,
                                              style: TextStyle(
                                                  fontSize: FONTSIZE_16,
                                                  fontFamily: KEY_FONTFAMILY,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationColor: ((Globle()
                                                              .colorscode) !=
                                                          null)
                                                      ? getColorByHex(
                                                          Globle().colorscode)
                                                      : orangetheme300,
                                                  color: ((Globle()
                                                              .colorscode) !=
                                                          null)
                                                      ? getColorByHex(
                                                          Globle().colorscode)
                                                      : orangetheme300,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            onPressed: () {
                                              onSplitBillButtonTap();
                                            },
                                          ),
                                        ),
                              isSplitAmount()
                                  ? Container()
                                  : GestureDetector(
                                      onTap: () async {
                                        // await progressDialog.show();
                                        getVerifyAmount();
                                        // DialogsIndicator.showLoadingDialog(
                                        //     context, _keyLoader, STR_BLANK);

                                        // _billCheckoutPresenter.payBillCheckOut(
                                        //   myOrderData.restId,
                                        //   getOrderTotal(),
                                        //   sliderValue.toString(),
                                        //   "ZAR",
                                        //   myOrderData.id,
                                        //   context,
                                        // );
                                      },
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color:
                                                ((Globle().colorscode) != null)
                                                    ? getColorByHex(
                                                        Globle().colorscode)
                                                    : orangetheme300,
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
      ),
    );
  }

  void getVerifyAmount() async {
    if ((grandTotal.roundToDouble()) >= 1.0) {
      setState(() {
        isIgnoreTouch = true;
      });
      await progressDialog.show();

      _billCheckoutPresenter.payBillCheckOut(
        myOrderData.restId,
        getOrderTotal(),
        tipAmount.toString(),
        "ZAR",
        context,
        orderId: myOrderData.id,
      );
    } else {
      _model.currencySymbol != null
          ? Constants.showAlert(
              "Amount",
              "Amount should be greater than ${_model.currencySymbol} 1.00 & you can try by adding tip",
              context)
          : Constants.showAlert(
              "Amount",
              "Amount should be greater than 1.00 & you can try by adding tip",
              context);
    }
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
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.w600,
                      color: ((Globle().colorscode) != null)
                          ? getColorByHex(Globle().colorscode)
                          : orangetheme300,
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
                        fontFamily: Constants.getFontType(),
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

  isBillSplitedForUsers() {
    if (isInvited()) {
      if (myOrderData.splitbilltransactions != null) {
        var notAvialable = true;
        for (var transaction in myOrderData.splitbilltransactions) {
          if (transaction.userId == Globle().loginModel.data.id) {
            notAvialable = false;
          }
        }
        setState(() {
          isBillSplitedForUser = notAvialable;
        });
        return;
      }
    }
    if (isInvited() && isSplitAmount()) {
      setState(() {
        isBillSplitedForUser = true;
      });
    }
  }

  String getOrderTotal() {
    if (myOrderData.splitAmount != null) {
      return myOrderData.splitAmount;
    }

    return _model.grandTotal;
  }

  onSplitBillButtonTap() {
    if (_model.grandTotal != null) {
      if (double.parse(_model.grandTotal) < 10.00) {
        _showAlert(context, "Amount is too low for splitting bill", STR_BLANK,
            () {
          Navigator.of(context).pop();
        });
        return;
      }
    }
    invitationOrder.length > 0
        ? showSplitBill()
        : _showAlert(context, STR_ADD_PEOPLE_FIRST_SPLIT_BILL, STR_BLANK, () {
            Navigator.of(context).pop();
          });
  }

  showSplitBill() async {
    var data = await showDialog(
        context: context,
        child: new RadioDialog(
          amount: (double.parse(_model.grandTotal) + tipAmount),
          tableId: widget.tableId,
          orderId: widget.orderID,
          elementList: myOrderData.list,
        ));
    if (data != null) {
      if (data["isInvitePeople"] == true) {
        showInvitePeopleDialoag();
      }
      if (data["isSplitBill"] == true) {
        callApi();
      }
    }
  }

  getTableName() {
    if (myOrderData != null) {
      if (myOrderData.tableName != null) {
        return myOrderData.tableName;
      }
    }
    return;
  }

  showInvitePeopleDialoag() async {
    var data = await showDialog(
        context: context,
        barrierDismissible: false,
        child: InvitedPeopleDialog(
          orderID: widget.orderID,
          amount: (double.parse(_model.grandTotal) + tipAmount),
          tableId: widget.tableId,
        ));

    if (data != null) {
      if (data == true) {
        callApi();
      }
    }
  }

  callApi() async {
    await progressDialog.show();
    _paymentTipandPayDiPresenter.getOrderDetails(widget.orderID, context);
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
                              myOrderData.list[index].items.itemName != null
                                  ? StringUtils.capitalize(
                                      myOrderData.list[index].items.itemName)
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
                              myOrderData.list[index].items.itemDescription !=
                                      null
                                  ? StringUtils.capitalize(myOrderData
                                      .list[index].items.itemDescription)
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
                        padding: EdgeInsets.only(right: 10, top: 15),
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
                    : orangetheme300,
                inactiveColor: greytheme100,
                min: 1,
                max: 25,
                // divisions: 10,
                value: double.parse(sliderValue.toString()),
                onChanged: (newValue) {
                  setState(() {
                    sliderValue = newValue.round();
                    tipAmount =
                        (sliderValue * double.parse(getOrderTotal())) / 100;
                    print(tipAmount);
                    grandTotal = double.parse(getOrderTotal()) + tipAmount;
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
              '${sliderValue.toInt()}' + "%",
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
                              "${getSubtotalAmount()}"
                          : ""
                      : STR_ELEVEN_TITLE,
                  style: TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                ),
              ),
            ],
          ),
          isAmountSplit()
              ? SizedBox(
                  height: 13,
                )
              : Container(),
          isAmountSplit()
              ? Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        SPLIT_AMOUNT,
                        style: TextStyle(
                            fontSize: FONTSIZE_12, color: greytheme700),
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
                                    "${getSplitAmount()}"
                                : ""
                            : STR_ELEVEN_TITLE,
                        style: TextStyle(
                            fontSize: FONTSIZE_12, color: greytheme700),
                      ),
                    ),
                  ],
                )
              : Container(),
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
                child: Row(
                  children: <Widget>[
                    Text(
                      _model.currencySymbol != null
                          ? '${_model.currencySymbol} '
                          : "",
                      style:
                          TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                    ),
                    Text(
                      tipAmount != null
                          ? '${tipAmount.toStringAsFixed(2)}'
                          : "${getDefaultTipValue().toStringAsFixed(2)}",
                      style:
                          TextStyle(fontSize: FONTSIZE_12, color: greytheme700),
                    ),
                  ],
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
                      ? '${_model.currencySymbol} ' + doubleGrandTotal()
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

  String getSubtotalAmount() {
    double doubleSubTotal = double.parse(_model.grandTotal);
    String str = doubleSubTotal.toStringAsFixed(2);
    return str;
  }

  String getSplitAmount() {
    double doubleValue = double.parse(myOrderData.splitAmount);
    String str = doubleValue.toStringAsFixed(2);
    return str;
  }

  double getDefaultTipValue() {
    tipAmount = (tipDefaultValue * double.parse(getOrderTotal())) / 100;
    return tipAmount;
  }

  String doubleGrandTotal() {
    String strAmount = grandTotal.toStringAsFixed(2);
    return strAmount;
  }

  bool isAmountSplit() {
    if (myOrderData != null) {
      if (myOrderData.splitAmount != null) {
        tipAmount = (sliderValue * double.parse(myOrderData.splitAmount)) / 100;
        return true;
      }
    }
    return false;
  }

  void _showAlert(
      BuildContext context, String title, String message, Function onPressed) {
    showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(STR_OK),
                    onPressed: onPressed,
                  )
                ],
              ),
            ));
  }

  void showAlert(
      BuildContext context, String title, String message, Function onPressed) {
    showDialog(
        context: context,
        builder: (context) => WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text(title),
                content: Text(message),
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
                      fontFamily: Constants.getFontType(),
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
                        fontFamily: Constants.getFontType(),
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
                            fontFamily: Constants.getFontType(),
                            fontWeight: FontWeight.w600,
                            color: greytheme700)),
                    onPressed: () {
                      // Navigator.of(context).popUntil((route) => route.isFirst);
                      // Navigator.pushReplacementNamed(
                      //     context, STR_MAIN_WIDGET_PAGE);
                      Navigator.of(context).pop();

                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => MainWidget()),
                      //     ModalRoute.withName(STR_MAIN_WIDGET_PAGE));

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserFeedbackView(
                                    dateTime: myOrderData.createdAt,
                                    restId: myOrderData.restId,
                                  )),
                          ModalRoute.withName("/UserFeedbackView"));
                    },
                  )
                ],
              ),
            ));
  }

  @override
  void getOrderDetailsFailed() async {
    setState(() {
      isLoading = false;
    });
    await progressDialog.hide();
  }

  @override
  Future<void> getOrderDetailsSuccess(
      OrderDetailData orderData, OrderDetailsModel model) async {
    await progressDialog.hide();
    // await progressDialog.hide();

    setState(() {
      isLoading = false;
      myOrderData = orderData;
      _model = model;
      if (_model.data.invitation != null) {
        invitationOrder = _model.data.invitation;
      }
      isBillSplitedForUsers();
      // if (myOrderData.splitAmount != null) {
      //   grandTotal = double.parse(myOrderData.splitAmount);
      // } else {
      //   grandTotal = double.parse(model.grandTotal);
      // }
      if (myOrderData.splitAmount != null) {
        setState(() {
          // sliderValue = 10;
          double tipAmount =
              (sliderValue * double.parse(myOrderData.splitAmount)) / 100;
          print(tipAmount);
          grandTotal = double.parse(myOrderData.splitAmount) + tipAmount;
          print(grandTotal);
        });
      } else {
        setState(() {
          // sliderValue = 10;
          double tipAmount =
              (sliderValue * double.parse(model.grandTotal)) / 100;
          print(tipAmount);
          grandTotal = double.parse(model.grandTotal) + tipAmount;
          print(grandTotal);
        });
      }
    });

    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> payfinalBillFailed() async {
    setState(() {
      isIgnoreTouch = false;
    });
    await progressDialog.hide();
    // Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> payfinalBillSuccess() async {
    setState(() {
      isIgnoreTouch = false;
    });
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    Preference.setPersistData<int>(null, PreferenceKeys.orderId);
    Globle().orderID = 0;
    Preference.removeForKey(PreferenceKeys.orderId);
    Preference.setPersistData<int>(null, PreferenceKeys.tableId);
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
    await progressDialog.hide();
    showAlertSuccess(STR_PAYMENT_SUCCESS, STR_TRANSACTION_DONE, context);
  }

  @override
  Future<void> payBillCheckoutFailed() async {
    setState(() {
      isIgnoreTouch = false;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void payBillCheckoutSuccess(PaycheckoutNetbanking model) async {
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
      //Constants.showAlert(STR_FOODZI_TITLE, STR_PAYMENT_CANCELLED, context);
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
      _paymentTipandPayDiPresenter.onCancelledPayment(
          widget.orderID, "dine_in", context);
    }
  }

  @override
  Future<void> paymentCheckoutFailed() async {
    setState(() {
      isIgnoreTouch = false;
    });
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
      await progressDialog.show();
      //DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
      _finalBillPresenter.payfinalOrderBill(
          Globle().loginModel.data.id,
          myOrderData.restId,
          myOrderData.id,
          STR_CARD,
          getOrderTotal(),
          grandTotal.toString(),
          paymentCheckoutModel.transactionId,
          context,
          tipAmount.toString());
    } else {
      await progressDialog.hide();
      Constants.showAlert(STR_FOODZI_TITLE, STR_PAYMENT_FAILED, context);
      //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    }
  }

  @override
  Future<void> cancelledPaymentFailed() async {
    setState(() {
      isIgnoreTouch = false;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  Future<void> cancelledPaymentSuccess() async {
    setState(() {
      isIgnoreTouch = false;
    });
    await progressDialog.hide();
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    Constants.showAlert(STR_FOODZI_TITLE, STR_PAYMENT_CANCELLED, context);
  }

  @override
  void addPeopleFailed() {}

  @override
  void addPeopleSuccess() {}

  @override
  void getPeopleListonFailed() {}

  @override
  void getPeopleListonSuccess(List<PeopleData> data) {
    setState(() {
      addedPeopleList = data;
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  void onFailedQuantityIncrease() {}

  @override
  void onSuccessQuantityIncrease() {}

  @override
  void inviteRequestFailed(ErrorModel model) {}

  @override
  void inviteRequestSuccess(String message) {}
}

enum Invited { yes, no }
