import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/ADdItemPagePresenter.dart';
import 'package:foodzi/AddItemPage/AddItemPageContractor.dart';
//import 'package:foodzi/AddItemPage/AddItemPagePresenter.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/RadioDailog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddItemPageView extends StatefulWidget {
  String title;
  String description;
  int item_id;
  int rest_id;

  AddItemPageView({this.title, this.description, this.item_id, this.rest_id});
  _AddItemPageViewState createState() => _AddItemPageViewState();
}

class _AddItemPageViewState extends State<AddItemPageView>
    implements AddItemPageModelView {
  List<bool> isSelected;

  AddItemModelList _addItemModelList;
  int item_id;
  int rest_id;
  ScrollController _controller = ScrollController();
  AddItemPagepresenter _addItemPagepresenter;
  List<int> _dropdownItemsTable = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  String strAdd = 'ADD \$24';
  String strGoToCart = 'test';
  String strOnTop = 'On top';
  String strOnSide = 'On side';
  String strDefaultTxt = '';
  List<int> listItemIdList = [];
  bool isAddBtnClicked = false;

  int _dropdownTableNumber;
  int itemIdValue;
  SharedPreferences prefs;
  List<String> listStrItemId = [];
  List<int> listIntItemId = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int tableID;
  @override
  void initState() {
    _addItemPagepresenter = AddItemPagepresenter(this);
    isSelected = [true, false];
    _addItemPagepresenter.performAddItem(
        widget.item_id, widget.rest_id, context);

    itemIdValue = widget.item_id;
    getTextChanged();
    super.initState();
  }

  // double _defaultValue = 1;
  int spread_id = 1;
  int count = 1;
  int extraCheckBoxid;
  String radioItem;
  String _selectedId;
  // FLCountStepperController _stepperController =
  //     FLCountStepperController(defaultValue: 1, min: 1, max: 10, step: 1);
  List<RadioButtonOptions> _radioOptions = [];
  List<CheckBoxOptions> _checkBoxOptions = [];
  void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }

  int getradiobtn(int length) {
    List<RadioButtonOptions> radiolist = [];
    for (int i = 1; i <= length; i++) {
      radiolist.add(RadioButtonOptions(
          index: i, title: _addItemModelList.spreads[i - 1].name ?? ''));
    }
    setState(() {
      _radioOptions = radiolist;
    });
  }

  int checkboxbtn(int length) {
    List<CheckBoxOptions> _checkboxlist = [];
    for (int i = 1; i <= length; i++) {
      _checkboxlist.add(CheckBoxOptions(
          price: _addItemModelList.extras[i - 1].price ?? '',
          isChecked: false,
          index: i,
          title: _addItemModelList.extras[i - 1].name ?? ''));
    }
    setState(() {
      _checkBoxOptions = _checkboxlist;
    });
  }

  Widget steppercount() {
    return Container(
      height: 24,
      width: 150,
      child: Row(children: <Widget>[
        InkWell(
          onTap: () {
            if (count > 1) {
              setState(() {
                --count;
                print(count);
              });
            }
          },
          splashColor: getColorByHex(Globle().colorscode),
          child: Container(
            decoration: BoxDecoration(
                color: getColorByHex(Globle().colorscode),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            alignment: Alignment.center,
            child: Icon(
              Icons.remove,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13, right: 13),
          child: Text(
            count.toString(),
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w600,
                color: greytheme700),
          ),
        ),
        InkWell(
          onTap: () {
            if (count < 10) {
              setState(() {
                ++count;
                print(count);
              });
            }
          },
          splashColor: Colors.lightBlue,
          child: Container(
            decoration: BoxDecoration(
                color: getColorByHex(Globle().colorscode),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            alignment: Alignment.center,
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: true,
      top: true,
      right: true,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[_getmainviewTableno(), _getOptions()],
        ),
        bottomNavigationBar: isAddBtnClicked
            ? BottomAppBar(
                child: GestureDetector(
                  onTap: () {
                    // addItemToCart();

                    // Navigator.pushNamed(context, '/OrderConfirmationView');
                    // print("button is pressed");
                    // showDialog(
                    //   context: context,
                    //   child: new RadioDialog(
                    //     onValueChange: _onValueChange,
                    //     initialValue: _selectedId,
                    //   ));
                  },
                  child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                          color: getColorByHex(Globle().colorscode),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      // color: redtheme,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              strDefaultTxt,
                              style: TextStyle(
                                  fontFamily: 'gotham',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                            InkWell(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "View Cart",
                                    style: TextStyle(
                                        fontFamily: 'gotham',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  SizedBox(width: 6),
                                  Icon(Icons.shopping_cart, color: Colors.white)
                                ],
                              ),
                              onTap: () {
                                print("count length-->");
                                print("$count");
                                print("spread id-->");
                                print("$spread_id");
                                print("extra checkbox id-->");
                                if (extraCheckBoxid != null) {
                                  print("$extraCheckBoxid");
                                }
                              },
                            )
                          ],
                        ),
                      )),
                ),
              )
            : null,
      ),
    );
  }

  Widget _getmainviewTableno() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'Wimpy',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w600,
                          color: greytheme700),
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                //endIndent: 10,
                //indent: 10,
              ),
              Row(
                children: <Widget>[
                  // SizedBox(
                  //   width: 26,
                  // ),
                  // Image.asset('assets/DineInImage/Group1504.png'),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Dine-in',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'gotham',
                        fontWeight: FontWeight.w600,
                        color: getColorByHex(Globle().colorscode)),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              getTableNumber(),
              // Row(
              //   children: <Widget>[
              //     SizedBox(width: 20),
              //     Text(
              //       'Add Table Number',
              //       textAlign: TextAlign.start,
              //       style: TextStyle(
              //           decoration: TextDecoration.underline,
              //           decorationColor: Colors.black,
              //           fontSize: 14,
              //           fontFamily: 'gotham',
              //           fontWeight: FontWeight.w600,
              //           color: greytheme100),
              //     )
              //   ],
              // ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getTableNumber() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      child: FormField(builder: (FormFieldState state) {
        return DropdownButtonFormField(
          //itemHeight: Constants.getScreenHeight(context) * 0.06,
          items: _dropdownItemsTable.map((int tableNumber) {
            return new DropdownMenuItem(
                value: tableNumber,
                child: Row(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          "Table Number: $tableNumber",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor:
                                  getColorByHex(Globle().colorscode),
                              fontSize: 14,
                              fontFamily: 'gotham',
                              fontWeight: FontWeight.w600,
                              color: getColorByHex(Globle().colorscode)),
                        )),
                  ],
                ));
          }).toList(),
          onChanged: (newValue) {
            // do other stuff with _category
            setState(() {
              _dropdownTableNumber = newValue;
              _dropdownItemsTable.forEach((value) {
                if (value == newValue) {
                  print(value);
                  tableID = value;
                }
              });
            });
          },

          value: _dropdownTableNumber,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greentheme100, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greytheme900, width: 2)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
            filled: false,
            hintText: 'Choose Table',
            // prefixIcon: Icon(
            //   Icons.location_on,
            //   size: 20,
            //   color: greytheme1000,
            // ),
            labelText: _dropdownTableNumber == null
                ? "Add Table Number "
                : "Table Number",
            // errorText: _errorText,
            labelStyle: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                fontSize: 14,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w600,
                color: greytheme100),
          ),
        );
      }),
    );
  }

  Widget _getOptions() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 25, left: 26),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                                fontFamily: 'gotham',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: greytheme700),
                          ),
                        ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(left: 26, top: 12),
                          child: Text(
                            widget.description,
                            style: TextStyle(
                                fontFamily: 'gotham',
                                fontSize: 16,
                                // fontWeight: FontWeight.w500,
                                color: greytheme1000),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(flex: 2, child: steppercount())
                ],
              ),

              // SizedBox(
              //   height: 25,
              // ),
              // Divider(
              //   thickness: 2,
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Padding(
              //       padding: EdgeInsets.only(left: 26),
              //       child: Text(
              //         'Quantity:',
              //         style: TextStyle(
              //             fontFamily: 'gotham',
              //             fontSize: 16,
              //             color: greytheme700),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 40,
              //     ),
              //     steppercount()
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.only(left: 26, top: 15),
                child: Text(
                  'Spreads',
                  style: TextStyle(
                      fontFamily: 'gotham', fontSize: 16, color: greytheme700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 26, top: 8),
                child: Text(
                  'Please select any one option',
                  style: TextStyle(
                      fontFamily: 'gotham', fontSize: 12, color: greytheme1000),
                ),
              ),
              _getRadioOptions(),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 2,
              ),
              Padding(
                padding: EdgeInsets.only(left: 26, top: 15),
                child: Text(
                  'Additions',
                  style: TextStyle(
                      fontFamily: 'gotham', fontSize: 16, color: greytheme700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 26, top: 8),
                child: Text(
                  'You can select multiple options',
                  style: TextStyle(
                      fontFamily: 'gotham', fontSize: 12, color: greytheme1000),
                ),
              ),
              _getCheckBoxOptions(),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 28),
                    Text(
                      'Dressing',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w500,
                          color: greytheme700),
                    ),
                    SizedBox(
                      width: 34,
                    ),
                    togglebutton()
                  ],
                ),
              ),
              SizedBox(height: 20),
              getAddButton(),
              SizedBox(height: 20),
            ]),
      ),
    );
  }

  getAddButton() {
    return Align(
      alignment: Alignment.center,
      child: ButtonTheme(
        minWidth: 350,
        height: 50,
        child: RaisedButton(
          color: getColorByHex(Globle().colorscode),
          onPressed: () {
            setState(() {
              isAddBtnClicked = true;
            });
            addItemToCart();
          },
          child: Text(
            "Add Item",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'gotham'),
          ),
          textColor: Colors.white,
          textTheme: ButtonTextTheme.normal,
          splashColor: Color.fromRGBO(72, 189, 111, 0.80),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
              side: BorderSide(color: Color.fromRGBO(72, 189, 111, 0.80))),
        ),
      ),
    );
  }

  _getRadioOptions() {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: _radioOptions.length > 0
            ? _radioOptions
                .map((radionBtn) => Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: RadioListTile(
                        title: Text("${radionBtn.title}") ?? Text('data'),
                        groupValue: spread_id,
                        value: radionBtn.index,
                        dense: true,
                        activeColor: getColorByHex(Globle().colorscode),
                        onChanged: (val) {
                          setState(() {
                            radioItem = radionBtn.title;
                            print(radionBtn.title);
                            spread_id = radionBtn.index;
                            print("Spread item id--->");
                            print("$spread_id");
                          });
                        },
                      ),
                    ))
                .toList()
            : [Container()]);
  }

  Widget togglebutton() {
    return Container(
      height: 36,
      child: ToggleButtons(
        borderColor: greytheme1300,
        fillColor: getColorByHex(Globle().colorscode),
        borderWidth: 2,
        selectedBorderColor: Colors.transparent,
        selectedColor: Colors.white,
        borderRadius: BorderRadius.circular(4),
        children: <Widget>[
          Container(
            width: 85,
            child: Text(
              strOnSide,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w500,
                  color: (isSelected[0] == true) ? Colors.white : greytheme700),
            ),
          ),
          Container(
            width: 85,
            child: Text(
              strOnTop,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'gotham',
                  fontWeight: FontWeight.w500,
                  color:
                      (isSelected[1] == false) ? greytheme700 : Colors.white),
            ),
          ),
        ],
        onPressed: (int index) {
          setState(() {
            for (int i = 0; i < isSelected.length; i++) {
              if (i == index) {
                isSelected[i] = true;
                print("item selected-->");
              } else {
                isSelected[i] = false;
              }
            }
          });
        },
        isSelected: isSelected,
      ),
    );
  }

  _getCheckBoxOptions() {
    return Column(
        children: _checkBoxOptions.length > 0
            ? _checkBoxOptions
                .map((checkBtn) => CheckboxListTile(
                    activeColor: getColorByHex(Globle().colorscode),
                    value: checkBtn.isChecked,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (val) {
                      setState(() {
                        checkBtn.isChecked = val;
                        if (checkBtn.isChecked != false) {
                          extraCheckBoxid = checkBtn.index;
                        } else {
                          extraCheckBoxid = null;
                        }
                        print("Additions id--->");
                        print(extraCheckBoxid);
                        print(val);
                      });
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          checkBtn.title ?? '',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(64, 64, 64, 1)),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 100,
                          ),
                          flex: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Text(
                            checkBtn.price.toString() ?? '',
                            style: TextStyle(
                                fontSize: 13,
                                color: Color.fromRGBO(64, 64, 64, 1)),
                          ),
                        ),
                      ],
                    )))
                .toList()
            : [Container()]);
  }

  @override
  void addItemfailed() {
    // TODO: implement addItemfailed
  }

  @override
  void addItemsuccess(List<AddItemModelList> _additemlist) {
    _addItemModelList = _additemlist[0];

    getradiobtn(_addItemModelList.spreads.length);

    checkboxbtn(_addItemModelList.extras.length);
    // TODO: implement addItemsuccess
  }

  addItemToCart() async {
    listItemIdList.add(itemIdValue);

    List<String> list = listItemIdList.map((i) => i.toString()).toList();
    prefs = await SharedPreferences.getInstance();
    prefs.setStringList("key", list);
    print("item id-->");
    print("$itemIdValue");
    setState(() {
      strDefaultTxt = "$count Item added";
    });

    // final snackBar = SnackBar(
    //   content: Text("Item added into cart"),
    // );
    // _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  getTextChanged() {
    if (listItemIdList.length == 0) {
      setState(() {
        strDefaultTxt = strAdd;
      });
    }
    getItemIdfromPreference();
  }

  getItemIdfromPreference() async {
    prefs = await SharedPreferences.getInstance();
    listStrItemId = prefs.getStringList("key");
    listIntItemId = listStrItemId.map((j) => int.parse(j)).toList();

    print("item id-->");
    print("$itemIdValue");
    print("list length in prefs--->");
    print(listIntItemId.length);
    for (int k = 0; k < listIntItemId.length; k++) {
      print("item in list-->");
      print(listIntItemId.elementAt(k));
      if (itemIdValue == listIntItemId.elementAt(k)) {
        print("Item matched");
        setState(() {
          strDefaultTxt = "$count item added";
          isAddBtnClicked = true;
        });
        return;
      } else {
        print("Item not matched");
        setState(() {
          strDefaultTxt = strAdd;
        });
      }
    }
    if (listItemIdList.length == 0) {
      listItemIdList.addAll(listIntItemId);
      print("default list length--->");
      print(listItemIdList);
    }
  }
}

// OrderConfirmationView
class CheckBoxOptions {
  int index;
  String title;
  String price;
  // double price;
  bool isChecked;
  CheckBoxOptions({this.index, this.title, this.price, this.isChecked});
}

class RadioButtonOptions {
  int index;
  String title;
  RadioButtonOptions({this.index, this.title});
}
