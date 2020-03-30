import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/MyCart/MyCartView.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/MyprofileBottompage/MyprofileBottompage.dart';
import 'package:foodzi/NotificationBottomPage/NotificationBottomPage.dart';
import 'package:foodzi/RestaurantPage/RestaurantView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class BottomTabbarHome extends StatefulWidget {
  String title;
  int restId;
  String lat;
  String long;
  String imageUrl;
  String tableName;
  BottomTabbarHome(
      {this.title,
      this.restId,
      this.lat,
      this.long,
      this.imageUrl,
      this.tableName});
  @override
  State<StatefulWidget> createState() {
    return _BottomTabbarHomeState();
  }
}

class _BottomTabbarHomeState extends State<BottomTabbarHome> {
  var title;
  int currentTabIndex = 0;
  bool isAlreadyOrder = false;
  List<Widget> tabsHome = [
    RestaurantView(),
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
    if (widget.title != null) {
      setState(() {
        tabsHome.setAll(0, [
          RestaurantView(
            title: widget.title,
            restId: widget.restId,
            imageUrl: widget.imageUrl,
          )
        ]);
      });
    }

    if (widget.tableName != null) {
      setState(() {
        tabsHome.setAll(1, [MyOrders(tableName: widget.tableName)]);
      });
    }
    getOrderID();
    getCartCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: 60,
        height: 120,
        child: Column(
          children: <Widget>[
            FittedBox(
              child: FloatingActionButton(
                  backgroundColor: getColorByHex(Globle().colorscode),
                  onPressed: () {},
                  heroTag: STR_BTN_BUZZER,
                  child: Image.asset(CLOCK_IMAGE_PATH)),
            ),
            SizedBox(
              height: 5,
            ),
            FittedBox(
              child: FloatingActionButton(
                  backgroundColor: getColorByHex(Globle().colorscode),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyCartView(
                                  restId: widget.restId,
                                  lat: widget.lat,
                                  long: widget.long,
                                  orderType: STR_SMALL_DINEIN,
                                  restName: widget.title,
                                )));
                  },
                  heroTag: STR_BTN_ADD_CART,
                  child: Stack(
                    fit: StackFit.passthrough,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Icon(Icons.shopping_cart, color: Colors.white),
                      (Globle().dinecartValue != null)
                          ? Globle().dinecartValue > 0
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
                icon: Icon(
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
    if (alreadyIncartStatus == true) {
      setState(() {
        cartStatus = true;
      });
    }
  }

  getOrderID() async {
    var orderId = await Preference.getPrefValue<int>(PreferenceKeys.orderId);
    if (orderId != null) {
      setState(() {
        isAlreadyOrder = true;
      });
    }
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
}
