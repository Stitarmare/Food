import 'package:flutter/material.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/MyCart/MyCartContarctor.dart';
import 'package:foodzi/MyCart/MyCartView.dart';
import 'package:foodzi/MyCart/MycartPresenter.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';

class TableSelectDialogView extends StatefulWidget {
  int restId;
  TableSelectDialogView({this.restId});
  @override
  _TableSelectDialogViewState createState() => _TableSelectDialogViewState();
}

class _TableSelectDialogViewState extends State<TableSelectDialogView>
    implements GetTableListModelView, MyCartModelView, AddTablenoModelView {
  MycartPresenter _myCartpresenter;
  List<TableList> _dropdownItemsTable = [];
  int _dropdownTableNumber;
  int _dropdownTableNo;
  bool isTableList = false;
  String tableno;

  @override
  void initState() {
    _myCartpresenter = MycartPresenter(this, this, this);
    _myCartpresenter.getTableListno(widget.restId, context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      children: <Widget>[
        Container(
          height: isTableList
              ? MediaQuery.of(context).size.height * 0.21
              : MediaQuery.of(context).size.height * 0.19,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Select Table",
                  style: TextStyle(
                      fontSize: FONTSIZE_18,
                      fontFamily: Constants.getFontType(),
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Please select table first and then add items in your cart.",
                    style: TextStyle(
                        fontSize: FONTSIZE_16,
                        fontFamily: Constants.getFontType(),
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                ),
              ),
              isTableList
                  ? getTableNumber()
                  : Container(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Text(STR_NO_TABLE,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: FONTSIZE_15,
                                fontFamily: Constants.getFontType(),
                                fontWeight: FontWeight.w600,
                                color: Globle().colorscode != null
                                    ? getColorByHex(Globle().colorscode)
                                    : orangetheme300)),
                      ],
                    )),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(STR_OK,
                        style: TextStyle(
                            fontSize: FONTSIZE_14,
                            fontFamily: Constants.getFontType(),
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                  ),
                  onPressed: () {
                    if (_dropdownTableNo != null) {
                      Navigator.of(context).pop({
                        "tableDataId": _dropdownTableNo,
                        "tableDataName": tableno
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  int gettablelist(List<GetTableList> getlist) {
    List<TableList> _tablelist = [];
    for (int i = 0; i < getlist.length; i++) {
      _tablelist.add(TableList(
        id: getlist[i].id,
        restid: widget.restId,
        name: getlist[i].tableName,
      ));
    }
    setState(() {
      _dropdownItemsTable = _tablelist;
    });
    getlistoftable();
    return _tablelist.length;
  }

  getlistoftable() {
    if (_dropdownItemsTable != null) {
      if (_dropdownItemsTable.length >= 0) {
        setState(() {
          isTableList = true;
        });
        return;
      }
      setState(() {
        isTableList = false;
      });
    }
    setState(() {
      isTableList = false;
    });
  }

  Widget getTableNumber() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.6,
      child: FormField(builder: (FormFieldState state) {
        return DropdownButtonFormField(
          items: _dropdownItemsTable.map((tableNumber) {
            return new DropdownMenuItem(
                value: tableNumber.id,
                child: Row(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Text(
                          "${tableNumber.name}",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Globle().colorscode != null
                                  ? getColorByHex(Globle().colorscode)
                                  : orangetheme300,
                              fontSize: FONTSIZE_14,
                              fontFamily: Constants.getFontType(),
                              fontWeight: FontWeight.w600,
                              color: Globle().colorscode != null
                                  ? getColorByHex(Globle().colorscode)
                                  : orangetheme300),
                        )),
                  ],
                ));
          }).toList(),
          onChanged: (newValue) async {
            setState(() {
              _dropdownTableNumber = newValue;
              _dropdownTableNo = _dropdownTableNumber;
              Preference.setPersistData<int>(
                  _dropdownTableNumber, PreferenceKeys.tableId);
              Preference.setPersistData<int>(
                  widget.restId, PreferenceKeys.restaurantID);
            });
            for (int i = 0; i < _dropdownItemsTable.length; i++) {
              if (newValue == _dropdownItemsTable[i].id) {
                print(_dropdownItemsTable[i].name);
                tableno = _dropdownItemsTable[i].name;
                Preference.setPersistData<String>(tableno, "tableName");
              }
            }
          },
          value: _dropdownTableNo,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greentheme400, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: greytheme900, width: 2)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
            filled: false,
            hintText: STR_CHOOSE_TABLE,
            labelText:
                _dropdownTableNumber == null ? STR_ADD_TABLE : STR_TABLE_NO,
            labelStyle: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                fontSize: FONTSIZE_14,
                fontFamily: Constants.getFontType(),
                fontWeight: FontWeight.w600,
                color: greytheme100),
          ),
        );
      }),
    );
  }

  @override
  void getTableListFailed() {}

  @override
  void getTableListSuccess(List<GetTableList> getlist) {
    if (getlist.length > 0) {
      gettablelist(getlist);
    }
  }

  @override
  void addTablebnoSuccces() {}

  @override
  void addTablenofailed() {}

  @override
  void getCartMenuListfailed() {}

  @override
  void getCartMenuListsuccess(
      List<MenuCartList> menulist, MenuCartDisplayModel model) {}

  @override
  void placeOrderCartFailed() {}

  @override
  void placeOrderCartSuccess(OrderData data) {}

  @override
  void removeItemFailed() {}

  @override
  void removeItemSuccess() {}

  @override
  void updatequantitySuccess() {}

  @override
  void updatequantityfailed() {}
}
