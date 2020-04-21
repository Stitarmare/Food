import 'package:flutter/material.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/SplitBillPage/SplitBillContractor.dart';
import 'package:foodzi/SplitBillPage/SplitBillPresenter.dart';
import 'package:foodzi/SplitBllNotification/SplitBillContractor.dart';
import 'package:foodzi/SplitBllNotification/SplitBillNotificationPresenter.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:progress_dialog/progress_dialog.dart';

class InvitedPeopleDialog extends StatefulWidget {
  int tableId;
  double amount;
  int orderID;
  InvitedPeopleDialog({this.tableId, this.amount, this.orderID});
  @override
  _InvitedPeopleDialogState createState() => _InvitedPeopleDialogState();
}

class _InvitedPeopleDialogState extends State<InvitedPeopleDialog>
    implements
        StatusTrackViewModelView,
        SplitBillContractorModelView,
        SplitBillNotificationContractorModelView {
  StatusTrackViewPresenter statusTrackViewPresenter;
  List<InvitePeopleList> invitedPeopleList = [];
  List<CheckBoxOptions> _checkBoxOptions = [];
  List<InvitePeople> invitedPeople;
  int index;

  SplitBillPresenter _billPresenter;
  SplitBillNotificationPresenter _splitBillNotificationPresenter;
  ProgressDialog progressDialog;

  @override
  void initState() {
    _billPresenter = SplitBillPresenter(this);
    statusTrackViewPresenter = StatusTrackViewPresenter(this);
    _splitBillNotificationPresenter = SplitBillNotificationPresenter(this);
    statusTrackViewPresenter.getInvitedPeople(
        Globle().loginModel.data.id, widget.tableId, context);

    print(widget.tableId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: STR_LOADING);
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
                    STR_SPLIT_BILL_BTWN,
                    style: TextStyle(
                        fontSize: FONTSIZE_16,
                        color: greytheme700,
                        fontFamily: KEY_FONTFAMILY,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 10),
                Text("${widget.amount}"),
                Expanded(
                    flex: 4,
                    child: ListView.builder(
                        itemCount: _checkBoxOptions.length,
                        itemBuilder: (BuildContext context, int i) {
                          index = i;
                          return CheckboxListTile(
                              activeColor: ((Globle().colorscode) != null)
                                  ? getColorByHex(Globle().colorscode)
                                  : orangetheme,
                              value: _checkBoxOptions[i].isChecked,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (val) {
                                setState(() {
                                  if (invitedPeople == null) {
                                    invitedPeople = [];
                                  }
                                  if (invitedPeople.length > 0) {
                                    if (val) {
                                      var ext = InvitePeople();
                                      ext.inviteId = _checkBoxOptions[i].index;
                                      invitedPeople.add(ext);
                                    } else {
                                      for (int i = 0;
                                          i < invitedPeople.length;
                                          i++) {
                                        if (_checkBoxOptions[i].index ==
                                            invitedPeople[i].inviteId) {
                                          invitedPeople.removeAt(i);
                                        }
                                      }
                                    }
                                  } else {
                                    var ext = InvitePeople();
                                    ext.inviteId = _checkBoxOptions[i].index;
                                    invitedPeople.add(ext);
                                  }
                                  _checkBoxOptions[i].isChecked = val;
                                });
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    invitedPeopleList[i].toUser.firstName ??
                                        STR_BLANK,
                                    style: TextStyle(
                                        fontSize: FONTSIZE_13,
                                        color: Color.fromRGBO(64, 64, 64, 1)),
                                  ),
                                ],
                              ));
                        })),
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
                      onPressed: (){
                        if (invitedPeople.length > 0) {
                          print(invitedPeople[index].inviteId);
                          print(invitedPeople.length);
                        } else {
                          print(invitedPeople[index].inviteId);
                        }
                      },
                      child: Text(
                        STR_OK,
                        style: TextStyle(
                            color: Colors.white, fontSize: FONTSIZE_18),
                      ),
                    )),
                  ],
                ),
              ],
            ))
      ],
    );
  }

  callApi() async{
    List<String> users = [];
    if (_checkBoxOptions.length > 0) {
      for (var check in _checkBoxOptions) {
          if (check.isChecked == true) {
            users.add(check.index.toString());
          }
      }
    }
    await progressDialog.show();
    _billPresenter.getSPlitBill(
                            widget.orderID,
                            Globle().loginModel.data.id,
                            2,
                            widget.amount.toInt(),
                            context,
                            users: users);
  }

  int checkboxbtn(int length) {
    List<CheckBoxOptions> _checkboxlist = [];
    for (int i = 1; i <= length; i++) {
      _checkboxlist.add(CheckBoxOptions(
        isChecked: true,
        index: invitedPeopleList[i - 1].id,
        title: invitedPeopleList[i - 1].toUser.firstName ?? '',
      ));

      if (invitedPeople == null) {
        invitedPeople = [];
        var inv = InvitePeople();
        inv.inviteId = invitedPeopleList[i - 1].id;
        invitedPeople.add(inv);
      }
    }
    setState(() {
      _checkBoxOptions = _checkboxlist;
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
        checkboxbtn(invitedPeopleList.length);
      } else {
        invitedPeopleList.addAll(list);
        checkboxbtn(invitedPeopleList.length);
      }
    });
  }

  @override
  void getOrderStatusfailed() {}

  @override
  void getOrderStatussuccess(StatusData statusData) {}

  @override
  void getSplitBillFailed() async{
    await progressDialog.hide();
    Navigator.of(context).pop(false);
  }

  @override
  void getSplitBillSuccess() async{
    await progressDialog.hide();
    Navigator.of(context).pop(true);
  }

  @override
  void getSplitBillNotificationFailed() {
    // TODO: implement getSplitBillNotificationFailed
  }

  @override
  void getSplitBillNotificationSuccess() {
    // TODO: implement getSplitBillNotificationSuccess
  }
}

class InvitePeople {
  int inviteId;

  InvitePeople({
    this.inviteId,
  });

  factory InvitePeople.fromJson(Map<String, dynamic> json) => InvitePeople(
        inviteId: json[STR_INVITE_ID],
      );

  Map<String, dynamic> toJson() => {
        STR_INVITE_ID: inviteId,
      };
}

class CheckBoxOptions {
  int index;
  String title;
  bool isChecked;
  CheckBoxOptions({this.index, this.title, this.isChecked});
}
