import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/MyCartTW/MyCartTWView.dart';
import 'package:foodzi/MyOrderTakeAway/MyOrderTakeAway.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/MyprofileBottompage/MyprofileBottompage.dart';
import 'package:foodzi/NotificationBottomPage/NotificationBottomPage.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantViewTA.dart';
import 'package:foodzi/Utils/String.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/Utils/shared_preference.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class TakeAwayBottombar extends StatefulWidget {
  String title;
  int restId;
  String lat;
  String long;
  String imageUrl;
  TakeAwayBottombar(
      {this.title, this.restId, this.lat, this.long, this.imageUrl});
  @override
  State<StatefulWidget> createState() {
    return _TakeAwayBottombarState();
  }
}

class _TakeAwayBottombarState extends State<TakeAwayBottombar> {
  var title;
  int currentTabIndex = 0;
  Stream stream;
  bool cartStatus = false;
  StreamSubscription<double> _streamSubscription;
  List<Widget> tabsHome = [
    RestaurantTAView(),
    MyOrderTakeAway(),
    BottomNotificationView(),
    BottomProfileScreen()
  ];
  onTapIndex(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.title != null) {
      setState(() {
        tabsHome.setAll(0, [
          RestaurantTAView(
            title: widget.title,
            restId: widget.restId,
            imageUrl: widget.imageUrl,
          )
        ]);
      });
    }
    onStreamListen();
    getCartCount();
    getAlreadyInCart();
  }

   onStreamListen() {
    if (stream != null) {
      _streamSubscription = stream.listen((onData) {
        // callApi();
        Globle().notificationFLag = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //_streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          //  Container(
          //   width: 60,
          //   height: 120,
          //   child: Column(
          //     children: <Widget>[
          // FittedBox(
          //   child: FloatingActionButton(
          //       backgroundColor: getColorByHex(Globle().colorscode),
          //       onPressed: () {},
          //       heroTag: STR_BTN_BUZZER,
          //       child: Image.asset(CLOCK_IMAGE_PATH)),
          // ),
          // SizedBox(
          //   height: 5,
          // ),
          // FittedBox(
          //   child:
          FloatingActionButton(
              backgroundColor: getColorByHex(Globle().colorscode),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyCartTWView(
                              restName: widget.title,
                              restId: widget.restId,
                              lat: widget.lat,
                              long: widget.long,
                              orderType: STR_TAKE_AWAY,
                            )));
              },
              heroTag: STR_BTN_ADD_CART,
              child: Stack(
                fit: StackFit.passthrough,
                overflow: Overflow.visible,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  (Globle().dinecartValue != null)
                      ? Globle().dinecartValue > 0 && cartStatus
                          ? Positioned(
                              top: -20,
                              right: -15,
                              child: Badge(
                                  badgeColor: redtheme,
                                  badgeContent: Text(
                                      "${Globle().takeAwayCartItemCount} ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white))))
                          : Text(STR_BLANK)
                      : Text(STR_BLANK)
                ],
              )),
      //       ),
      //     ],
      //   ),
      // ),
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
                icon: Icon(
                  OMIcons.assignment,
                  color: greytheme100,
                  size: 30,
                ),
                activeIcon: Icon(
                  OMIcons.assignment,
                  color: orangetheme,
                  size: 30,
                ),
                title: Text('')),
            BottomNavigationBarItem(
                icon:  (Globle().notificationFLag)?
                Stack(fit: StackFit.passthrough,
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
                ],):Icon(
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

  getAlreadyInCart() async {
    
    var restId = await Preference.getPrefValue<int>( PreferenceKeys.restaurantID);
    if (restId != null) {
if (restId == widget.restId) {
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

  getCartCount() async {
    var cartCount =
        await Preference.getPrefValue<int>(PreferenceKeys.takeAwayCartCount);
    if (cartCount != null) {
      setState(() {
        Globle().takeAwayCartItemCount = cartCount;
      });
      return cartCount;
    }
    return;
  }
}
