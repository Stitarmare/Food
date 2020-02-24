import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/ADdItemPagePresenter.dart';
import 'package:foodzi/AddItemPage/AddItemPageContractor.dart';
//import 'package:foodzi/AddItemPage/AddItemPagePresenter.dart';
import 'package:foodzi/Models/AddItemPageModel.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/RadioDailog.dart';

class AddItemPageView extends StatefulWidget {
  String title;
  String description;
  int item_id;
  int rest_id;

  AddItemPageView({this.title, this.description, this.item_id, this.rest_id});
  _AddItemPageViewState createState() => _AddItemPageViewState();
}

class _AddItemPageViewState extends State<AddItemPageView>
    implements
        AddItemPageModelView,
        AddmenuToCartModelview,
        AddTablenoModelView {
  List<bool> isSelected;

  AddItemsToCartModel addMenuToCartModel;

  Item items;

  List<Extras> extra;

  Spreads spread;

  List<Switches> switches;

  AddItemModelList _addItemModelList;
  int item_id;
  int rest_id;
  ScrollController _controller = ScrollController();

  AddItemPagepresenter _addItemPagepresenter;
  List<int> _dropdownItemsTable = [];

  int _dropdownTableNumber;

  int tableID;
  @override
  void initState() {
    _addItemPagepresenter = AddItemPagepresenter(this, this, this);
    isSelected = [true, false];
    _addItemPagepresenter.performAddItem(
        widget.item_id, widget.rest_id, context);
    super.initState();
  }

  // double _defaultValue = 1;
  int id = 1;
  int count = 1;
  String radioItem;
  String _selectedId;

  // FLCountStepperController _stepperController =
  //     FLCountStepperController(defaultValue: 1, min: 1, max: 10, step: 1);
  List<RadioButtonOptions> _radioOptions = [];
  List<CheckBoxOptions> _checkBoxOptions = [];
  List<SwitchesItems> _switchOptions = [];

  void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }

  int getradiobtn(int length) {
    List<RadioButtonOptions> radiolist = [];
    for (int i = 1; i <= length; i++) {
      radiolist.add(RadioButtonOptions(
          index: _addItemModelList.spreads[i - 1].id,
          title: _addItemModelList.spreads[i - 1].name ?? ''));
    }
    radiolist.add(RadioButtonOptions(title: "None"));
    // for (int i = length; i <= length+1; i++) {
    //   radiolist.add(RadioButtonOptions(
    //       index: _addItemModelList.spreads[i].id,
    //       title: 'none')
    //       );

    // }
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
          index: _addItemModelList.extras[i - 1].id ?? 0,
          title: _addItemModelList.extras[i - 1].name ?? ''));
    }
    setState(() {
      _checkBoxOptions = _checkboxlist;
    });
  }

  int switchbtn(int length) {
    List<SwitchesItems> _switchlist = [];
    for (int i = 1; i <= length; i++) {
      _switchlist.add(SwitchesItems(
          option1: _addItemModelList.switches[i - 1].option1 ?? "",
          option2: _addItemModelList.switches[i - 1].option2 ?? "",
          index: _addItemModelList.switches[i - 1].id ?? 0,
          title: _addItemModelList.switches[i - 1].name ?? '',
          isSelected: [true, false]));
    }

    setState(() {
      _switchOptions = _switchlist;
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
              items.quantity = count;
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
              items.quantity = count;
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
      left: false,
      top: false,
      right: false,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[_getmainviewTableno(), _getOptions()],
        ),
        bottomNavigationBar: BottomAppBar(
          child: GestureDetector(
            onTap: () {
              // setState(() {
              if (addMenuToCartModel == null) {
                addMenuToCartModel = AddItemsToCartModel();
              }
              addMenuToCartModel.userId = Globle().loginModel.data.id;
              addMenuToCartModel.restId = widget.rest_id;
              //addMenuToCartModel.tableId = null;
              if (items == null) {
                items = Item();
              }

              addMenuToCartModel.items = [items];
              addMenuToCartModel.items[0].itemId = widget.item_id;
              addMenuToCartModel.items[0].extra = extra ?? [];
              addMenuToCartModel.items[0].spreads =
                  spread == null ? [] : [spread];
              addMenuToCartModel.items[0].switches = switches ?? [];
              addMenuToCartModel.items[0].quantity = count;
              // }
              //);
              print(addMenuToCartModel.toJson());

              _addItemPagepresenter.performaddMenuToCart(
                  addMenuToCartModel, context);
              Constants.showAlertSuccess(
                  "${widget.title}",
                  "${widget.title} is successfully added to your cart.",
                  context);

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
              child: Center(
                child: Text(
                  'ADD \$24',
                  style: TextStyle(
                      fontFamily: 'gotham',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
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
                      widget.title ?? '',
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
              SizedBox(
                height: 25,
              ),
              Divider(
                thickness: 2,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 26),
                    child: Text(
                      'Quantity:',
                      style: TextStyle(
                          fontFamily: 'gotham',
                          fontSize: 16,
                          color: greytheme700),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  steppercount()
                ],
              ),
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
              togglebutton()
            ]),
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
                        groupValue: id,
                        value: radionBtn.index,
                        dense: true,
                        activeColor: getColorByHex(Globle().colorscode),
                        onChanged: (val) {
                          setState(() {
                            if (spread == null) {
                              spread = Spreads();
                            }

                            radioItem = radionBtn.title;
                            print(radionBtn.title);
                            id = radionBtn.index;
                            spread.spreadId = id;
                          });
                        },
                      ),
                    ))
                .toList()
            : [Container()]);
  }

  Widget togglebutton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _switchOptions.length > 0
          ? _switchOptions
              .map((switchs) => Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 28),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                switchs.title ?? "",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'gotham',
                                    fontWeight: FontWeight.w500,
                                    color: greytheme700),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
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
                                    "${switchs.option1}" ?? "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'gotham',
                                        fontWeight: FontWeight.w500,
                                        color: (switchs.isSelected[0] == true)
                                            ? Colors.white
                                            : greytheme700),
                                  ),
                                ),
                                Container(
                                  width: 85,
                                  child: Text(
                                    '${switchs.option2}' ?? "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'gotham',
                                        fontWeight: FontWeight.w500,
                                        color: (switchs.isSelected[1] == false)
                                            ? greytheme700
                                            : Colors.white),
                                  ),
                                ),
                              ],
                              onPressed: (int index) {
                                setState(() {
                                  switchs.isSelected[0] =
                                      !switchs.isSelected[0];
                                  switchs.isSelected[1] =
                                      !switchs.isSelected[1];
                                });
                                if (switches == null) {
                                  switches = [];
                                }
                                if (switches.length > 0) {
                                  for (int i = 0; i < switches.length; i++) {
                                    if (switches[i].switchId == switchs.index) {
                                      if (index == 0) {
                                        switches[i].switchOption =
                                            switchs.option1;
                                      }
                                      if (index == 1) {
                                        switches[i].switchOption =
                                            switchs.option2;
                                      }
                                    } else {
                                      var switchItem = Switches();
                                      switchItem.switchId = switchs.index;
                                      if (index == 0) {
                                        switchItem.switchOption =
                                            switchs.option1;
                                      }
                                      if (index == 1) {
                                        switchItem.switchOption =
                                            switchs.option2;
                                      }
                                      switches.add(switchItem);
                                    }
                                  }
                                } else {
                                  var switchItem = Switches();
                                  switchItem.switchId = switchs.index;
                                  if (index == 0) {
                                    switchItem.switchOption = switchs.option1;
                                  }
                                  if (index == 1) {
                                    switchItem.switchOption = switchs.option2;
                                  }
                                  switches.add(switchItem);
                                }
                              },
                              isSelected: switchs.isSelected),
                        )
                      ],
                    ),
                  ))
              .toList()
          : [Container()],
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
                        if (extra == null) {
                          extra = [];
                        }
                        if (extra.length > 0) {
                          if (val) {
                            var ext = Extras();
                            ext.extraId = checkBtn.index;
                            extra.add(ext);
                          } else {
                            for (int i = 0; i < extra.length; i++) {
                              if (checkBtn.index == extra[i].extraId) {
                                extra.removeAt(i);
                              }
                            }
                          }
                        } else {
                          var ext = Extras();
                          ext.extraId = checkBtn.index;
                          extra.add(ext);
                        }
                        checkBtn.isChecked = val;
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

    switchbtn(_addItemModelList.switches.length);

    // TODO: implement addItemsuccess
  }

  @override
  void addMenuToCartfailed() {
    // TODO: implement addMenuToCartfailed
  }

  @override
  void addMenuToCartsuccess() {
    // TODO: implement addMenuToCartsuccess
  }

  @override
  void addTablebnoSuccces() {
    // TODO: implement addTablebnoSuccces
  }

  @override
  void addTablenofailed() {
    // TODO: implement addTablenofailed
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

class SwitchesItems {
  int index;
  String title;
  String option1;
  List<bool> isSelected;
  String option2;
  SwitchesItems(
      {this.index, this.title, this.option1, this.option2, this.isSelected});
}
