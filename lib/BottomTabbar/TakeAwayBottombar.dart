import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:foodzi/MyCartTW/MyCartTWView.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/MyprofileBottompage/MyprofileBottompage.dart';
import 'package:foodzi/NotificationBottomPage/NotificationBottomPage.dart';
//import 'package:foodzi/DineInPage/DineInView.dart';
import 'package:foodzi/Notifications/NotificationView.dart';
import 'package:foodzi/ProfilePage/ProfileScreen.dart';
import 'package:foodzi/ResetPassword/ResetPassView.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/RestaurantPageTakeAway/RestaurantViewTA.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class TakeAwayBottombar extends StatefulWidget {
  String title;
  int rest_Id;
  String lat;
  String long;
  String imageUrl;
  TakeAwayBottombar(
      {this.title, this.rest_Id, this.lat, this.long, this.imageUrl});
  @override
  State<StatefulWidget> createState() {
    return _TakeAwayBottombarState();
  }
}

class _TakeAwayBottombarState extends State<TakeAwayBottombar> {
  var title;
  int currentTabIndex = 0;
  List<Widget> tabsHome = [
    RestaurantTAView(),
    MyOrders(),
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
    // TODO: implement initState
    if (widget.title != null) {
      setState(() {
        tabsHome.setAll(0, [
          RestaurantTAView(
            title: widget.title,
            rest_Id: widget.rest_Id,
            imageUrl: widget.imageUrl,
          )
        ]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Container(
      //   width: 60,
      //   height: 60,
      //   child: FittedBox(
      //     child: FloatingActionButton(
      //         backgroundColor: orangetheme,
      //         onPressed: () {},
      //         child: Image.asset('assets/ClockIcon/clock.png')),
      //   ),
      // ),
      floatingActionButton: Container(
        width: 60,
        height: 120,
        child: Column(
          children: <Widget>[
            FittedBox(
              child: FloatingActionButton(
                  backgroundColor: getColorByHex(Globle().colorscode),
                  onPressed: () {
                    print("1");
                  },
                  heroTag: "btnBuzzer",
                  child: Image.asset('assets/ClockIcon/clock.png')),
            ),
            SizedBox(
              height: 5,
            ),
            FittedBox(
              child: FloatingActionButton(
                  backgroundColor: getColorByHex(Globle().colorscode),
                  onPressed: () {
                    print("2");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyCartTWView(
                                  restId: widget.rest_Id,
                                  lat: widget.lat,
                                  long: widget.long,
                                  orderType: "take_away",
                                )));
                    // Navigator.pushNamed(context, '/OrderConfirmationView');
                  },
                  heroTag: "btnAddCart",
                  child: Stack(
                    fit: StackFit.passthrough,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      (Globle().takeAwayCartItemCount != null)
                          ? Globle().takeAwayCartItemCount > 0
                              ? Positioned(
                                  top: -20,
                                  right: -15,
                                  child: Badge(
                                      badgeColor: redtheme,
                                      badgeContent: Text(
                                          "${Globle().takeAwayCartItemCount} ",
                                          textAlign: TextAlign.center,
                                          style:
                                              TextStyle(color: Colors.white)))
                                  //    Container(
                                  //   height: 20,
                                  //   width: 20,
                                  //   decoration: BoxDecoration(color: Colors.red),
                                  // )
                                  )
                              : Text("")
                          : Text("")
                    ],
                  )),
            ),
          ],
        ),
      ),
      body: tabsHome[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          //selectedItemColor: orangetheme,
          onTap: onTapIndex,
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                //icon: Image.asset('assets/HomeIcon/home(2).png'),
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
                title: Text('')
                //icon: Image.asset('assets/OrderIcon/order.png'),
                // icon: Icon(
                //   OMIcons.assignment,
                //   color: greytheme100,
                //   size: 30,
                // ),
                // icon: Stack(
                //   fit: StackFit.passthrough,
                //   overflow: Overflow.visible,
                //   children: <Widget>[
                //     Icon(OMIcons.assignment, color: greytheme100,size: 30,),
                //     Positioned(
                //         top: -11,
                //         right: -11,
                //         child: Badge(
                //             badgeColor: redtheme,
                //             badgeContent: Text("1",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(color: Colors.white))))
                //   ],
                // ),
                // activeIcon: Icon(
                //   OMIcons.assignment,
                //   color: orangetheme,
                //   size: 30,
                // ),
                // activeIcon: Stack(
                //   fit: StackFit.passthrough,
                //   overflow: Overflow.visible,
                //   children: <Widget>[
                //     Icon(OMIcons.assignment, color: orangetheme,size: 30,),
                //     Positioned(
                //         top: -11,
                //         right: -11,
                //         child: Badge(
                //             badgeColor: redtheme,
                //             badgeContent: Text("1",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(color: Colors.white))))
                //   ],
                // ),
                // title: Text('')
                ),
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
                //icon: Image.asset('assets/NotificationIcon/Path1159.png'),
                // icon: Stack(
                //   fit: StackFit.passthrough,
                //   overflow: Overflow.visible,
                //   children: <Widget>[
                //     Icon(OMIcons.notifications, color: greytheme100,size: 30,),
                //     Positioned(
                //         top: -10,
                //         right: -10,
                //         child: Badge(
                //             badgeColor: redtheme,
                //             badgeContent: Text("1",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(color: Colors.white))))
                //   ],
                // ),
                // activeIcon: Stack(
                //   fit: StackFit.passthrough,
                //   overflow: Overflow.visible,
                //   children: <Widget>[
                //     Icon(OMIcons.notifications, color: orangetheme,size: 30,),
                //     Positioned(
                //         top: -10,
                //         right: -10,
                //         child: Badge(
                //             badgeColor: redtheme,
                //             badgeContent: Text("1",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(color: Colors.white))))
                //   ],
                // ),
                title: Text('')),
            BottomNavigationBarItem(
                //icon: Image.asset('assets/UserIcon/Group3.png'),
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
                title: Text('')),
          ]),
    );
  }
}
