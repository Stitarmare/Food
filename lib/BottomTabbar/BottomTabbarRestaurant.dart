import 'package:flutter/material.dart';
import 'package:foodzi/MyCart/MyCartView.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/MyprofileBottompage/MyprofileBottompage.dart';
import 'package:foodzi/NotificationBottomPage/NotificationBottomPage.dart';
//import 'package:foodzi/DineInPage/DineInView.dart';
import 'package:foodzi/RestaurantPage/RestaurantView.dart';
import 'package:foodzi/Notifications/NotificationView.dart';
import 'package:foodzi/ProfilePage/ProfileScreen.dart';
import 'package:foodzi/ResetPassword/ResetPassView.dart';
import 'package:foodzi/MyOrders/MyOrders.dart';
import 'package:foodzi/Utils/globle.dart';
import 'package:foodzi/theme/colors.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class BottomTabbarHome extends StatefulWidget {
  String title;
  int rest_Id;
  BottomTabbarHome({this.title, this.rest_Id});
  @override
  State<StatefulWidget> createState() {
    return _BottomTabbarHomeState();
  }
}

class _BottomTabbarHomeState extends State<BottomTabbarHome> {
  var title;
  int currentTabIndex = 0;
  List<Widget> tabsHome = [
    RestaurantView(),
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
          RestaurantView(
            title: widget.title,
            rest_Id: widget.rest_Id,
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
                    // Navigator.pushNamed(context, '/OrderConfirmationView');
                    
                  },
                  heroTag: "btnAddCart",
                  child: Icon(Icons.shopping_cart, color: Colors.white)),
            ),
            //
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
                //icon: Image.asset('assets/OrderIcon/order.png'),
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
                //icon: Image.asset('assets/NotificationIcon/Path1159.png'),
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
