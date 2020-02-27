import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/Models/AddMenuToCartModel.dart';
import 'package:foodzi/Models/GetTableListModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/MyCart/MyCartContarctor.dart';
import 'package:foodzi/MyCart/MycartPresenter.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPay.dart';
//import 'package:foodzi/Utils/ConstantImages.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/DailogBox.dart';
import 'package:foodzi/widgets/RadioDailog.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyCartView extends StatefulWidget {
  int restId;
  int userID;
  String lat;
  String long;
  String orderType;
  double total;

  MyCartView(
      {this.restId,
      this.userID,
      this.orderType,
      this.lat,
      this.long,
      this.total});
  //MyCartView({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyCartViewState();
  }
}

class _MyCartViewState extends State<MyCartView>
    implements MyCartModelView, GetTableListModelView, AddTablenoModelView {
  ScrollController _controller = ScrollController();
  final _textController = TextEditingController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  List<ItemInfo> _itemInfo = [];
  List<TableList> _dropdownItemsTable = [];

  String _selectedId;
  bool isTableList = false;

  bool isloading = false;

  int _dropdownTableNumber;
  int count;

  GetTableList getTableListModel;

  MycartPresenter _myCartpresenter;
  List<MenuCartList> _cartItemList;
  List<CartExtraItems> cartExtraItemsList = [];
  int cartId;
  MenuCartDisplayModel myCart;
  MenuCartList _cartList;
  int page = 1;

  int id;
  List<int> itemList = [];

  List<MenuCartList> itemData;

  @override
  void initState() {
    // TODO: implement initState
    _myCartpresenter = MycartPresenter(this, this, this);
    DialogsIndicator.showLoadingDialog(context, _keyLoader, "Loading");
    _myCartpresenter.getCartMenuList(
        widget.restId, context, Globle().loginModel.data.id);
    _myCartpresenter.getTableListno(widget.restId, context);
    super.initState();
  }

  void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
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

  // List list;

  // void removeItem(int index) {
  //   setState(() {
  //     list = List.from(list)..removeAt(index);
  //   });
  // }

  Widget steppercount(MenuCartList menuCartList) {
    return Container(
      height: 24,
      width: 150,
      child: Row(children: <Widget>[
        InkWell(
          onTap: () {
            if (menuCartList.quantity > 0) {
              setState(() {
                menuCartList.quantity -= 1;
                print(menuCartList.quantity);
              });
              _myCartpresenter.updateQauntityCount(
                  menuCartList.id,
                  menuCartList.quantity,
                  menuCartList.totalAmount / menuCartList.quantity,
                  context);

              if (menuCartList.quantity == 0) {
                _myCartpresenter.removeItemfromCart(
                    menuCartList.id, Globle().loginModel.data.id, context);
                setState(() {
                  _cartItemList.removeAt(menuCartList.id);
                });
              }
            }
          },
          splashColor: Colors.redAccent.shade200,
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
            menuCartList.quantity.toString(),
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w600,
                color: greytheme700),
          ),
        ),
        InkWell(
          onTap: () {
            if (menuCartList.quantity < 100) {
              setState(() {
                menuCartList.quantity += 1;
                print(menuCartList.quantity);
              });
              _myCartpresenter.updateQauntityCount(
                  menuCartList.id,
                  menuCartList.quantity,
                  menuCartList.totalAmount / menuCartList.quantity,
                  context);
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
    Widget _getmainviewTableno() {
      return
          // SliverToBoxAdapter(
          //   child:
          Container(
        margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
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
                height: 5,
              ),
              Divider(
                thickness: 2.0,
              ),
              SizedBox(
                height: 5,
              ),
              isTableList ? getTableNumber() : Container(),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
        // ),
      );
    }

    return SafeArea(
      left: false,
      top: false,
      right: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Cart'),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            _getmainviewTableno(),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 2,
            ),
            SizedBox(
              height: 10,
            ),
            isloading ? Container() : _getAddedListItem()
          ],
        ),
        // CustomScrollView(
        //   controller: _controller,
        //   slivers: <Widget>[
        //     _getmainviewTableno(),
        //     // Divider(height: 2,),
        //     _getAddedListItem()
        //   // _getOptions()
        //   ],
        // ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 102,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      child: Text(
                        'Add More Items',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'gotham',
                            decoration: TextDecoration.underline,
                            decorationColor: getColorByHex(Globle().colorscode),
                            color: getColorByHex(Globle().colorscode),
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        //Navigator.pushNamed(context, '/OrderConfirmation2View');
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/OrderConfirmationView');
                      // print("button is pressed");
                      // showDialog(
                      //     context: context,
                      //     child: new RadioDialog(
                      //       onValueChange: _onValueChange,
                      //       initialValue: _selectedId,
                      //     ));
                      (_cartItemList != null)
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentTipAndPay(
                                        restId: widget.restId,
                                        // price: _cartItemList[0].totalAmount,
                                        tableId: _dropdownTableNumber,
                                        // userId: widget.userID,
                                        totalAmount: myCart.grandTotal,
                                        items: itemList,
                                        itemdata: _cartItemList,
                                        orderType: widget.orderType,
                                        latitude: widget.lat,
                                        longitude: widget.long,
                                      )))
                          : Constants.showAlert("My Cart",
                              "Please add items to your cart first.", context);
                    },
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                          color: getColorByHex(Globle().colorscode),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      // color: getColorByHex(Globle().colorscode),
                      child: Center(
                        child: Text(
                          'PLACE ORDER',
                          style: TextStyle(
                              fontFamily: 'gotham',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  // int getItemName(int length) {
  //   List<ItemInfo> itemInfolist = [];
  //   for (int i = 1; i <= length; i++) {
  //     itemInfolist.add(ItemInfo(
  //       itemName: _cartItemList[i - 1].items[i - 1].itemName,
  //       itemDescription: _cartItemList[i - 1].items[i - 1].itemDescription,
  //       itemId: _cartItemList[i - 1].items[i - 1].id,
  //     ));
  //   }
  //   setState(() {
  //     _itemInfo = itemInfolist;
  //   });
  // }

  Widget getTableNumber() {
    return Container(
      margin: EdgeInsets.only(left: 20),
      height: 50,
      width: MediaQuery.of(context).size.width * 0.8,
      child: FormField(builder: (FormFieldState state) {
        return DropdownButtonFormField(
          //itemHeight: Constants.getScreenHeight(context) * 0.06,
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
            });
            _myCartpresenter.addTablenoToCart(Globle().loginModel.data.id,
                widget.restId, _dropdownTableNumber, context);
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

  Widget _getAddedListItem() {
    return (_cartItemList != null)
        ? Expanded(
            child: ListView.builder(
              itemCount: _cartItemList.length,
              itemBuilder: (BuildContext context, int index) {
                id = _cartItemList[index].itemId;
                //int userID = _cartItemList[index].userId;
                cartId = _cartItemList[index].id;

                return Dismissible(
                  key: UniqueKey(),
                  background: refreshBg(),
                  onDismissed: (direction) {
                    int cartIdnew = _cartItemList[index].id;
                    DialogsIndicator.showLoadingDialog(
                        context, _keyLoader, "Loading");

                    _myCartpresenter.removeItemfromCart(
                        cartIdnew, Globle().loginModel.data.id, context);
                  },
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: (_cartItemList[index].items.menuType ==
                                        "veg")
                                    ? Image.asset(
                                        'assets/VegIcon/Group1661.png',
                                        height: 25,
                                        width: 25,
                                      )
                                    : Image.asset(
                                        'assets/VegIcon/Group1661.png',
                                        color: redtheme,
                                        width: 25,
                                        height: 25,
                                      ),
                              ),
                              SizedBox(width: 16),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Text(
                                      _cartItemList[index].items.itemName ??
                                          'Bacon & Cheese Burger',
                                      style: TextStyle(
                                          fontFamily: 'gotham',
                                          fontSize: 16,
                                          color: greytheme700),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 180,
                                    child: AutoSizeText(
                                      _cartItemList[index]
                                              .items
                                              .itemDescription ??
                                          " Lorem Epsom is simply dummy text",
                                      style: TextStyle(
                                        color: greytheme1000,
                                        fontSize: 14,
                                        // fontFamily: 'gotham',
                                      ),
                                      // minFontSize: 8,
                                      maxFontSize: 12,
                                      maxLines: 2,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  steppercount(_cartItemList[index]),
                                ],
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: 80,
                                ),
                                flex: 2,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20, top: 30),
                                child: Text(
                                  "\$ ${_cartItemList[index].totalAmount}" ??
                                      '',
                                  style: TextStyle(
                                      color: greytheme700,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ]),
                        SizedBox(height: 12),
                        Divider(
                          height: 2,
                          thickness: 2,
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : Expanded(
            child: Center(
              child: Text(
                "Nothing in the Cart",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w500,
                    color: greytheme1200),
              ),
            ),
          );
  }

  Widget refreshBg() {
    return Container(
      alignment: Alignment.centerRight,
      color: getColorByHex(Globle().colorscode),
      padding: EdgeInsets.only(right: 20),
      child: Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  @override
  void getCartMenuListfailed() {
    // TODO: implement getCartMenuListfailed
  }

  @override
  void getCartMenuListsuccess(
      List<MenuCartList> menulist, MenuCartDisplayModel model) {
    // TODO: implement getCartMenuListsuccess

    if (menulist.length == 0) {
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      return;
    }
    myCart = model;

    setState(() {
      if (_cartItemList == null) {
        _cartItemList = menulist;
        for (var i = 0; i < _cartItemList.length; i++) {
          itemList.add(_cartItemList[i].id);
          print(itemList);
        }
        // for (var i = 0; i < _cartItemList.length; i++) {
        //   itemData.add(_cartItemList[i].items);
        //   print(itemData);
        // }
      } else {
        //_cartItemList.removeRange(0, (_cartItemList.length));
        _cartItemList.addAll(menulist);

        //getcartitemlist();
      }
      page++;
    });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void removeItemFailed() {
    // TODO: implement removeItemFailed
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void removeItemSuccess() {
    // TODO: implement removeItemSuccess
    _cartItemList = null;
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

    _myCartpresenter.getCartMenuList(
        widget.restId, context, Globle().loginModel.data.id);
    //return;
  }

  @override
  void addTablebnoSuccces() {
    // TODO: implement addTablebnoSuccces
  }

  @override
  void addTablenofailed() {
    // TODO: implement addTablenofailed
  }

  @override
  void getTableListFailed() {
    // TODO: implement getTableListFailed
  }

  @override
  void getTableListSuccess(List<GetTableList> _getlist) {
    getTableListModel = _getlist[0];
    if (_getlist.length > 0) {
      gettablelist(_getlist);
    }

    // TODO: implement getTableListSuccess
  }

  @override
  void updatequantitySuccess() {
    _cartItemList = null;
    //Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

    _myCartpresenter.getCartMenuList(
        widget.restId, context, Globle().loginModel.data.id);
    // TODO: implement updatequantitySuccess
  }

  @override
  void updatequantityfailed() {
    // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();

    // TODO: implement updatequantityfailed
  }

  //   return Scaffold(
  //     body: _getmainview(),
  //   );
  // }

//   Widget _getmainview() {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Padding(padding: EdgeInsets.fromLTRB(15, 200, 0, 0)),
//           Center(child: Text('data')),
//           //_getmainviewTableno(),
//           SizedBox(
//             height: 20,
//           ),
//           Divider(
//             thickness: 3,
//           ),
//         ],
//       ),
//     );
//   }
// }

}

class ItemInfo {
  String itemName;
  String itemDescription;
  int itemId;
  String menutype;
  ItemInfo({this.itemName, this.itemDescription, this.itemId, this.menutype});
}

class TableList {
  //geolocation(){}
  String name;
  int restid;
  int id;
  TableList({this.restid, this.id, this.name});
}

class AddTableno {
  int user_id;
  int table_id;
  int rest_id;

  AddTableno({this.rest_id, this.table_id, this.user_id});
}
