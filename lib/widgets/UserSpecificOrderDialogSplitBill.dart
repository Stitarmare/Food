import 'package:flutter/material.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/Models/payment_Checkout_model.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPayDine/PaymentTipAndPayDiPresenter.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';

class UserSpecificOrderDialog extends StatefulWidget {
  int tableId;
  int orderId;

  List<ListElements> listElement;

  UserSpecificOrderDialog({this.tableId, this.orderId, this.listElement});
  @override
  _UserSpecificOrderDialogState createState() =>
      _UserSpecificOrderDialogState();
}

class _UserSpecificOrderDialogState extends State<UserSpecificOrderDialog>
    implements StatusTrackViewModelView {
  List<InvitePeopleList> invitedPeopleList = [];
  List<CheckBoxOptions> _checkBoxOptions = [];
  List<CheckBoxOptions> _checkBoxOptionsInvitedPeople = [];

  List<ItemList> itemOrderList;
  int index;
  PaymentTipandPayDiPresenter _paymentTipandPayDiPresenter;
  StatusTrackViewPresenter statusTrackViewPresenter;

  List<ListElements> elementList = [];
  List<InvitePeople> invitedPeople;

  @override
  void initState() {
    checkboxbtn(widget.listElement.length);
    statusTrackViewPresenter = StatusTrackViewPresenter(this);
    statusTrackViewPresenter.getInvitedPeople(
        Globle().loginModel.data.id,
        //widget.tableId
        2,
        context);
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
            //  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    'Split Bill on User Specific Items',
                    style: TextStyle(
                        fontSize: 16,
                        color: greytheme700,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: _checkBoxOptions.length != 0
                        ? ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _checkBoxOptions.length,
                            itemBuilder: (BuildContext context, int i) {
                              index = i;
                              return Card(
                                  child: Column(
                                children: <Widget>[
                                  CheckboxListTile(
                                      activeColor: ((Globle().colorscode) !=
                                              null)
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
                                            ext.itemId =
                                                _checkBoxOptions[i].index;
                                            itemOrderList.add(ext);
                                          }
                                          _checkBoxOptions[i].isChecked = val;
                                        });
                                      },
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            _checkBoxOptions[i].title ?? '',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color.fromRGBO(
                                                    64, 64, 64, 1)),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Divider(
                                      color: greytheme100,
                                      height: 2,
                                      thickness: 0.5,
                                    ),
                                  ),
                                  _checkBoxOptionsInvitedPeople.length != 0
                                      ? ListView.builder(
                                          physics: ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              _checkBoxOptionsInvitedPeople
                                                  .length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return Column(
                                              children: <Widget>[
                                                Text("People for the Item"),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0),
                                                  child: CheckboxListTile(
                                                      activeColor: ((Globle()
                                                                  .colorscode) !=
                                                              null)
                                                          ? getColorByHex(
                                                              Globle()
                                                                  .colorscode)
                                                          : orangetheme,
                                                      value:
                                                          _checkBoxOptionsInvitedPeople[
                                                                  i]
                                                              .isChecked,
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      onChanged: (val) {
                                                        print(
                                                            _checkBoxOptionsInvitedPeople[
                                                                    i]
                                                                .index);
                                                        setState(() {
                                                          if (invitedPeople ==
                                                              null) {
                                                            invitedPeople = [];
                                                          }
                                                          if (invitedPeople
                                                                  .length >
                                                              0) {
                                                            if (val) {
                                                              var ext =
                                                                  InvitePeople();
                                                              ext.inviteId =
                                                                  _checkBoxOptionsInvitedPeople[
                                                                          i]
                                                                      .index;
                                                              invitedPeople
                                                                  .add(ext);
                                                            } else {
                                                              for (int i = 0;
                                                                  i <
                                                                      invitedPeople
                                                                          .length;
                                                                  i++) {
                                                                if (_checkBoxOptions[
                                                                            i]
                                                                        .index ==
                                                                    invitedPeople[
                                                                            i]
                                                                        .inviteId) {
                                                                  invitedPeople
                                                                      .removeAt(
                                                                          i);
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            var ext =
                                                                InvitePeople();
                                                            ext.inviteId =
                                                                _checkBoxOptions[
                                                                        i]
                                                                    .index;
                                                            invitedPeople
                                                                .add(ext);
                                                          }
                                                          _checkBoxOptionsInvitedPeople[
                                                                  i]
                                                              .isChecked = val;
                                                        });
                                                      },
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            _checkBoxOptionsInvitedPeople[
                                                                        i]
                                                                    .title ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        64,
                                                                        64,
                                                                        64,
                                                                        1)),
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ],
                                            );
                                          })
                                      : Container()
                                ],
                              ));
                            })
                        : Container(child: Text(""))),
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
                          // side: BorderSide(
                          //     color: Color.fromRGBO(170, 170, 170, 1)),
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    )),
                    SizedBox(width: 10),
                    Center(
                        child: RaisedButton(
                      color: getColorByHex(Globle().colorscode),
                      shape: RoundedRectangleBorder(
                          // side: BorderSide(
                          //     color: Color.fromRGBO(170, 170, 170, 1)),
                          borderRadius: BorderRadius.circular(8)),
                      onPressed: () async {
                        if (itemOrderList.length > 0) {
                          print(itemOrderList[index].itemId);
                          print(itemOrderList.length);
                        } else {
                          print("length not found");
                        }
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
  }

  int checkBoxbtnInvitedPeople(int length) {
    List<CheckBoxOptions> _checkboxlist = [];
    for (int i = 1; i <= length; i++) {
      _checkboxlist.add(CheckBoxOptions(
        isChecked: false,
        index: invitedPeopleList[i - 1].id,
        title: invitedPeopleList[i - 1].toUser.firstName ?? '',
      ));
    }
    setState(() {
      _checkBoxOptionsInvitedPeople = _checkboxlist;
    });
  }

  @override
  void getInvitedPeopleFailed() {}

  @override
  void getInvitedPeopleSuccess(List<InvitePeopleList> list) {
    if (list.length == 0) {
      return;
    }
    setState(() {
      if (invitedPeopleList == null) {
        invitedPeopleList = list;
        checkBoxbtnInvitedPeople(invitedPeopleList.length);
      } else {
        invitedPeopleList.addAll(list);
        checkBoxbtnInvitedPeople(invitedPeopleList.length);
      }
    });
  }

  @override
  void getOrderStatusfailed() {
    // TODO: implement getOrderStatusfailed
  }

  @override
  void getOrderStatussuccess(StatusData statusData) {
    // TODO: implement getOrderStatussuccess
  }
}

class ItemList {
  int itemId;

  ItemList({
    this.itemId,
  });

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        itemId: json["invite_id"],
      );

  Map<String, dynamic> toJson() => {
        "invite_id": itemId,
      };
}

class InvitePeople {
  int inviteId;

  InvitePeople({
    this.inviteId,
  });

  factory InvitePeople.fromJson(Map<String, dynamic> json) => InvitePeople(
        inviteId: json["invite_id"],
      );

  Map<String, dynamic> toJson() => {
        "invite_id": inviteId,
      };
}

class CheckBoxOptions {
  int index;
  String title; // double price;
  bool isChecked;
  CheckBoxOptions({this.index, this.title, this.isChecked});
}
