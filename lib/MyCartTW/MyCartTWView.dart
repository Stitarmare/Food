import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/MyCartTW/MyCartTWContractor.dart';
import 'package:foodzi/MyCartTW/MyCartTWPresenter.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPay.dart';
import 'package:foodzi/Utils/ConstantImages.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyCartTWView extends StatefulWidget {
  String restName;
  int restId;
  int userID;
  String lat;
  String long;
  String orderType;
  double total;
  MyCartTWView(
      {this.restId,
      this.userID,
      this.orderType,
      this.lat,
      this.long,
      this.total,
      this.restName});
  //MyCartTWView({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MyCartTWViewState();
  }
}

class _MyCartTWViewState extends State<MyCartTWView>
    implements MyCartTWModelView {
  ScrollController _controller = ScrollController();
  final _textController = TextEditingController();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  List<ItemInfo> _itemInfo = [];

  String _selectedId;
  int count = 0;
  MycartTWPresenter _myCartpresenter;
  List<MenuCartList> _cartItemList;
  int page = 1;
  int indx;

  int id;
  List<int> itemList = [];
  MenuCartDisplayModel myCart;

  @override
  void initState() {
    // TODO: implement initState
    _myCartpresenter = MycartTWPresenter(this);
    DialogsIndicator.showLoadingDialog(context, _keyLoader, "Loading");
    _myCartpresenter.getCartMenuList(
        widget.restId, context, Globle().loginModel.data.id);

    super.initState();
  }

  void _onValueChange(String value) {
    setState(() {
      _selectedId = value;
    });
  }

  Widget steppercount(int i) {
    int count = _cartItemList[i].quantity;
    return Container(
      height: 24,
      width: 150,
      child: Row(children: <Widget>[
        InkWell(
          onTap: (_cartItemList[i].quantity == 1)
              ? () {}
              : () {
                  if (count > 1) {
                    setState(() {
                      --count;
                      _cartItemList[i].quantity = count;

                      print(count);
                    });
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
            if (count < 100) {
              setState(() {
                ++count;
                print(count);
                _cartItemList[i].quantity = count;
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
    addTablePopUp(BuildContext context) {
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return Container(
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  height: 236,
                  width: 284,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Text(
                          'Add a Table Number',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'gotham',
                              fontWeight: FontWeight.w600,
                              color: greytheme700),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Center(
                      //   child: TextFormField(
                      //     keyboardType: TextInputType.number,
                      //     autofocus: true,
                      //     inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                      //   )
                      // ),
                      Center(
                        child: Container(
                          // margin: EdgeInsets.only(left: 37, right: 27),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: greytheme600)),
                          // color: Color.fromRGBO(213, 213, 213, 1)),
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 8),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            autofocus: true,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            maxLines: 1,
                            controller: _textController,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      Center(
                        child: RaisedButton(
                          color: getColorByHex(Globle().colorscode),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: getColorByHex(Globle().colorscode)),
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12, 11, 12, 11),
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'gotham',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }

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
              // Row(
              //   children: <Widget>[
              //     SizedBox(
              //       width: 20,
              //     ),
              // Container(
              //   // width: MediaQuery.of(context).size.width * 0.8,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top: 12, bottom: 6, left: 20),
              //     child: Text(
              //       'Wimpy',
              //       textAlign: TextAlign.start,
              //       style: TextStyle(
              //           fontSize: 20,
              //           fontFamily: 'gotham',
              //           fontWeight: FontWeight.w600,
              //           color: greytheme700),
              //     ),
              //   ),
              // ),
              //   ],
              // ),
              // Divider(
              //   thickness: 2,
              //   //endIndent: 10,
              //   //indent: 10,
              // ),
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
                    'Collection',
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
                height: 10,
              ),
              // Row(
              //   children: <Widget>[
              //     SizedBox(width: 20),
              //     GestureDetector(
              //       onTap: () {
              //         //  await DailogBox.addTablePopUp(context);
              //         addTablePopUp(context);
              //       },
              //       child: Text(
              //         'Add Table Number',
              //         textAlign: TextAlign.start,
              //         style: TextStyle(
              //             decoration: TextDecoration.underline,
              //             decorationColor: Colors.black,
              //             fontSize: 14,
              //             fontFamily: 'gotham',
              //             fontWeight: FontWeight.w600,
              //             color: greytheme100),
              //       ),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // )
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
          brightness: Brightness.dark,
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
            _getAddedListItem()
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
                                        restName: widget.restName,
                                        restId: widget.restId,
                                        userId: _cartItemList[indx].userId,
                                        price: _cartItemList[indx].totalAmount,
                                        items: itemList,
                                        totalAmount: myCart.grandTotal,
                                        orderType: widget.orderType,
                                        latitude: widget.lat,
                                        longitude: widget.long,
                                        itemdata: _cartItemList,
                                        currencySymbol: myCart.currencySymbol,
                                        tableId: _cartItemList[indx].tableId,
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
//     List<ItemInfo> itemInfolist = [];
//     for (int i = 1; i <= length; i++) {
//       itemInfolist.add(ItemInfo(
//           itemName: _cartItemList[i-1].items[i - 1].itemName,
//           itemDescription: _cartItemList[i-1].items[i - 1].itemDescription,
//           itemId:_cartItemList[i-1].items[i - 1].id, ));
//     }
//     setState(() {
//       _itemInfo = itemInfolist;
//     });
//   }
  Widget _getAddedListItem() {
    return (_cartItemList != null)
        ? Expanded(
            child: ListView.builder(
              itemCount: _cartItemList.length,
              itemBuilder: (BuildContext context, int index) {
                id = _cartItemList[index].itemId;
                indx = index;
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
                                  steppercount(index),
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
                                  "${myCart.currencySymbol} " +
                                          "${_cartItemList[index].totalAmount}" ??
                                      "${myCart.currencySymbol} " + '17',
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
    Preference.setPersistData(null, PreferenceKeys.restaurantID);
    Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
    // TODO: implement getCartMenuListfailed
  }

  @override
  void getCartMenuListsuccess(
      List<MenuCartList> menulist, MenuCartDisplayModel model) {
    // TODO: implement getCartMenuListsuccess

    if (menulist.length == 0) {
      Globle().takeAwayCartItemCount = menulist.length;
      Preference.setPersistData(
          Globle().takeAwayCartItemCount, PreferenceKeys.takeAwayCartCount);
      Preference.setPersistData(null, PreferenceKeys.restaurantID);
      Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
      Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
      return;
    }
    Globle().takeAwayCartItemCount = menulist.length;
    Preference.setPersistData(
        Globle().takeAwayCartItemCount, PreferenceKeys.takeAwayCartCount);
    myCart = model;
    setState(() {
      if (_cartItemList == null) {
        _cartItemList = menulist;
        for (var i = 0; i < _cartItemList.length; i++) {
          itemList.add(_cartItemList[i].id);
          print(itemList);
        }
      } else {
        //_cartItemList.removeRange(0, (_cartItemList.length));
        _cartItemList.addAll(menulist);
      }
      page++;
    });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void removeItemFailed() {
    Preference.setPersistData(null, PreferenceKeys.restaurantID);
    Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
    Preference.setPersistData(null, PreferenceKeys.restaurantName);
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void removeItemSuccess() {
    _cartItemList = null;
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    Globle().takeAwayCartItemCount -= 1;
    Preference.setPersistData<int>(
        Globle().takeAwayCartItemCount, PreferenceKeys.takeAwayCartCount);
    Preference.setPersistData(null, PreferenceKeys.restaurantID);
    Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
    _myCartpresenter.getCartMenuList(
        widget.restId, context, Globle().loginModel.data.id);
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
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
