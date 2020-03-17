import 'package:flutter/material.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineViewContractor.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineviewPresenter.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:toast/toast.dart';

class AddPeople {
  String name;
  int index;
  bool isChecked;
  AddPeople({this.name, this.index, this.isChecked});
}

class RadioDialogAddPeople extends StatefulWidget {
  // final List<Data> data;
  final int tableId;
  final int orderId;
  final int restId;

  // const RadioDialogAddPeople(
  //     {this.onValueChange,
  //     this.initialValue,
  //   });

  const RadioDialogAddPeople(this.tableId, this.restId, this.orderId);

  // final String initialValue;
  // final void Function(String) onValueChange;

  @override
  State createState() => new RadioDialogAddPeopleState();
}

class RadioDialogAddPeopleState extends State<RadioDialogAddPeople>
    implements ConfirmationDineViewModelView, StatusTrackViewModelView {
  String _selectedId;
  // Default Radio Button Item
  String radioItem = 'Mango';
  List<Data> addList = [];
  AddPeopleInterface addPeopleInterface;
  List<CheckBoxOptions> _checkBoxOptions = [];
  List<InvitePeople> invitedPeople;
  List<Data> peopleList = [];

  // Group Value for Radio Button.
  int id;
  bool isChecked = false;
  List<InvitePeopleList> invitePeopleList = [];

  // bool isChecked = false;
  String _currText = "";
  ConfirmationDineviewPresenter confirmationDineviewPresenter;
  StatusTrackViewPresenter statusTrackViewPresenter;

  @override
  void initState() {
    super.initState();

    // confirmationDineviewPresenter = ConfirmationDineviewPresenter(this);
    confirmationDineviewPresenter = ConfirmationDineviewPresenter(this);
    statusTrackViewPresenter = StatusTrackViewPresenter(this);

    confirmationDineviewPresenter.getPeopleList(context);
    // _selectedId = widget.initialValue;
    print("addpeople list length-->");
    // print(widget.data.length);

    statusTrackViewPresenter.getInvitedPeople(
        Globle().loginModel.data.id, 2, context);
  }

  Widget build(BuildContext context) {
    return new SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      children: <Widget>[
        Container(
            height: 500,
            width: 284,
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
                    'Add People',
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
                          id = i;
                          return CheckboxListTile(
                              activeColor: ((Globle().colorscode) != null)
                                  ? getColorByHex(Globle().colorscode)
                                  : orangetheme,
                              value: _checkBoxOptions[i].isChecked,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (val) {
                                // setState(() {
                                //   bList[i].isChecked = val;
                                //   if (val != false) {
                                //     addList.add(bList[i]);
                                //   } else {
                                //     addList.remove(bList[i]);
                                //   }
                                // });

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
                              //   setState(() {
                              //     isChecked = val;
                              //     id = i;
                              //     if (val != false) {
                              //       addList.add(widget.data[i]);
                              //     } else {
                              //       addList.remove(widget.data[i]);
                              //     }
                              //   });
                              // },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    peopleList[i].firstName ?? '',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromRGBO(64, 64, 64, 1)),
                                  ),
                                ],
                              ));
                          // ? _checkBoxOptions
                          //     .map((checkBtn) =>
                          //         )
                          //     .toList()
                        })),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: RaisedButton(
                  color: getColorByHex(Globle().colorscode),
                  shape: RoundedRectangleBorder(
                      // side: BorderSide(
                      //     color: Color.fromRGBO(170, 170, 170, 1)),
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () async {
                    int orderId = await Preference.getPrefValue<int>(
                        PreferenceKeys.ORDER_ID);
                    confirmationDineviewPresenter.addPeople(
                        peopleList[id].mobileNumber,
                        widget.tableId,
                        widget.restId,
                        orderId,
                        context);
                    Navigator.pop(context);
                    Toast.show(
                        "Sending Invitation to ${peopleList[id].firstName}...",
                        context,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.BOTTOM);
                    showAddPeopleAlertSuccess("Invitation Send",
                        "Invitation has been send Successfully!!", context);
                    print("Added people-->");
                    print(addList.length);
                  },
                  child: Text(
                    addList.length != 0
                        ? 'Add ${addList.length} People'
                        : 'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Joined people:",
                    style: TextStyle(
                        color: greytheme100,
                        decoration: TextDecoration.underline,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: invitePeopleList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${index + 1}) " +
                                "${invitePeopleList[index].toUser.firstName}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: greytheme100,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
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
        index: peopleList[i - 1].id,
        title: peopleList[i - 1].firstName ?? '',
      ));
    }
    setState(() {
      _checkBoxOptions = _checkboxlist;
    });
  }

  void showAddPeopleAlertSuccess(
      String title, String message, BuildContext context) {
    showDialog(
      barrierDismissible: false,
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
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void addPeopleFailed() {
    // TODO: implement addPeopleFailed
  }

  @override
  void addPeopleSuccess() {
    // TODO: implement addPeopleSuccess
  }

  @override
  void getPeopleListonFailed() {}

  @override
  void getPeopleListonSuccess(List<Data> data) {
    if (data.length == 0) {
      return;
    }
    setState(() {
      if (peopleList == null) {
        peopleList = data;
      } else {
        peopleList.addAll(data);
      }
    });
    print(peopleList[0].mobileNumber.runtimeType);
    checkboxbtn(data.length);
  }

  @override
  void getInvitedPeopleFailed() {}

  @override
  void getOrderStatusfailed() {}

  @override
  void getOrderStatussuccess(StatusData statusData) {}

  @override
  void getInvitedPeopleSuccess(List<InvitePeopleList> list) {
    setState(() {
      invitePeopleList = list;
    });

    print("invite peopl list length-->");
    print(invitePeopleList.length);
    print(invitePeopleList[0].toUser.firstName);
  }
}

abstract class AddPeopleInterface {
  void getAddedpeople(List<AddPeople> list);
}

class CheckBoxOptions {
  int index;
  String title; // double price;
  bool isChecked;
  CheckBoxOptions({this.index, this.title, this.isChecked});
}
