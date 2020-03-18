import 'package:flutter/material.dart';
import 'package:foodzi/Models/CurrentOrderModel.dart';
import 'package:foodzi/Models/GetMyOrdersBookingHistory.dart';
import 'package:foodzi/Models/OrderDetailsModel.dart';
import 'package:foodzi/MyOrders/MyOrderContractor.dart';
import 'package:foodzi/MyOrders/MyOrdersPresenter.dart';
import 'package:foodzi/StatusTrackPage/StatusTrackView.dart';
import 'package:foodzi/Utils/dialogs.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';

class MyOrders extends StatefulWidget {
  String title;
  String ordertype;
  // String lat;
  // String long;
  MyOrders({this.title, this.ordertype});
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> implements MyOrderModelView {
  ScrollController _controller = ScrollController();
  MyOrdersPresenter _myOrdersPresenter;
  bool isCurrentOrders = true;
  bool isBookingHistory = false;
  List<CurrentOrderList> _currentOrder;
  List<CurrentOrderList> _orderHistory;
  int i;
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  List<CurrentOrderList> _orderDetailList;
  List<GetMyOrderBookingHistoryList> getmyOrderBookingHistory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myOrdersPresenter = MyOrdersPresenter(this);
    DialogsIndicator.showLoadingDialog(context, _keyLoader, "");
    // _myOrdersPresenter.getOrderDetails(context);
    _myOrdersPresenter.getOrderDetails("dine_in", context);
    _myOrdersPresenter.getmyOrderBookingHistory(
        "dine_in", context); // order type call is waiting
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0.0,
          title: Text(
            "Your Orders",
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'gotham',
                fontWeight: FontWeight.w500,
                color: greytheme1200),
          ),
        ),
        body: customTabbar(),
      ),
    );
  }

  Widget customTabbar() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Card(
            borderOnForeground: true,
            elevation: 5.0,
            child: Container(
              constraints: BoxConstraints.expand(height: 40),
              child: TabBar(
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        'Current Orders',
                        style: TextStyle(fontFamily: 'gotham', fontSize: 15),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Booking History',
                        style: TextStyle(
                          fontFamily: 'gotham',
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(color: Colors.red, width: 2),
                      insets: EdgeInsets.symmetric(horizontal: 30)),
                  labelColor: Colors.red,
                  unselectedLabelColor: greytheme1000,
                  onTap: (index) {
                    switch (index) {
                      case 0:
                        print('Current Orders');
                        setState(() {
                          isCurrentOrders = true;
                          isBookingHistory = false;
                        });

                        break;
                      case 1:
                        print('Booking History');
                        setState(() {
                          isCurrentOrders = false;
                          isBookingHistory = true;
                        });
                        break;
                    }
                  }),
            ),
          ),
          isCurrentOrders
              ? Center(child: Container(child: _currentOrders(context)))
              : Center(child: Container(child: _bookingHistoryList(context))),
        ],
      ),
    );
  }

  int getLenghtOfCurrentOrder() {
    if (_orderDetailList != null) {
      return _orderDetailList.length;
    }
    return 0;
  }

  String getitemname(List<ListElement> _listitem) {
    var itemname = '';
    for (i = 0; i < _listitem.length; i++) {
      itemname += "${_listitem[i].quantity} x ${_listitem[i].items.itemName}, ";
    }
    if (itemname.isNotEmpty) {
      itemname = removeLastChar(itemname);
      itemname = removeLastChar(itemname);
    }
    return itemname;
  }

  static String removeLastChar(String str) {
    return str.substring(0, str.length - 1);
  }

  Widget _currentOrders(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.70,
        child: ListView.builder(
          itemCount: getLenghtOfCurrentOrder(),
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StatusTrackView(
                              tableId: _orderDetailList[index].tableId,
                              orderID: _orderDetailList[index].id,
                              flag: 2,
                              rest_id: _orderDetailList[index].restId,
                              title:
                                  _orderDetailList[index].restaurant.restName,
                            )));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(4),
                ),
                elevation: 5,
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(left: 15, top: 8),
                          child: ClipRRect(
                            child: Image.asset(
                              'assets/HotelImages/Image12.png',
                              fit: BoxFit.fill,
                            ),
                            borderRadius:
                                new BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                '${_orderDetailList[index].restaurant.restName}',
                                style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 0.32,
                                    color: greytheme700,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 10),
                            //   child: Text(
                            //     'Airoli, Navi Mumbai', // address
                            //     style: TextStyle(
                            //       fontSize: 14,
                            //       letterSpacing: 0.24,
                            //       color: greytheme1000,
                            //     ),
                            //   ),
                            // )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 15),
                      child: Text(
                        'ITEMS',
                        style: TextStyle(
                          fontSize: 14,
                          //letterSpacing: 0.24,
                          color: greytheme1000,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '${getitemname(_orderDetailList[index].list)}',
                        style: TextStyle(
                          fontSize: 16,
                          //letterSpacing: 0.24,
                          fontWeight: FontWeight.w500,
                          color: greytheme700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Text(
                        'ORDERED ON ',
                        style: TextStyle(
                          fontSize: 14,
                          //letterSpacing: 0.24,
                          color: greytheme1000,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '${_orderDetailList[index].createdAt}',
                        style: TextStyle(
                          fontSize: 16,
                          //letterSpacing: 0.24,
                          fontWeight: FontWeight.w500,
                          color: greytheme700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Text(
                        'ORDERED TYPE',
                        style: TextStyle(
                          fontSize: 14,
                          //letterSpacing: 0.24,
                          color: greytheme1000,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '${_orderDetailList[index].orderType}',
                        style: TextStyle(
                          fontSize: 16,
                          //letterSpacing: 0.24,
                          fontWeight: FontWeight.w500,
                          color: greytheme700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Text(
                        'TOTAL AMOUNT',
                        style: TextStyle(
                          fontSize: 14,
                          //letterSpacing: 0.24,
                          color: greytheme1000,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '${_orderDetailList[index].totalAmount}',
                        style: TextStyle(
                          fontSize: 16,
                          //letterSpacing: 0.24,
                          fontWeight: FontWeight.w500,
                          color: greytheme700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                      child: Text(
                        'Status : ${_orderDetailList[index].status}',
                        style: TextStyle(color: greytheme400, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  int getLenghtOfHistoryOrder() {
    if (getmyOrderBookingHistory != null) {
      return getmyOrderBookingHistory.length;
    }
    return 0;
  }

  String getBookingHistoryitemname(List<GetMyOrderBookingList> _listitem) {
    var itemname = '';
    for (i = 0; i < _listitem.length; i++) {
      itemname += "${_listitem[i].quantity} x ${_listitem[i].items.itemName}, ";
    }
    if (itemname.isNotEmpty) {
      itemname = removeLastChar(itemname);
      itemname = removeLastChar(itemname);
    }
    return itemname;
  }

  static String removeLastChars(String str) {
    return str.substring(0, str.length - 1);
  }

  Widget _bookingHistoryList(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.70,
        child: ListView.builder(
          itemCount: getLenghtOfHistoryOrder(),
          controller: _controller,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(4),
              ),
              elevation: 5,
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(left: 15, top: 8),
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/HotelImages/Image12.png',
                            fit: BoxFit.fill,
                          ),
                          borderRadius:
                              new BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              '${getmyOrderBookingHistory[index].restaurant.restName}',
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 0.32,
                                  color: greytheme700,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 10),
                          //   child: Text(
                          //     'Airoli, Navi Mumbai',
                          //     style: TextStyle(
                          //       fontSize: 14,
                          //       letterSpacing: 0.24,
                          //       color: greytheme1000,
                          //     ),
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15),
                    child: Text(
                      'ITEMS',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '${getBookingHistoryitemname(getmyOrderBookingHistory[index].list)}',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'ORDERED ON ',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '06 Feb 2020 at 12:05 PM',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'ORDERED TYPE',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '${getmyOrderBookingHistory[index].status}',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Text(
                      'TOTAL AMOUNT',
                      style: TextStyle(
                        fontSize: 14,
                        //letterSpacing: 0.24,
                        color: greytheme1000,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      '${getmyOrderBookingHistory[index].totalAmount}',
                      style: TextStyle(
                        fontSize: 16,
                        //letterSpacing: 0.24,
                        fontWeight: FontWeight.w500,
                        color: greytheme700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      ClipOval(
                        child: Container(
                          height: 10,
                          width: 10,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${getmyOrderBookingHistory[index].status}',
                        style: TextStyle(color: greytheme400, fontSize: 18),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: GestureDetector(
                          onTap: () {
                            print("object");
                          },
                          child: Text('Repeat Order'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          },
        ));
  }

  @override
  void getOrderDetailsFailed() {
    // TODO: implement getOrderDetailsFailed
  }

  @override
  void getOrderDetailsSuccess(List<CurrentOrderList> _orderdetailsList) {
    if (_orderdetailsList.length == 0) {
      return;
    }

    setState(() {
      if (_orderdetailsList.length != null) {
        _orderDetailList = _orderdetailsList;
      }
    });
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    Preference.setPersistData<int>(
        _orderDetailList[0].id, PreferenceKeys.CURRENT_ORDER_ID);
    Preference.setPersistData<int>(
        _orderDetailList[0].restId, PreferenceKeys.CURRENT_RESTAURANT_ID);

    // TODO: implement getOrderDetailsSuccess
  }

  //List<CurrentOrderList> _orderdetailsList)
  // {
  //   if (_orderdetailsList.length == 0) {
  //     return;
  //   }

  //   setState(() {
  //     _orderDetailList = _orderdetailsList;
  //   });

  //   // TODO: implement getOrderDetailsSuccess
  //}

  @override
  void getmyOrderHistoryFailed() {
    // TODO: implement getmyOrderHistoryFailed
  }

  @override
  void getmyOrderHistorySuccess(
      List<GetMyOrderBookingHistoryList> _getmyOrderBookingHistory) {
    Navigator.of(_keyLoader.currentContext, rootNavigator: true)..pop();
    if (_getmyOrderBookingHistory.length == 0) {
      return;
    }
    setState(() {
      getmyOrderBookingHistory = _getmyOrderBookingHistory;
    });
    // TODO: implement getmyOrderHistorySuccess
  }

  // Widget getOrderList() {
  //   return
  // }

}
