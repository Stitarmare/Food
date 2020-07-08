import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/CartDetailsPage/CartDetailsPage.dart';
import 'package:foodzi/Models/RestaurantItemsList.dart';
import 'package:foodzi/Models/RestaurantListModel.dart';
import 'package:foodzi/MyCart/MyCartView.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/MyprofileBottompage/MyprofileBottompage.dart';
import 'package:foodzi/NotificationBottomPage/NotificationBottomPage.dart';
import 'package:foodzi/RestaurantPage/RestaurantContractor.dart';
import 'package:foodzi/RestaurantPage/RestaurantPresenter.dart';
import 'package:foodzi/RestaurantPage/RestaurantView.dart';
import 'package:foodzi/SubCategory/CategoriesSection.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/constant.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:toast/toast.dart';

class BottomTabbarHome extends StatefulWidget {
  String title;
  int restId;
  String lat;
  String long;
  String imageUrl;
  String tableName;
  bool isFromOrder;
  RestaurantList restaurantList;
  int flag;
  BottomTabbarHome(
      {this.title,
      this.restId,
      this.lat,
      this.long,
      this.imageUrl,
      this.restaurantList,
      this.flag,
      this.isFromOrder,
      this.tableName});
  @override
  State<StatefulWidget> createState() {
    return _BottomTabbarHomeState();
  }
}

class _BottomTabbarHomeState extends State<BottomTabbarHome>
    implements RestaurantModelView {
  var title;
  int tableID;
  int orderID;
  RestaurantPresenter restaurantPresenter;
  int currentTabIndex = 0;
  bool isAlreadyOrder = false;
  Stream stream;
  StreamSubscription<double> _streamSubscription;
  List<Widget> tabsHome = [
    CategoriesSection(),
    //RestaurantView(),
    MyOrders(),
    BottomNotificationView(),
    BottomProfileScreen()
  ];

  bool cartStatus = false;
  onTapIndex(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  void initState() {
    getAlreadyInCart();
    restaurantPresenter = RestaurantPresenter(this);
    if (widget.title != null) {
      setState(() {
        tabsHome.setAll(0, [
          RestaurantView(
              title: widget.title,
              restId: widget.restId,
              imageUrl: widget.imageUrl,
              isFromOrder: widget.isFromOrder,
              restaurantList: widget.restaurantList)
        ]);
      });
    }
    if (Globle().orderID != null && Globle().orderID != 0) {
      Preference.removeForKey(PreferenceKeys.myCartRestIdKey);
      Preference.removeForKey(PreferenceKeys.myCartRestIdKey);
    }

    if (widget.tableName != null) {
      setState(() {
        tabsHome.setAll(1, [MyOrders(tableName: widget.tableName)]);
      });
    }

    getTableID();
    getOrderID();
    getCartCount();
    onStreamListen();
    super.initState();
  }

  onStreamListen() {
    if (stream != null) {
      _streamSubscription = stream.listen((onData) {
        Globle().notificationFLag = true;
        // callApi();
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getTableID();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getAlreadyInCart();
    return Scaffold(
      floatingActionButton: Container(
        width: 60,
        height: 120,
        child: Column(
          children: <Widget>[
            FittedBox(
              child: FloatingActionButton(
                  backgroundColor: getColorByHex(Globle().colorscode),
                  onPressed: () {
                    if (Globle().isTabelAvailable && Globle().tableID != 0) {
                      restaurantPresenter.notifyWaiter(
                          Globle().loginModel.data.id,
                          Globle().tableID,
                          "",
                          context);
                    }
                  },
                  heroTag: STR_BTN_BUZZER,
                  child: Image.asset(CLOCK_IMAGE_PATH)),
            ),
            SizedBox(
              height: 5,
            ),
            FittedBox(
              child: FloatingActionButton(
                  backgroundColor: getColorByHex(Globle().colorscode),
                  onPressed: () async {
                    // if (Globle().orderID != null && Globle().orderID != 0) {
                    //   var isFromOrder = false;
                    //   var id = await Preference.getPrefValue<int>(
                    //       PreferenceKeys.restaurantID);
                    //   if (id != null) {
                    //     if (widget.restId != id) {
                    //       isFromOrder = true;
                    //     }
                    //   }
                    //   if (Globle().isCollectionOrder) {
                    //   return;
                    // }
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => CartDetailsPage(
                    //                 orderId: Globle().orderID,
                    //                 flag: 2,
                    //                 isFromOrder: isFromOrder,
                    //               )));
                    // } else {
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => MyCartView(
                    //               restId: widget.restId,
                    //               lat: widget.lat,
                    //               long: widget.long,
                    //               orderType: STR_SMALL_DINEIN,
                    //               restName: widget.title,
                    //               imgUrl: widget.imageUrl)));
                    // }
                    setState(() {
                      widget.isFromOrder = false;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyCartView(
                                restId: widget.restId,
                                lat: widget.lat,
                                long: widget.long,
                                isFromOrder: widget.isFromOrder,
                                orderType: STR_SMALL_DINEIN,
                                restName: widget.title,
                                imgUrl: widget.imageUrl)));
                  },
                  heroTag: STR_BTN_ADD_CART,
                  child: Stack(
                    fit: StackFit.passthrough,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Icon(Icons.shopping_cart, color: Colors.white),
                      (Globle().dinecartValue != null)
                          ? Globle().dinecartValue > 0 && cartStatus
                              ? Positioned(
                                  top: -20,
                                  right: -15,
                                  child: Badge(
                                      badgeColor: redtheme,
                                      badgeContent: Text(
                                          "${Globle().dinecartValue} ",
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: Colors.white))))
                              : Text(STR_BLANK)
                          : Text(STR_BLANK)
                    ],
                  )),
            ),
            //
          ],
        ),
      ),
      body: tabsHome[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: onTapIndex,
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  OMIcons.home,
                  color: greytheme100,
                  size: 30,
                ),
                activeIcon: Icon(
                  OMIcons.home,
                  color: orangetheme,
                  size: 30,
                ),
                title: Text('')),
            BottomNavigationBarItem(
                icon: (isAlreadyOrder)
                    ? Stack(
                        fit: StackFit.passthrough,
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Icon(
                            OMIcons.assignment,
                            color: greytheme100,
                            size: 30,
                          ),
                          Positioned(
                            top: -11,
                            right: -11,
                            child: (cartStatus)
                                ? Badge(
                                    badgeColor: redtheme,
                                    badgeContent: Text(STR_ONE,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white)))
                                : Text(STR_BLANK),
                          )
                        ],
                      )
                    : Icon(
                        OMIcons.assignment,
                        color: greytheme100,
                        size: 30,
                      ),
                activeIcon: (isAlreadyOrder)
                    ? Stack(
                        fit: StackFit.passthrough,
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Icon(
                            OMIcons.assignment,
                            color: orangetheme,
                            size: 30,
                          ),
                          Positioned(
                            top: -11,
                            right: -11,
                            child: (cartStatus)
                                ? Badge(
                                    badgeColor: redtheme,
                                    badgeContent: Text(STR_ONE,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white)))
                                : Text(STR_BLANK),
                          )
                        ],
                      )
                    : Icon(
                        OMIcons.assignment,
                        color: orangetheme,
                        size: 30,
                      ),
                title: Text(STR_BLANK)),
            BottomNavigationBarItem(
                icon: (Globle().notificationFLag)
                    ? Stack(
                        fit: StackFit.passthrough,
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Icon(
                            OMIcons.notifications,
                            color: greytheme100,
                            size: 30,
                          ),
                          Positioned(
                              top: -11,
                              right: -11,
                              child: Badge(
                                  badgeColor: redtheme,
                                  badgeContent: Text(STR_ONE,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white)))
                              // : Text(STR_BLANK),
                              )
                        ],
                      )
                    : Icon(
                        OMIcons.notifications,
                        color: greytheme100,
                        size: 30,
                      ),
                activeIcon: Icon(
                  OMIcons.notifications,
                  color: orangetheme,
                  size: 30,
                ),
                title: Text('')),
            BottomNavigationBarItem(
                icon: Icon(
                  OMIcons.personOutline,
                  color: greytheme100,
                  size: 30,
                ),
                activeIcon: Icon(
                  OMIcons.person,
                  color: orangetheme,
                  size: 30,
                ),
                title: Text(STR_BLANK)),
          ]),
    );
  }

  getDineINcartvalue() {
    if (Globle().dinecartValue != null) {
      if (Globle().dinecartValue > 0) {
        return Globle().dinecartValue;
      }
      return;
    }
    return;
  }

  getAlreadyInCart() async {
    var alreadyIncartStatus =
        await Preference.getPrefValue<bool>(PreferenceKeys.isAlreadyINCart);
    var restId =
        await Preference.getPrefValue<int>(PreferenceKeys.restaurantID);
    if (restId != null) {
      if (alreadyIncartStatus == true && restId == widget.restId) {
        setState(() {
          cartStatus = true;
        });
      } else {
        setState(() {
          cartStatus = false;
        });
      }
    }
  }

  getOrderID() async {
    var orderId = await Preference.getPrefValue<int>(PreferenceKeys.orderId);
    if (orderId != null) {
      setState(() {
        isAlreadyOrder = true;
        orderID = orderId;
        Globle().orderID = orderID;
      });
    }
  }

  getTableID() async {
    var tableId = await Preference.getPrefValue<int>(PreferenceKeys.tableId);
    if (tableId != null) {
      setState(() {
        tableID = tableId;
      });
      return tableId;
    }
    return;
  }

  getCartCount() async {
    var cartCount =
        await Preference.getPrefValue<int>(PreferenceKeys.dineCartItemCount);
    if (cartCount != null) {
      setState(() {
        Globle().dinecartValue = cartCount;
      });
      return cartCount;
    }
    return;
  }

  @override
  void getMenuListfailed() {}

  @override
  void getMenuListsuccess(List<RestaurantMenuItem> menulist,
      RestaurantItemsModel restaurantItemsModel) {}

  @override
  void notifyWaiterFailed() {}

  @override
  void notifyWaiterSuccess() {
    if (Globle().context != null) {
      Constants.showAlert("FoodZi", " Notified waiter successfully.", context);
    }
  }
}
