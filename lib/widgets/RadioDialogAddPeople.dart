import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';

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

class RadioDialogAddPeopleState extends State<RadioDialogAddPeople> {
  String _selectedId;
  // Default Radio Button Item
  String radioItem = 'Mango';
  List<AddPeople> addList = [];
  AddPeopleInterface addPeopleInterface;

  // Group Value for Radio Button.
  int id = 1;
  bool isChecked = false;

  // bool isChecked = false;
  String _currText = "";

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
                    Navigator.pop(context);
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
}

abstract class AddPeopleInterface {
  void getAddedpeople(List<AddPeople> list);
}
