import 'package:flutter/material.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineViewContractor.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineviewPresenter.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/dialogs.dart';
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
  final int tableId;
  final int orderId;
  final int restId;
  const RadioDialogAddPeople(this.tableId, this.restId, this.orderId);

  @override
  State createState() => new RadioDialogAddPeopleState();
}

class RadioDialogAddPeopleState extends State<RadioDialogAddPeople>
    implements ConfirmationDineViewModelView, StatusTrackViewModelView {
  String radioItem = STR_MANGO;
  List<PeopleData> addList = [];
  AddPeopleInterface addPeopleInterface;
  List<CheckBoxOptions> _checkBoxOptions = [];
  List<InvitePeople> invitedPeople;
  List<PeopleData> peopleList = [];
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  int id;
  bool isChecked = false;
  List<InvitePeopleList> invitePeopleList = [];
  ConfirmationDineviewPresenter confirmationDineviewPresenter;
  StatusTrackViewPresenter statusTrackViewPresenter;

  static List<String> listCommon = [];
  static List<String> listStrCommon = [];
  static List<AddPeopleList> addPeopleList;

  @override
  void initState() {
    super.initState();
    confirmationDineviewPresenter = ConfirmationDineviewPresenter(this);
    statusTrackViewPresenter = StatusTrackViewPresenter(this);
    DialogsIndicator.showLoadingDialog(context, _keyLoader, STR_LOADING);
    confirmationDineviewPresenter.getPeopleList(context);
    statusTrackViewPresenter.getInvitedPeople(
        Globle().loginModel.data.id, widget.tableId, context);

    print(widget.tableId);
  }

  Widget build(BuildContext context) {
    if ((getPeopleListLength() == 0)) {
      return SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        children: <Widget>[
          Container(
            height: 500,
            width: 284,
            child: SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      );
    } else {
      return new SimpleDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        children: <Widget>[
          Container(
              height: 500,
              width: 284,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      STR_ADD_PEOPLE,
                      style: TextStyle(
                          fontSize: FONTSIZE_16,
                          color: greytheme700,
                          fontFamily: KEY_FONTFAMILY,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: ListView.builder(
                          itemCount: getPeopleListLength(),
                          itemBuilder: (BuildContext context, int i) {
                            id = i;

                            return CheckboxListTile(
                                activeColor: ((Globle().colorscode) != null)
                                    ? getColorByHex(Globle().colorscode)
                                    : orangetheme,
                                value: _checkBoxOptions[i].isChecked,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  setState(() {
                                    if (addPeopleList == null) {
                                      addPeopleList = [];
                                    }
                                    if (addPeopleList.length > 0) {
                                      if (val) {
                                        var ext = AddPeopleList();
                                        ext.addPeopleId =
                                            _checkBoxOptions[i].index;
                                        addPeopleList.add(ext);
                                      } else {
                                        for (int i = 0;
                                            i < addPeopleList.length;
                                            i++) {
                                          if (_checkBoxOptions[i].index ==
                                              addPeopleList[i].addPeopleId) {
                                            addPeopleList.removeAt(i);
                                          }
                                        }
                                      }
                                    } else {
                                      var ext = AddPeopleList();
                                      ext.addPeopleId =
                                          _checkBoxOptions[i].index;
                                      addPeopleList.add(ext);
                                    }
                                    _checkBoxOptions[i].isChecked = val;
                                  });
                                },
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      peopleList[i].firstName ?? STR_BLANK,
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
                  Center(
                      child: RaisedButton(
                    color: getColorByHex(Globle().colorscode),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () async {
                      int orderId = await Preference.getPrefValue<int>(
                          PreferenceKeys.orderId);

                      print(_checkBoxOptions);
                      String numbers = STR_BLANK;
                      if (_checkBoxOptions.length > 0) {
                        for (int i = 0; i < _checkBoxOptions.length; i++) {
                          if (_checkBoxOptions[i].isChecked == true) {
                            numbers += "${peopleList[i].mobileNumber},";
                          }
                        }
                      }
                      if (numbers.isNotEmpty) {
                        numbers = removeLastChars(numbers);
                        print(numbers);
                      }

                      if (numbers.isNotEmpty) {
                        confirmationDineviewPresenter.addPeople(
                            peopleList[id].mobileNumber,
                            widget.tableId,
                            widget.restId,
                            orderId,
                            context);
                        Navigator.pop(context);
                        Toast.show(
                            STR_SENDING_INVITATION +
                                "${peopleList[id].firstName}...",
                            context,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.BOTTOM);
                        showAddPeopleAlertSuccess(STR_INVITATION_SEND,
                            STR_INVITATION_SUCCESS, context);
                      }
                    },
                    child: Text(
                      addList.length != 0
                          ? STR_ADD_TITLE + '${addList.length} ' + STR_PEOPLE
                          : STR_ADD_TITLE,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FONTSIZE_18,
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      STR_JOINED_PEOPLE,
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
                          children: <Widget>[
                            Text(
                              "${index + 1}) " +
                                  "${invitePeopleList[index].toUser.firstName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: greytheme100,
                                fontSize: FONTSIZE_18,
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
  }

  static String removeLastChars(String str) {
    return str.substring(0, str.length - 1);
  }

  int getPeopleListLength() {
    if (_checkBoxOptions.length == 0) {
      return 0;
    }
    return _checkBoxOptions.length;
  }

  int checkboxbtn(int length) {
    List<CheckBoxOptions> _checkboxlist = [];
    for (int i = 1; i <= length; i++) {
      _checkboxlist.add(CheckBoxOptions(
        isChecked: false,
        index: peopleList[i - 1].id,
        title: peopleList[i - 1].firstName ?? STR_BLANK,
      ));
    }
    setState(() {
      _checkBoxOptions = _checkboxlist;
    });

    return _checkboxlist.length;
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
                fontFamily: KEY_FONTFAMILY,
                fontWeight: FontWeight.w600,
                color: greytheme700),
          ),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                  fontFamily: KEY_FONTFAMILY,
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
                      fontFamily: KEY_FONTFAMILY,
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
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void addPeopleSuccess() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void getPeopleListonFailed() {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void getPeopleListonSuccess(List<PeopleData> data) {
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
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void getInvitedPeopleFailed() {}

  @override
  void getOrderStatusfailed() {}

  @override
  void getOrderStatussuccess(StatusData statusData) {}

  @override
  void getInvitedPeopleSuccess(List<InvitePeopleList> list) {
    if (list.length == 0) {
      return;
    }

    setState(() {
      if (invitePeopleList == null) {
        invitePeopleList = list;
      } else {
        invitePeopleList.addAll(list);
      }
    });
    print(invitePeopleList.length);
    print(invitePeopleList[0].toUser.firstName);
  }
}

abstract class AddPeopleInterface {
  void getAddedpeople(List<AddPeople> list);
}

class CheckBoxOptions {
  int index;
  String title;
  bool isChecked;
  CheckBoxOptions({this.index, this.title, this.isChecked});
}

class AddPeopleList {
  int addPeopleId;

  AddPeopleList({
    this.addPeopleId,
  });

  factory AddPeopleList.fromJson(Map<String, dynamic> json) => AddPeopleList(
        addPeopleId: json["extra_id"],
      );

  Map<String, dynamic> toJson() => {
        "extra_id": addPeopleId,
      };
}
