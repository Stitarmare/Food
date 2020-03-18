import 'package:flutter/material.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/InvitedPeopleDialogSplitBill.dart';
import 'package:foodzi/widgets/OrdertemsDialogSplitBill.dart';

class BillList {
  String name;
  int index;
  BillList({this.name, this.index});
}

class RadioDialog extends StatefulWidget {
  int tableId;
  int orderId;
  List<ListElements> elementList;

  RadioDialog(
      {this.onValueChange,
      this.initialValue,
      this.tableId,
      this.orderId,
      this.elementList});

  final String initialValue;
  final void Function(String) onValueChange;

  @override
  State createState() => new RadioDialogState();
}

class RadioDialogState extends State<RadioDialog> {
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
                    // Navigator.pop(context);
                    if (id == 2) {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          child: InvitedPeopleDialog(
                            tableId: widget.tableId,
                          ));
                    } else if (id == 3) {
                      List<OrderDetailData> data = [];
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          child: OrderItemsDialog(
                            orderId: widget.orderId,
                            listElement: widget.elementList,
                          ));
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
}
