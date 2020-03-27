import 'package:flutter/material.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';

class OrderItemsDialog extends StatefulWidget {
  int tableId;
  int orderId;

  List<ListElements> listElement;

  OrderItemsDialog({this.tableId, this.orderId, this.listElement});
  @override
  _OrderItemsDialogState createState() => _OrderItemsDialogState();
}

class _OrderItemsDialogState extends State<OrderItemsDialog> {
  List<InvitePeopleList> invitedPeopleList = [];
  List<CheckBoxOptions> _checkBoxOptions = [];
  List<ItemList> itemOrderList;
  int index;
  List<ListElements> elementList = [];

  @override
  void initState() {
    checkboxbtn(widget.listElement.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      children: <Widget>[
        Container(
            height: 350,
            width: 200,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    STR_SPLIT_BILL_ON_ORDER,
                    style: TextStyle(
                        fontSize: FONTSIZE_16,
                        color: greytheme700,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: _checkBoxOptions.length != 0
                        ? ListView.builder(
                            itemCount: _checkBoxOptions.length,
                            itemBuilder: (BuildContext context, int i) {
                              index = i;
                              return CheckboxListTile(
                                  activeColor: ((Globle().colorscode) != null)
                                      ? getColorByHex(Globle().colorscode)
                                      : orangetheme,
                                  value: _checkBoxOptions[i].isChecked,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (val) {
                                    setState(() {
                                      if (itemOrderList == null) {
                                        itemOrderList = [];
                                      }
                                      if (itemOrderList.length > 0) {
                                        if (val) {
                                          var ext = ItemList();
                                          ext.itemId =
                                              _checkBoxOptions[i].index;
                                          itemOrderList.add(ext);
                                        } else {
                                          for (int i = 0;
                                              i < itemOrderList.length;
                                              i++) {
                                            if (_checkBoxOptions[i].index ==
                                                itemOrderList[i].itemId) {
                                              itemOrderList.removeAt(i);
                                            }
                                          }
                                        }
                                      } else {
                                        var ext = ItemList();
                                        ext.itemId = _checkBoxOptions[i].index;
                                        itemOrderList.add(ext);
                                      }
                                      _checkBoxOptions[i].isChecked = val;
                                    });
                                  },
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        _checkBoxOptions[i].title ?? STR_BLANK,
                                        style: TextStyle(
                                            fontSize: FONTSIZE_13,
                                            color:
                                                Color.fromRGBO(64, 64, 64, 1)),
                                      ),
                                    ],
                                  ));
                            })
                        : Container(child: Text(STR_BLANK))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                        child: RaisedButton(
                      color: getColorByHex(Globle().colorscode),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        STR_CANCEL_TITLE,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FONTSIZE_18,
                        ),
                      ),
                    )),
                    SizedBox(width: 10),
                    Center(
                        child: RaisedButton(
                      color: getColorByHex(Globle().colorscode),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () async {
                        if (itemOrderList.length > 0) {
                          print(itemOrderList[index].itemId);
                          print(itemOrderList.length);
                        } else {}
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FONTSIZE_18,
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ))
      ],
    );
  }

  int checkboxbtn(int length) {
    List<CheckBoxOptions> _checkboxlist = [];
    for (int i = 1; i <= length; i++) {
      _checkboxlist.add(CheckBoxOptions(
        isChecked: false,
        index: widget.listElement[i - 1].items.id,
        title: widget.listElement[i - 1].items.itemName ?? '',
      ));
    }
    setState(() {
      _checkBoxOptions = _checkboxlist;
    });

    return _checkboxlist.length;
  }
}

class ItemList {
  int itemId;

  ItemList({
    this.itemId,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        itemId: json[STR_INVITE_ID],
      );

  Map<String, dynamic> toJson() => {
        STR_INVITE_ID: itemId,
      };
}

class CheckBoxOptions {
  int index;
  String title; // double price;
  bool isChecked;
  CheckBoxOptions({this.index, this.title, this.isChecked});
}
