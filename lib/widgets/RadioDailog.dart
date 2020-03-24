import 'package:flutter/material.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/SplitBillPage/SplitBillContractor.dart';
import 'package:foodzi/SplitBillPage/SplitBillPresenter.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/InvitedPeopleDialogSplitBill.dart';
import 'package:foodzi/widgets/OrdertemsDialogSplitBill.dart';
import 'package:foodzi/widgets/UserSpecificOrderDialogSplitBill.dart';

class RadioDialog extends StatefulWidget {
  int tableId;
  int orderId;
  double amount;
  List<ListElements> elementList;

  RadioDialog(
      {this.onValueChange,
      this.initialValue,
      this.tableId,
      this.orderId,
      this.amount,
      this.elementList});

  final String initialValue;
  final void Function(String) onValueChange;

  @override
  State createState() => new RadioDialogState();
}

class RadioDialogState extends State<RadioDialog>
    implements SplitBillContractorModelView {
  SplitBillPresenter _splitBillPresenter;

  String _selectedId;
  // Default Radio Button Item
  String radioItem = 'Mango';

  // Group Value for Radio Button.
  int id = 1;

  List<BillList> bList = [
    BillList(
      index: 1,
      name: "Split equally among all",
    ),
    BillList(
      index: 2,
      name: "Split between certain members by clicking the checkbox",
    ),
    BillList(
      index: 3,
      name: "Split based on order items",
    ),
    BillList(
      index: 4,
      name: "Split for order made from user specific order items ",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _splitBillPresenter = SplitBillPresenter(this);

    _selectedId = widget.initialValue;

    print("table id from split bill dialog--->");
    print(widget.tableId);
  }

  Widget build(BuildContext context) {
    return new SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      children: <Widget>[
        Container(
            height: 350,
            width: 284,
            //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Text(
                    'Split Bill',
                    style: TextStyle(
                        fontSize: 16,
                        color: greytheme700,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Column(
                  children: bList
                      .map((data) => RadioListTile(
                            title: Text(
                              data.name,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: greytheme700,
                                  fontFamily: 'gotham'),
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
                      // side: BorderSide(
                      //     color: Color.fromRGBO(170, 170, 170, 1)),
                      borderRadius: BorderRadius.circular(5)),
                  onPressed: () {
                    if (id == 1) {
                      _splitBillPresenter.getSPlitBill(
                          widget.orderId,
                          Globle().loginModel.data.id,
                          1,
                          widget.amount.toInt(),
                          context);
                    }
                    // Navigator.pop(context);
                    else if (id == 2) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          child: InvitedPeopleDialog(
                            orderID: widget.orderId,
                            amount: widget.amount,
                            tableId: widget.tableId,
                          ));
                    } else if (id == 3) {
                      _splitBillPresenter.getSPlitBill(
                          widget.orderId,
                          Globle().loginModel.data.id,
                          3,
                          widget.amount.toInt(),
                          context);
                      //  List<OrderDetailData> data = [];
                      // showDialog(
                      //     context: context,
                      //     barrierDismissible: false,
                      //     child: OrderItemsDialog(
                      //       orderId: widget.orderId,
                      //       listElement: widget.elementList,
                      //     ));
                    } else if (id == 4) {
                      _splitBillPresenter.getSPlitBill(
                          widget.orderId,
                          Globle().loginModel.data.id,
                          4,
                          widget.amount.toInt(),
                          context);

                      // showDialog(
                      //     context: context,
                      //     barrierDismissible: false,
                      //     child: UserSpecificOrderDialog(
                      //       orderId: widget.orderId,
                      //       listElement: widget.elementList,
                      //       tableId: widget.tableId,
                      //     ));
                    }
                  },
                  child: Text(
                    'CONFIRM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ))
              ],
            ))
      ],
    );
  }

  @override
  void getSplitBillFailed() {
    // TODO: implement getSplitBillFailed
  }

  @override
  void getSplitBillSuccess() {
    // TODO: implement getSplitBillSuccess
  }
}

class BillList {
  String name;
  int index;
  BillList({this.name, this.index});
}
