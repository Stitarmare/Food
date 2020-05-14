import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/DeliveryFoodView/DeliveryFoodView.dart';
import 'package:foodzi/DineInPage/DineInView.dart';
import 'package:foodzi/MyOrderTakeAway/MyOrderTakeAway.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/MyprofileBottompage/MyprofileBottompage.dart';
import 'package:foodzi/NotificationBottomPage/NotificationBottomPage.dart';
import 'package:foodzi/TakeAwayPage/TakeAwayView.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class BottomTabbar extends StatefulWidget {
  int tabValue = 0;
  String tableName;
  int flag;
  BottomTabbar({this.tabValue, this.tableName, this.flag});
  @override
  State<StatefulWidget> createState() {
    return _BottomTabbarState();
  }
}

class _BottomTabbarState extends State<BottomTabbar> {
  int currentTabIndex = 0;
  bool isAlreadyOrder = false;
  bool cartStatus = false;
  List<Widget> tabsDineIn = [
    DineInView(),
    MyOrders(),
    BottomNotificationView(),
    BottomProfileScreen(),
  ];
  List<Widget> tabsTakeAway = [
    TakeAwayView(),
    MyOrderTakeAway(),
    BottomNotificationView(),
    BottomProfileScreen()
  ];

  List<Widget> tabsDeliveryFood = [
    DeliveryFoodView(),
    MyOrders(),
    BottomNotificationView(),
    BottomProfileScreen(),
  ];
  onTapIndex(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.tableName != null) {
      setState(() {
        tabsDineIn.setAll(1, [
          MyOrders(
            tableName: widget.tableName,
          )
        ]);

        tabsDineIn.setAll(0, [
          DineInView(
            tableName: widget.tableName,
          )
        ]);
      });
    }
    getOrderID();
    getAlreadyInCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.flag != 1
          ? widget.tabValue == 0
              ? tabsDineIn[currentTabIndex]
              : tabsTakeAway[currentTabIndex]
          : tabsDeliveryFood[currentTabIndex],
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
                title: Text(STR_BLANK)),
            BottomNavigationBarItem(
                icon: (isAlreadyOrder && widget.tabValue == 0)
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
                activeIcon: (isAlreadyOrder && widget.tabValue == 0)
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
                        OMIcons.assignment,
                        color: orangetheme,
                        size: 30,
                      ),
                title: Text(STR_BLANK)),
            BottomNavigationBarItem(
                icon: (Globle().notificationFLag && widget.tabValue == 0)
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
                title: Text(STR_BLANK)),
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
}
