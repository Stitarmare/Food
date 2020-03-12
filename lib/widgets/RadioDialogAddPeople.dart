import 'package:flutter/material.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineViewContractor.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineviewPresenter.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:toast/toast.dart';

class AddPeople {
  String name;
  int index;
  bool isChecked;
  AddPeople({this.name, this.index, this.isChecked});
}

class RadioDialogAddPeople extends StatefulWidget {
  final List<Data> data;
  final int tableId;
  final int orderId;
  final int restId;

  // const RadioDialogAddPeople(
  //     {this.onValueChange,
  //     this.initialValue,
  //   });

  const RadioDialogAddPeople(
      this.data, this.tableId, this.restId, this.orderId);

  // final String initialValue;
  // final void Function(String) onValueChange;

  @override
  State createState() => new RadioDialogAddPeopleState();
}

class RadioDialogAddPeopleState extends State<RadioDialogAddPeople>
    implements ConfirmationDineViewModelView {
  String _selectedId;
  // Default Radio Button Item
  String radioItem = 'Mango';
  List<Data> addList = [];
  AddPeopleInterface addPeopleInterface;

  // Group Value for Radio Button.
  int id;
  bool isChecked = false;

  // bool isChecked = false;
  String _currText = "";
  ConfirmationDineviewPresenter confirmationDineviewPresenter;
  // List<AddPeople> bList = [
  //   AddPeople(
  //     index: 1,
  //     name: "ABC",
  //     isChecked: false,
  //   ),
  //   AddPeople(
  //     index: 2,
  //     name: "XYZ",
  //     isChecked: false,
  //   ),
  //   AddPeople(
  //     index: 3,
  //     name: "PQR",
  //     isChecked: false,
  //   ),
  //   AddPeople(
  //     index: 4,
  //     name: "CDG ",
  //     isChecked: false,
  //   ),
  //   AddPeople(
  //     index: 5,
  //     name: "ABC",
  //     isChecked: false,
  //   ),
  //   AddPeople(
  //     index: 6,
  //     name: "XYZ",
  //     isChecked: false,
  //   ),
  //   AddPeople(
  //     index: 7,
  //     name: "PQR",
  //     isChecked: false,
  //   ),
  //   AddPeople(
  //     index: 8,
  //     name: "CDG ",
  //     isChecked: false,
  //   ),
  // ];

  @override
  void initState() {
    super.initState();

    // confirmationDineviewPresenter = ConfirmationDineviewPresenter(this);
    confirmationDineviewPresenter = ConfirmationDineviewPresenter(this);
    // _selectedId = widget.initialValue;
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
                    child: ListView.builder(
                        itemCount: widget.data.length,
                        itemBuilder: (BuildContext context, int i) {
                          return CheckboxListTile(
                              activeColor: ((Globle().colorscode) != null)
                                  ? getColorByHex(Globle().colorscode)
                                  : orangetheme,
                              value: isChecked,
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
                                  isChecked = val;
                                  id = i;
                                  if (val != false) {
                                    addList.add(widget.data[i]);
                                  } else {
                                    addList.remove(widget.data[i]);
                                  }
                                });
                              },
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.data[i].firstName ?? '',
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
                Center(
                    child: RaisedButton(
                  color: getColorByHex(Globle().colorscode),
                  shape: RoundedRectangleBorder(
                      // side: BorderSide(
                      //     color: Color.fromRGBO(170, 170, 170, 1)),
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () {
                    confirmationDineviewPresenter.addPeople(
                        widget.data[id].mobileNumber,
                        widget.tableId,
                        widget.restId,
                        23,
                        context);
                    Navigator.pop(context);
                    Toast.show(
                        "Sending Invitation to ${widget.data[id].firstName}...",
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
                ))
              ],
            ))
      ],
    );
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
  void getPeopleListonFailed() {
    // TODO: implement getPeopleListonFailed
  }

  @override
  void getPeopleListonSuccess(List<Data> data) {
    // TODO: implement getPeopleListonSuccess
  }
}

abstract class AddPeopleInterface {
  void getAddedpeople(List<AddPeople> list);
}
