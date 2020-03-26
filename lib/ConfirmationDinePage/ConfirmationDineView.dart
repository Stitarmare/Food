import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/AddItemPage/AddItemPageView.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineViewContractor.dart';
import 'package:foodzi/ConfirmationDinePage/ConfirmationDineviewPresenter.dart';
import 'package:foodzi/Models/GetPeopleListModel.dart';
import 'package:foodzi/Models/InvitePeopleModel.dart';
import 'package:foodzi/Models/MenuCartDisplayModel.dart';
import 'package:foodzi/Models/OrderStatusModel.dart';
import 'package:foodzi/Models/PlaceOrderModel.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPay.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayContractor.dart';
import 'package:foodzi/PaymentTipAndPay/PaymentTipAndPayPresenter.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackView.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewContractor.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackViewPresenter.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:foodzi/widgets/RadioDailog.dart';
import 'package:foodzi/widgets/RadioDialogAddPeople.dart';

class ConfirmationDineView extends StatefulWidget {
  // int orderID;
  String restName;
  int price;
  int restId;
  int userId;
  String orderType;
  int tableId;
  String tablename;
  List<int> items;
  int totalAmount;
  String latitude;
  String longitude;
  String currencySymbol;
  List<MenuCartList> itemdata;
  ConfirmationDineView({
    this.userId,
    this.price,
    this.items,
    this.restId,
    this.latitude,
    this.tablename,
    this.longitude,
    this.orderType,
    this.tableId,
    this.totalAmount,
    this.itemdata,
    this.restName,
    this.currencySymbol,
    // this.orderID,
  });
  @override
  _ConfirmationDineViewState createState() => _ConfirmationDineViewState();
}

class _ConfirmationDineViewState extends State<ConfirmationDineView>
    implements
        PaymentTipAndPayModelView,
        ConfirmationDineViewModelView,
        StatusTrackViewModelView {
  int i;
  bool isselected = false;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  DialogsIndicator dialogs = DialogsIndicator();
  List<RadioButtonOrderOptions> _orderOptions = [
    RadioButtonOrderOptions(
        index: 1, title: 'Dine-in', subtitle: 'Get served in Restaurant'),
    RadioButtonOrderOptions(
        index: 2, title: "Collection", subtitle: 'Order to Collect'),
  ];

  StatusTrackViewPresenter statusTrackViewPresenter;

  List<Data> peopleList = [];
  List<InvitePeopleList> invitePeopleList = [];

  ConfirmationDineviewPresenter confirmationDineviewPresenter;

  List<RadioButtonOptions> _radioOptions = [
    RadioButtonOptions(index: 1, title: 'ASAP'),
    RadioButtonOptions(index: 2, title: 'Within 1 hour'),
    RadioButtonOptions(index: 3, title: 'Within 2 hour'),
    RadioButtonOptions(index: 4, title: 'Within 3 hour'),
  ];
  PaymentTipAndPayPresenter _paymentTipAndPayPresenter;
  ScrollController _controller = ScrollController();
  int id = 1;
  int radioId = 1;
  int radioOrderId = 1;
  String radioItem;
  String radioOrderItem;
  String radioOrderItemsub;

  int _dropdownTableNumber;

  int cartId;

  OrderData myOrderData;

  @override
  void initState() {
    DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
    _paymentTipAndPayPresenter = PaymentTipAndPayPresenter(this);
    confirmationDineviewPresenter = ConfirmationDineviewPresenter(this);
    statusTrackViewPresenter = StatusTrackViewPresenter(this);
    statusTrackViewPresenter.getInvitedPeople(
        Globle().loginModel.data.id,
        //widget.tableId
        2,
        context);

    // confirmationDineviewPresenter.getPeopleList(context);

    print("table id-->");
    print(widget.tableId);

    print("paytippay length--->");
    print(widget.itemdata.length);

    // Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      top: false,
      right: false,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          title: Text(widget.restName),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: CustomScrollView(
          controller: _controller,
          slivers: <Widget>[
            _getorderOptions(),
            radioId == 1 ? _gettableText() : _gettimeOptions(),
          ],
        ),
        // body: Container(
        //   margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        //   child: Column(children: <Widget>[
        //     Row(
        //       children: <Widget>[
        //         Spacer(),
        //         Text(
        //           "${widget.tablename}",
        //           textAlign: TextAlign.end,
        //           style: TextStyle(
        //               fontSize: 16,
        //               fontFamily: 'gotham',
        //               fontWeight: FontWeight.w600,
        //               color: greytheme100),
        //         ),
        //         SizedBox(
        //           width: 15,
        //         )
        //       ],
        //     ),
        //     //SizedBox(height: 0,),
        //     Divider(
        //       thickness: 2,
        //     ),
        //     SizedBox(
        //       height: 10,
        //     ),
        //     Expanded(
        //       child: ListView.builder(
        //           itemCount: widget.itemdata.length,
        //           itemBuilder: (BuildContext context, int index) {
        //             id = widget.itemdata[index].itemId;
        //             //int userID = widget.itemdata[index].userId;
        //             cartId = widget.itemdata[index].id;

        //             return Container(
        //                 child: Column(
        //               mainAxisAlignment: MainAxisAlignment.start,
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: <Widget>[
        //                 Row(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: <Widget>[
        //                       Padding(
        //                         padding: EdgeInsets.only(left: 20),
        //                         child: (widget.itemdata[index].items.menuType ==
        //                                 "veg")
        //                             ? Image.asset(
        //                                 'assets/VegIcon/Group1661.png',
        //                                 height: 25,
        //                                 width: 25,
        //                               )
        //                             : Image.asset(
        //                                 'assets/VegIcon/Group1661.png',
        //                                 color: redtheme,
        //                                 width: 25,
        //                                 height: 25,
        //                               ),
        //                       ),
        //                       SizedBox(width: 16),
        //                       Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: <Widget>[
        //                           Container(
        //                             width: MediaQuery.of(context).size.width *
        //                                 0.65,
        //                             child: Text(
        //                               widget.itemdata[index].items.itemName ??
        //                                   'Bacon & Cheese Burger',
        //                               style: TextStyle(
        //                                   fontFamily: 'gotham',
        //                                   fontSize: 16,
        //                                   color: greytheme700),
        //                             ),
        //                           ),
        //                           SizedBox(
        //                             height: 6,
        //                           ),
        //                           SizedBox(
        //                             height: 30,
        //                             width: 180,
        //                             child: AutoSizeText(
        //                               getExtra(widget.itemdata[index]),
        //                               style: TextStyle(
        //                                 color: greytheme1000,
        //                                 fontSize: 14,
        //                                 // fontFamily: 'gotham',
        //                               ),
        //                               // minFontSize: 8,
        //                               maxFontSize: 12,
        //                               maxLines: 2,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                       Expanded(
        //                         child: SizedBox(
        //                           width: 0,
        //                         ),
        //                         // flex: 2,
        //                       ),
        //                       Padding(
        //                         padding: EdgeInsets.only(
        //                           right: 15,
        //                         ),
        //                         child: Column(
        //                           children: <Widget>[
        //                             Text(
        //                               "\$ ${widget.itemdata[index].totalAmount}" ??
        //                                   '',
        //                               style: TextStyle(
        //                                   color: greytheme700,
        //                                   fontSize: 16,
        //                                   fontWeight: FontWeight.w600),
        //                             ),
        //                             SizedBox(
        //                               height: 10,
        //                             ),
        //                             Text(
        //                               "Quantity:",
        //                               // ${widget.itemdata[index].quantity}",
        //                               style: TextStyle(
        //                                   fontFamily: 'gotham',
        //                                   fontSize: 10,
        //                                   color: greytheme700),
        //                             ),
        //                             SizedBox(
        //                               height: 5,
        //                             ),
        //                             Container(
        //                               decoration: BoxDecoration(
        //                                   color: getColorByHex(
        //                                       Globle().colorscode),
        //                                   borderRadius: BorderRadius.all(
        //                                       Radius.circular(5))),
        //                               width: 25,
        //                               height: 25,
        //                               child: Center(
        //                                 child: Text(
        //                                   "${widget.itemdata[index].quantity}",
        //                                   textAlign: TextAlign.center,
        //                                   style: TextStyle(
        //                                       fontFamily: 'gotham',
        //                                       fontSize: 10,
        //                                       fontWeight: FontWeight.w500,
        //                                       color: Colors.white),
        //                                 ),
        //                               ),
        //                             ),
        //                           ],
        //                         ),
        //                       )
        //                     ]),
        //                 SizedBox(height: 12),
        //                 Divider(
        //                   height: 2,
        //                   thickness: 2,
        //                 ),
        //                 SizedBox(height: 8),
        //               ],
        //             ));
        //           }),
        //     ),
        //   ]),
        // ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 90,
            child: Column(
              children: <Widget>[
                Container(
                  height: 35,
                  // child: FlatButton(
                  //   child: Text(
                  //     'Add More People',
                  //     style: TextStyle(
                  //         fontSize: 16,
                  //         fontFamily: 'gotham',
                  //         decoration: TextDecoration.underline,
                  //         decorationColor: ((Globle().colorscode) != null)
                  //             ? getColorByHex(Globle().colorscode)
                  //             : orangetheme,
                  //         color: ((Globle().colorscode) != null)
                  //             ? getColorByHex(Globle().colorscode)
                  //             : orangetheme,
                  //         fontWeight: FontWeight.w600),
                  //   ),
                  //   onPressed: () async {
                  //     int orderId = await Preference.getPrefValue<int>(
                  //         PreferenceKeys.ORDER_ID);
                  //     showDialog(
                  //         context: context,
                  //         child: RadioDialogAddPeople(peopleList,
                  //             widget.tableId, widget.restId, orderId));

                  //     // confirmationDineviewPresenter.addPeople(
                  //     //     widget.mobilenumber,
                  //     //     widget.tableId,
                  //     //     widget.restId,
                  //     //     widget.orderID,
                  //     //     context);
                  //   },
                  // ),
                ),
                Container(
                  //margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: MediaQuery.of(context).size.width,
                  height: 54,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                    ),
                    child: Text(
                      'CONFIRM & PLACE ORDER',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    color: getColorByHex(Globle().colorscode),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => PaymentTipAndPay(
                      //             restId: widget.restId,
                      //             tablename: widget.tablename,
                      //             // price: widget.itemdata[0].totalAmount,
                      //             tableId: widget.tableId,
                      //             // userId: widget.userID,
                      //             totalAmount: widget.totalAmount,
                      //             items: widget.items,
                      //             itemdata: widget.itemdata,
                      //             orderType: widget.orderType,
                      //             latitude: widget.latitude,
                      //             longitude: widget.longitude)));
                      //Navigator.of(context).pushNamed('/StatusTrackView');
                      if (radioOrderId == 2) {
                        Globle().takeAwayCartItemCount = 0;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PaymentTipAndPay(
                                      flag: 2,
                                      restName: widget.restName,
                                      restId: widget.restId,
                                      userId: Globle().loginModel.data.id,
                                      //price: widget.itemdata[index].totalAmount,
                                      items: widget.items,
                                      totalAmount: widget.totalAmount,
                                      orderType: "take_away",
                                      latitude: widget.latitude,
                                      longitude: widget.longitude,
                                      itemdata: widget.itemdata,
                                      currencySymbol: widget.currencySymbol,
                                      // tableId: _cartItemList[indx].tableId,
                                    )));
                      } else if (radioOrderId == 1) {
                        DialogsIndicator.showLoadingDialog(
                            context, _keyLoader, "Loading");
                        _paymentTipAndPayPresenter.placeOrder(
                            widget.restId,
                            Globle().loginModel.data.id,
                            widget.orderType,
                            widget.tableId,
                            widget.items,
                            widget.totalAmount,
                            widget.latitude,
                            widget.longitude,
                            context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getExtra(MenuCartList menuCartList) {
    var extras = "";
    for (int i = 0; i < menuCartList.cartExtraItems.length; i++) {
      if (menuCartList.cartExtraItems[i].spreads.length > 0) {
        for (int j = 0;
            j < menuCartList.cartExtraItems[i].spreads.length;
            j++) {
          extras += "${menuCartList.cartExtraItems[i].spreads[j].name}, ";
        }
      }

      if (menuCartList.cartExtraItems[i].extras.length > 0) {
        for (int j = 0; j < menuCartList.cartExtraItems[i].extras.length; j++) {
          extras += "${menuCartList.cartExtraItems[i].extras[j].name}, ";
        }
      }
      if (menuCartList.cartExtraItems[i].switches.length > 0) {
        for (int j = 0;
            j < menuCartList.cartExtraItems[i].switches.length;
            j++) {
          extras += "${menuCartList.cartExtraItems[i].switches[j].name}, ";
        }
      }
    }
    if (extras.isNotEmpty) {
      extras = removeLastChar(extras);
      extras = removeLastChar(extras);
    }
    return extras;
  }

  static String removeLastChar(String str) {
    return str.substring(0, str.length - 1);
  }

  Widget _gettableAndPeople() {
    _gettableText();
  }

  Widget _gettableText() {
    return SliverToBoxAdapter(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.80,
              color: Color.fromRGBO(240, 240, 240, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Table Number :", style: TextStyle(fontSize: 18)),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "${widget.tablename}",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            // Icon(Icons.add),
            // RaisedButton(
            //     onPressed: () async {
            //       int orderId = await Preference.getPrefValue<int>(
            //           PreferenceKeys.ORDER_ID);

            //       showDialog(
            //           context: context,
            //           child: RadioDialogAddPeople(
            //               widget.tableId, widget.restId, orderId));

            //       // showDialog(
            //       //     context: context, child: RadioDialogAddPeople());
            //     },
            //     child: Text('Add More People')),

            Stack(
              fit: StackFit.passthrough,
              overflow: Overflow.visible,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add),
                    RaisedButton(
                        onPressed: () async {
                          int orderId = await Preference.getPrefValue<int>(
                              PreferenceKeys.ORDER_ID);

                          showDialog(
                              context: context,
                              child: RadioDialogAddPeople(
                                  widget.tableId, widget.restId, orderId));
                        },
                        child: Text('Add More People')),
                  ],
                ),
                (invitePeopleList.length != null)
                    ? invitePeopleList.length > 0
                        ? Positioned(
                            top: -10,
                            right: -10,
                            child: Badge(
                                badgeColor: redtheme,
                                badgeContent: Text(
                                    "${invitePeopleList.length} ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white))))
                        : Text(
                            "",
                          )
                    : Text(
                        "",
                      )
              ],
            )
            //   ],
            // )
          ],
        ),
      ),
    );
  }

  Widget _gettimeOptions() {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.only(left: 26, top: 10),
              child: Text(
                'How soon do you want it ?',
                style: TextStyle(
                    fontFamily: 'gotham', fontSize: 16, color: greytheme700),
              ),
            ),
            _getRadioOptions(),
            //_getCheckBoxOptions()
          ],
        ),
      ),
    );
  }

  Widget _getorderOptions() {
    return SliverToBoxAdapter(
      child: Container(
          margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[_getorderOption()])),
    );
  }

  // getcontent() {
  //   if (radioId == 1) {
  //     Visibility(
  //       visible: true,
  //     );
  //   } else {
  //     Visibility(
  //       child: _getRadioOptions(),
  //       visible: true,
  //     );
  //   }
  // }

  _getRadioOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      children: _radioOptions
          .map((radionBtn) => Padding(
                padding: const EdgeInsets.only(top: 0),
                child: RadioListTile(
                  title: Text("${radionBtn.title}",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'gotham',
                          fontWeight: FontWeight.w500,
                          color: greytheme700)),
                  groupValue: id,
                  value: radionBtn.index,
                  dense: true,
                  activeColor: getColorByHex(Globle().colorscode),
                  onChanged: (val) {
                    setState(() {
                      radioItem = radionBtn.title;
                      id = radionBtn.index;
                    });
                  },
                ),
              ))
          .toList(),
    );
  }
// Widget getTableNumber() {
//     return Container(
//       margin: EdgeInsets.only(left: 20),
//       height: 50,
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: FormField(builder: (FormFieldState state) {
//         return DropdownButtonFormField(
//           //itemHeight: Constants.getScreenHeight(context) * 0.06,
//           items: _dropdownItemsTable.map((tableNumber) {
//             return new DropdownMenuItem(
//                 value: tableNumber.id,
//                 child: Row(
//                   children: <Widget>[
//                     Container(
//                         width: MediaQuery.of(context).size.width * 0.4,
//                         child: Text(
//                           "Table Number: ${tableNumber.name}",
//                           style: TextStyle(
//                               decoration: TextDecoration.underline,
//                               decorationColor:
//                                   getColorByHex(Globle().colorscode),
//                               fontSize: 14,
//                               fontFamily: 'gotham',
//                               fontWeight: FontWeight.w600,
//                               color: getColorByHex(Globle().colorscode)),
//                         )),
//                   ],
//                 ));
//           }).toList(),
//           onChanged: (newValue) {
//             // do other stuff with _category
//             setState(() {
//               _dropdownTableNumber = newValue;
//             });
//             _addItemPagepresenter.addTablenoToCart(Globle().loginModel.data.id,
//                 widget.rest_id, _dropdownTableNumber, context);
//           },

//           value: _dropdownTableNumber,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.fromLTRB(10, 0, 5, 0),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: greentheme100, width: 2),
//             ),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: greytheme900, width: 2)),
//             border:
//                 OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
//             filled: false,
//             hintText: 'Choose Table',
//             // prefixIcon: Icon(
//             //   Icons.location_on,
//             //   size: 20,
//             //   color: greytheme1000,
//             // ),
//             labelText: _dropdownTableNumber == null
//                 ? "Add Table Number "
//                 : "Table Number",
//             // errorText: _errorText,
//             labelStyle: TextStyle(
//                 decoration: TextDecoration.underline,
//                 decorationColor: Colors.black,
//                 fontSize: 14,
//                 fontFamily: 'gotham',
//                 fontWeight: FontWeight.w600,
//                 color: greytheme100),
//           ),
//         );
//       }),
//     );
//   }
  void getTableAlert() {
    showDialog(
      barrierDismissible: true,
      context: context,
      //child: getTableNumber(),
      builder: (context) => AlertDialog(
        title: Text(
          "Select Table",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'gotham',
              fontWeight: FontWeight.w600,
              color: greytheme700),
        ),
        actions: <Widget>[
          Divider(
            endIndent: 15,
            indent: 15,
            color: Colors.black,
          ),
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  _getorderOption() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.baseline,
      children: _orderOptions
          .map((radionOrderBtn) => Padding(
                padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: RadioListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 16),
                      child: Text("${radionOrderBtn.title}",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'gotham',
                              fontWeight: FontWeight.w600,
                              color: getColorByHex(Globle().colorscode))),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text("${radionOrderBtn.subtitle}",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'gotham',
                              fontWeight: FontWeight.w500,
                              color: greytheme100)),
                    ),
                    groupValue: radioOrderId,
                    value: radionOrderBtn.index,
                    dense: true,
                    activeColor: getColorByHex(Globle().colorscode),
                    onChanged: (val) {
                      setState(() {
                        radioOrderItem = radionOrderBtn.title;
                        radioOrderItemsub = radionOrderBtn.subtitle;
                        radioOrderId = radionOrderBtn.index;
                        radioId = val;

                        // if (val == 2) {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (_) => PaymentTipAndPay(
                        //             items: widget.items,
                        //             latitude: widget.latitude,
                        //             longitude: widget.longitude,
                        //             orderType: widget.orderType,
                        //             price: widget.price,
                        //             restId: widget.restId,
                        //             tableId: widget.tableId,
                        //             tablename: widget.tablename,
                        //             totalAmount: widget.totalAmount,
                        //             userId: widget.userId,
                        //             itemdata: widget.itemdata,
                        //             currencySymbol: widget.currencySymbol,
                        //           )));
                        // }

                        // if (radioOrderItem == 'Dine-in') {
                        //   getTableAlert();
                        // }
                      });
                    },
                  ),
                ),
              ))
          .toList(),
    );
  }

  void showAlertSuccess(String title, String message, BuildContext context) {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StatusTrackView(
                              tableId: widget.tableId,
                              orderID: myOrderData.id,
                              title: widget.restName,
                              tableName: widget.tablename,
                              // restID: widget.restId,
                              flag: 1,
                              // totalamount: double.parse(
                              //     widget.itemdata[i].totalAmount.toString()),
                              // amount:
                              //     double.parse(widget.itemdata[i].sizePrice),
                            )));
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void placeOrderfailed() {
    // TODO: implement placeOrderfailed
    Preference.setPersistData(null, PreferenceKeys.restaurantID);
    Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
    //Preference.setPersistData(null, PreferenceKeys.ORDER_ID);
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
  }

  @override
  void placeOrdersuccess(OrderData orderData) {
    // TODO: implement placeOrdersuccess
    print("Place ORDER SUCCESS.");
    setState(() {
      if (myOrderData == null) {
        myOrderData = orderData;
      }
    });
    Preference.setPersistData(null, PreferenceKeys.restaurantID);
    Preference.setPersistData(null, PreferenceKeys.isAlreadyINCart);
    // Preference.setPersistData(null, PreferenceKeys.ORDER_ID);
    Globle().orderNumber = orderData.orderNumber;
    Globle().dinecartValue = 0;
    Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();
    showAlertSuccess(
        "Order Placed", "Your order has been successfully placed.", context);
  }

  @override
  void addPeopleFailed() {}

  @override
  void addPeopleSuccess() {
    // showAddPeopleAlertSuccess("Invitation Send","Invitation has been send Successfully!!",context);
  }

  @override
  void getPeopleListonFailed() {}

  @override
  void getPeopleListonSuccess(List<Data> data) {
    // if (data.length == 0) {
    //   return;
    // }
    // setState(() {
    //   if (peopleList == null) {
    //     peopleList = data;
    //   } else {
    //     peopleList.addAll(data);
    //   }
    // });
    // print("data list --->");
    // print(peopleList.length);
    // print(peopleList.elementAt(0).firstName);
    // Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
  }

  @override
  void getInvitedPeopleFailed() {
    // TODO: implement getInvitedPeopleFailed
  }

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

    print("invite peopl list length-->");
    print(invitePeopleList.length);
    print(invitePeopleList[0].toUser.firstName);
  }

  @override
  void getOrderStatusfailed() {}

  @override
  void getOrderStatussuccess(StatusData statusData) {}
}

class RadioButtonOptions {
  int index;
  String title;
  RadioButtonOptions({this.index, this.title});
}

class RadioButtonOrderOptions {
  int index;
  String title;
  String subtitle;
  RadioButtonOrderOptions({this.index, this.title, this.subtitle});
}
