import 'package:flutter/material.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';

class InvitedPeopleDialog extends StatefulWidget {
  int tableId;
  InvitedPeopleDialog({this.tableId});
  @override
  _InvitedPeopleDialogState createState() => _InvitedPeopleDialogState();
}

class _InvitedPeopleDialogState extends State<InvitedPeopleDialog>
    implements StatusTrackViewModelView {
  StatusTrackViewPresenter statusTrackViewPresenter;
  List<InvitePeopleList> invitedPeopleList = [];
  List<CheckBoxOptions> _checkBoxOptions = [];
  List<InvitePeople> invitedPeople;
  int index;

  @override
  void initState() {
    statusTrackViewPresenter = StatusTrackViewPresenter(this);
    statusTrackViewPresenter.getInvitedPeople(
        Globle().loginModel.data.id,
        //widget.tableId
        2,
        context);

    print("table id from invitedpeoplelist dialog--->");
    print(widget.tableId);
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
                    'Split Bill between Members',
                    style: TextStyle(
                        fontSize: 16,
                        color: greytheme700,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600),
                  ),
                ),
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
                                    invitedPeopleList[i].toUser.firstName ?? '',
                                    style: TextStyle(
                                        fontSize: 13,
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
                        if (invitedPeople.length > 0) {
                          print(invitedPeople[index].inviteId);
                          print(invitedPeople.length);
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
