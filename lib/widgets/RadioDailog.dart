import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/SplitBillPage/SplitBillContractor.dart';
import 'package:foodzi/SplitBillPage/SplitBillPresenter.dart';
import 'package:foodzi/SplitBllNotification/SplitBillContractor.dart';
import 'package:foodzi/SplitBllNotification/SplitBillNotificationPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/InvitedPeopleDialogSplitBill.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RadioDialog extends StatefulWidget {
  int tableId;
  int orderId;
  double amount;
  int userId;
  List<ListElements> elementList;

  RadioDialog(
      {this.onValueChange,
      this.initialValue,
      this.tableId,
      this.orderId,
      this.amount,
      this.userId,
      this.elementList});

  final String initialValue;
  final void Function(String) onValueChange;

  @override
  State createState() => new RadioDialogState();
}

class RadioDialogState extends State<RadioDialog>
    with TickerProviderStateMixin
    implements
        SplitBillContractorModelView,
        SplitBillNotificationContractorModelView {
  SplitBillPresenter _splitBillPresenter;
  SplitBillNotificationPresenter _splitBillNotificationPresenter;
  String radioItem = STR_MANGO;
  int id = 1;
  List<BillList> bList = [
    BillList(
      index: 1,
      name: STR_SPLIT_BILL_AMONG_ALL,
    ),
    BillList(
      index: 2,
      name: STR_SPLIT_BILL_CERTAIN_MEMB,
    ),
    // BillList(
    //   index: 3,
    //   name: STR_SPLIT_BILL_ORDER_ITEMS,
    // ),
    BillList(
      index: 4,
      name: STR_SPLIT_BILL_USER_SPECIFIC,
    ),
  ];
  ProgressDialog progressDialog;
  bool isLoader = false;

  @override
  void initState() {
    super.initState();
    _splitBillPresenter = SplitBillPresenter(this);
    _splitBillNotificationPresenter = SplitBillNotificationPresenter(this);
  }

  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: STR_LOADING);
    return new SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      children: <Widget>[
        Stack(alignment: Alignment.center, children: <Widget>[
          Container(
              height: 350,
              width: 284,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Text(
                      STR_SPLIT_BILL,
                      style: TextStyle(
                          fontSize: FONTSIZE_16,
                          color: greytheme700,
                          fontFamily: Constants.getFontType(),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Column(
                    children: bList
                        .map((data) => RadioListTile(
                              title: Text(
                                data.name,
                                style: TextStyle(
                                    fontSize: FONTSIZE_15,
                                    color: greytheme700,
                                    fontFamily: Constants.getFontType()),
                              ),
                              groupValue: id,
                              value: data.index,
                              activeColor: redtheme,
                              onChanged: (val) {
                                setState(() {
                                  radioItem = data.name;
                                  id = data.index;
                                });
                              },
                            ))
                        .toList(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                      child: RaisedButton(
                    color: redtheme,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {
                      onConfirmTap();
                    },
                    child: Text(
                      STR_CONFIRM,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FONTSIZE_18,
                      ),
                    ),
                  ))
                ],
              )),
          isLoader
              ? SpinKitFadingCircle(
                  color: Globle().colorscode != null
                      ? getColorByHex(Globle().colorscode)
                      : orangetheme300,
                  size: 50.0,
                  controller: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 1200)),
                )
              : Text("")
        ])
      ],
    );
  }

  onConfirmTap() async {
    if (id == 1) {
      // await progressDialog.show();
      setState(() {
        isLoader = true;
      });
      // _splitBillPresenter.getSPlitBill(widget.orderId,
      //     Globle().loginModel.data.id, 1, widget.amount.toInt(), context);

      _splitBillPresenter.getSPlitBill(
          widget.orderId, widget.userId, 1, widget.amount.toInt(), context);

      // _splitBillNotificationPresenter.getSPlitBillNotification(
      //     widget.orderId,
      //     Globle().loginModel.data.id,
      //     1,
      //     widget.amount.toInt(),
      //     context);
    } else if (id == 2) {
      Navigator.of(context).pop({"isInvitePeople": true});
    } else if (id == 3) {
      // await progressDialog.show();
      setState(() {
        isLoader = true;
      });
      // _splitBillPresenter.getSPlitBill(widget.orderId,
      //     Globle().loginModel.data.id, 3, widget.amount.toInt(), context);

      _splitBillPresenter.getSPlitBill(
          widget.orderId, widget.userId, 3, widget.amount.toInt(), context);
    } else if (id == 4) {
      // await progressDialog.show();
      setState(() {
        isLoader = true;
      });
      // _splitBillPresenter.getSPlitBill(widget.orderId,
      //     Globle().loginModel.data.id, 3, widget.amount.toInt(), context);

      _splitBillPresenter.getSPlitBill(
          widget.orderId, widget.userId, 3, widget.amount.toInt(), context);
    }
  }

  @override
  void getSplitBillFailed() async {
    // await progressDialog.hide();
    setState(() {
      isLoader = false;
    });
    Navigator.of(context).pop({"isSplitBill": false});
  }

  @override
  void getSplitBillSuccess() async {
    // await progressDialog.hide();
    setState(() {
      isLoader = false;
    });
    Navigator.of(context).pop({"isSplitBill": true});
  }

  @override
  void getSplitBillNotificationFailed() {
    setState(() {
      isLoader = false;
    });
  }

  @override
  void getSplitBillNotificationSuccess() {
    // TODO: implement getSplitBillNotificationSuccess
    setState(() {
      isLoader = false;
    });
  }
}

class BillList {
  String name;
  int index;
  BillList({this.name, this.index});
}
